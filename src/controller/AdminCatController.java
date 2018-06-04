package controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.CatDao;
import dao.UserDao;
import entities.Cat;
import entities.User;

@Controller
@RequestMapping("/admin/cat")
public class AdminCatController {
	@Autowired
	private Defines defines;
	@Autowired
	private CatDao catDao;
	@Autowired
	private UserDao userDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	}
	@RequestMapping("")
	public String index(ModelMap modelMap){
		modelMap.addAttribute("alCat", catDao.getItems());
		return "admin.cat.index";
	}
	@RequestMapping("/add")
	public String add(ModelMap modelMap, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		modelMap.addAttribute("alCat", catDao.getItems());
		return "admin.cat.add";
	}
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@ModelAttribute("objCat") Cat objCat, RedirectAttributes redirectAttributes){
		if(catDao.addItem(objCat)>0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành Công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/cat/add";
	}
	@RequestMapping("/edit/{idCat}")
	public String edit(@PathVariable("idCat") int idCat, ModelMap modelMap, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		modelMap.addAttribute("objCat", catDao.getItem(idCat));
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		return "admin.cat.edit";
	}
	@RequestMapping(value="/edit/{idCat}", method=RequestMethod.POST)
	public String edit(@ModelAttribute("objCat") Cat objCat, @PathVariable("idCat") int idCat, RedirectAttributes redirectAttributes){
		objCat.setId_cat(idCat);
		if(catDao.edit(objCat) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/cat";
	}
	
	@RequestMapping("/del/{idCat}")
	public String del(@PathVariable("idCat") int idCat, RedirectAttributes redirectAttributes, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		int idParent = catDao.getItem(idCat).getId_parent();
		if(catDao.del(idCat) > 0){
			catDao.updateItems(idCat, idParent);
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/cat";
	}
}
