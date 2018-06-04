package controller;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.UserDao;
import entities.User;
import utils.StringUtils;

@Controller
@RequestMapping("admin/user")
public class AdminUserController {
	@Autowired
	private Defines defines;
	@Autowired
	private UserDao userDao;
	@Autowired
	private StringUtils stringUtils;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap, Principal principal){
		int row_count = defines.getROW_COUNT_ADMIN();
		int totalPage = (int)Math.ceil((float)userDao.getSumAll()/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1)*row_count;
		modelMap.addAttribute("sobjUser", userDao.getItemByUsername(principal.getName()));
		modelMap.addAttribute("alUser", userDao.getItems(offset, row_count));
		modelMap.addAttribute("sumPage", totalPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_PUBLIC());
		return "admin.user.index";
	}
	@RequestMapping("/add")
	public String add(ModelMap modelMap, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("sobjUser", sobjUser);
		return "admin.user.add";
	}
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@Valid @ModelAttribute("objUser") User objUser,BindingResult result ,RedirectAttributes redirectAttributes){
		if(result.hasErrors()){
			return "admin.user.add";
		}
		if(!userDao.checkUsername(objUser.getUsername())){
			redirectAttributes.addFlashAttribute("msg","Username đã tồn tại");
			return "redirect:/admin/user/add";
		}
		objUser.setPassword(stringUtils.md5(objUser.getPassword()));
		if(userDao.addItem(objUser)>0){
			redirectAttributes.addFlashAttribute("message", "Thêm thành công");
		} else{
			redirectAttributes.addFlashAttribute("message", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/user/add";
	}
	@RequestMapping("/edit/{idUser}")
	public String edit(@PathVariable("idUser") int idUser, ModelMap modelMap, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		User objUser = userDao.getItem(idUser);
		switch(sobjUser.getRole()){
			case "Admin":
				if(!"admin".equals(sobjUser.getUsername()) && ("Admin".equals(objUser.getRole()) && sobjUser.getId_user() != idUser)){
					return "redirect:/admin/err403";
				}
				break;
			case "Mod":
				if("Admin".equals(objUser.getRole()) || ("Mod".equals(objUser.getRole()) && sobjUser.getId_user() != idUser)){
					return "redirect:/admin/err403";
				}
				break;
		}
		modelMap.addAttribute("sobjUser", sobjUser);
		modelMap.addAttribute("objUser", objUser);
		return "admin.user.edit";
	}
	@RequestMapping(value="/edit/{idUser}", method=RequestMethod.POST)
	public String edit(@ModelAttribute("objUser") User objUser,@PathVariable("idUser") int idUser, RedirectAttributes redirectAttributes){
		objUser.setId_user(idUser);
		if(!objUser.getPassword().isEmpty()){
			objUser.setPassword(stringUtils.md5(objUser.getPassword()));
		} else{
			objUser.setPassword(userDao.getItem(idUser).getPassword());
		}
		if(userDao.editItem(objUser) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công!");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Có lỗi trong quá trình xử lý!");
		}
		return "redirect:/admin/user";
	}
	@RequestMapping("/del/{idUser}")
	public String del(@PathVariable("idUser") int idUser, RedirectAttributes redirectAttributes, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		User objUser = userDao.getItem(idUser);
		switch(sobjUser.getRole()){
			case "Admin":
				if(!"admin".equals(sobjUser.getUsername()) && ("Admin".equals(objUser.getRole()))){
					return "redirect:/admin/err403";
				}
				break;
			case "Mod":
				if("Admin".equals(objUser.getRole()) || ("Mod".equals(objUser.getRole()))){
					return "redirect:/admin/err403";
				}
				break;
		}
		if(!"admin".equals(userDao.getItem(idUser).getUsername())){
			if(userDao.delItem(idUser) > 0){
				redirectAttributes.addFlashAttribute("msg", "Xóa thành công!");
			} else{
				redirectAttributes.addFlashAttribute("msg", "Có lỗi trong quá trình xử lý!");
			}
		} else{
			redirectAttributes.addFlashAttribute("msg", "Bạn không có quyền xóa!");
		}
		return "redirect:/admin/user";
	}
}