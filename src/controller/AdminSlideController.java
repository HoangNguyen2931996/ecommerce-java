package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.ProductDao;
import dao.SlideDao;
import entities.Slide;
import utils.LibraryFile;

@Controller
@RequestMapping("admin/slide")
public class AdminSlideController {
	private final String DIR_UPLOAD = "files";
	@Autowired
	private Defines defines;
	@Autowired
	private ProductDao productDao;

	@Autowired
	private SlideDao slideDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(ModelMap modelMap){
		modelMap.addAttribute("alSlide", slideDao.getItems());
		return "admin.slide.index";
	}
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.addAttribute("alProduct", productDao.getAllItem());
		return "admin.slide.add";
	}
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@ModelAttribute("objSlide") Slide objSlide,@RequestParam("picture") CommonsMultipartFile cmf, HttpServletRequest request, RedirectAttributes redirectAttributes){
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
		objSlide.setPic_slide(fileName);
		if(slideDao.addItem(objSlide)>0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành Công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/slide/add";
	}
	@RequestMapping("/edit/{idSlide}")
	public String edit(@PathVariable("idSlide") int idSlide, ModelMap modelMap){
		modelMap.addAttribute("alProduct", productDao.getAllItem());
		modelMap.addAttribute("objSlide", slideDao.getItem(idSlide));
		return "admin.slide.edit";
	}
	@RequestMapping(value="/edit/{idSlide}", method=RequestMethod.POST)
	public String edit(@ModelAttribute("objSlide") Slide objSlide, @PathVariable("idSlide") int idSlide,@RequestParam("picture") CommonsMultipartFile cmf,HttpServletRequest request ,RedirectAttributes redirectAttributes){
		String fileName = cmf.getOriginalFilename();
		Slide objSlideOld = slideDao.getItem(idSlide);
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
			String oldPicture = objSlideOld.getPic_slide();
			if(!"".equals(oldPicture)){
				String filePath_old = dirPath + File.separator + oldPicture;
				File delFile = new File(filePath_old);
				delFile.delete();
			}
		}else{
			fileName = objSlideOld.getPic_slide();
		}
		objSlide.setId_slide(idSlide);
		objSlide.setPic_slide(fileName);
		if(slideDao.edit(objSlide) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/slide";
	}
	@RequestMapping("/del/{idSlide}")
	public String del(@PathVariable("idSlide") int idSlide, RedirectAttributes redirectAttributes, HttpServletRequest request){
		String old_picture = slideDao.getItem(idSlide).getPic_slide();
		if(slideDao.del(idSlide) > 0){
			if(!"".equals(old_picture)){
				String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_picture;
				File delFile = new File(dirFile_old);
				delFile.delete();
			}
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/slide";
	}
}