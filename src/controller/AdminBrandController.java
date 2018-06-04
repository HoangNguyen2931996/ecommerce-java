package controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.BrandDao;
import dao.UserDao;
import entities.Brand;
import entities.User;
import utils.LibraryFile;

@Controller
@RequestMapping("/admin/brand")
public class AdminBrandController {
	private final String DIR_UPLOAD = "files";
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private UserDao userDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	}
	@RequestMapping("")
	public String index(ModelMap modelMap){
		modelMap.addAttribute("alBrand", brandDao.getItems());
		return "admin.brand.index";
	}
	@RequestMapping("/add")
	public String add(Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		return "admin.brand.add";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@Valid @ModelAttribute("objBrand") Brand objBrand, BindingResult result ,@RequestParam("picture") CommonsMultipartFile cmf, HttpServletRequest request, RedirectAttributes redirectAttributes){
		if(result.hasErrors()){
			return "admin.brand.add";
		}
		String fileName = cmf.getOriginalFilename();
		if(!fileName.isEmpty()){
			fileName = LibraryFile.rename(fileName);
			String appPath = request.getServletContext().getRealPath("");
			String dirPath = appPath + File.separator + DIR_UPLOAD;
			File saveDirPath = new File(dirPath);
			if(!saveDirPath.exists()){
				saveDirPath.mkdirs();
			}
			String filePath = dirPath + File.separator + fileName;
			File fileUpload = new File(filePath);
			try {
				cmf.transferTo(fileUpload);
				System.out.println(dirPath);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		objBrand.setPicture_brand(fileName);
		if(brandDao.addItem(objBrand)>0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành Công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/brand/add";
	}
	
	@RequestMapping("/edit/{idBrand}")
	public String edit(@PathVariable("idBrand") int idBrand, ModelMap modelMap, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		modelMap.addAttribute("objBrand", brandDao.getItem(idBrand));
		return "admin.brand.edit";
	}
	
	@RequestMapping(value="/edit/{idBrand}", method=RequestMethod.POST)
	public String edit(@Valid @ModelAttribute("objBrand") Brand objBrand,BindingResult result ,@PathVariable("idBrand") int idBrand,@RequestParam("picture") CommonsMultipartFile cmf,HttpServletRequest request ,RedirectAttributes redirectAttributes){
		if(result.hasErrors()){
			return "admin.brand.edit";
		}
		String fileName = cmf.getOriginalFilename();
		Brand objBrandOld = brandDao.getItem(idBrand);
		if(!fileName.isEmpty()){
			fileName = LibraryFile.rename(fileName);
			String appPath = request.getServletContext().getRealPath("");
			String dirPath = appPath + File.separator + DIR_UPLOAD;
			File saveDirPath = new File(dirPath);
			if(!saveDirPath.exists()){
				saveDirPath.mkdirs();
			}
			String filePath = dirPath + File.separator + fileName;
			File fileUpload = new File(filePath);
			try {
				cmf.transferTo(fileUpload);
				System.out.println(dirPath);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String oldPicture = objBrandOld.getPicture_brand();
			if(!"".equals(oldPicture)){
				String filePath_old = dirPath + File.separator + oldPicture;
				File delFile = new File(filePath_old);
				delFile.delete();
			}
		}else{
			fileName = objBrandOld.getPicture_brand();
		}
		objBrand.setId_brand(idBrand);
		objBrand.setPicture_brand(fileName);
		if(brandDao.edit(objBrand) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/brand";
	}
	
	@RequestMapping("/del/{idBrand}")
	public String del(@PathVariable("idBrand") int idBrand, RedirectAttributes redirectAttributes, HttpServletRequest request, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		String old_picture = brandDao.getItem(idBrand).getPicture_brand();
		if(brandDao.del(idBrand) > 0){
			if(!"".equals(old_picture)){
				String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_picture;
				File delFile = new File(dirFile_old);
				delFile.delete();
			}
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/brand";
	}
}
