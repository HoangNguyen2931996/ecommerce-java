package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
import dao.PictureDao;
import dao.ProductDao;
import entities.Picture;
import utils.LibraryFile;

@Controller
@RequestMapping("admin/picture")
public class AdminPictureController {
	private final String DIR_UPLOAD = "files";
	@Autowired
	private Defines defines;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private PictureDao pictureDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap){
		int row_count = defines.getROW_COUNT_ADMIN();
		int totalPage = (int)Math.ceil((float)pictureDao.getSumAll()/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1)*row_count;
		modelMap.addAttribute("alPicture", pictureDao.getItems(offset, row_count));
		modelMap.addAttribute("sumPage", totalPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("alProduct", productDao.getAllItem());
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_ADMIN());
		return "admin.picture.index";
	}
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.addAttribute("alProduct", productDao.getAllItem());
		return "admin.picture.add";
	}
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@ModelAttribute("objPicture") Picture objPicture,@RequestParam("picture") CommonsMultipartFile cmf, HttpServletRequest request, RedirectAttributes redirectAttributes){
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
		objPicture.setName_picture(fileName);
		if(pictureDao.addItem(objPicture)>0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành Công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/picture/add";
	}
	@RequestMapping("/edit/{idPicture}")
	public String edit(@PathVariable("idPicture") int idPicture, ModelMap modelMap){
		modelMap.addAttribute("alProduct", productDao.getAllItem());
		modelMap.addAttribute("objPicture", pictureDao.getItem(idPicture));
		return "admin.picture.edit";
	}
	@RequestMapping(value="/edit/{idPicture}", method=RequestMethod.POST)
	public String edit(@ModelAttribute("objPicture") Picture objPicture, @PathVariable("idPicture") int idPicture,@RequestParam("picture") CommonsMultipartFile cmf,HttpServletRequest request ,RedirectAttributes redirectAttributes){
		String fileName = cmf.getOriginalFilename();
		Picture objPictureOld = pictureDao.getItem(idPicture);
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
			String oldPicture = objPictureOld.getName_picture();
			if(!"".equals(oldPicture)){
				String filePath_old = dirPath + File.separator + oldPicture;
				File delFile = new File(filePath_old);
				delFile.delete();
			}
		}else{
			fileName = objPictureOld.getName_picture();
		}
		objPicture.setId_picture(idPicture);
		objPicture.setName_picture(fileName);
		if(pictureDao.edit(objPicture) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/picture";
	}
	@RequestMapping("/del/{idPicture}")
	public String del(@PathVariable("idPicture") int idPicture, RedirectAttributes redirectAttributes, HttpServletRequest request){
		String old_picture = pictureDao.getItem(idPicture).getName_picture();
		if(pictureDao.del(idPicture) > 0){
			if(!"".equals(old_picture)){
				String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_picture;
				File delFile = new File(dirFile_old);
				delFile.delete();
			}
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/picture";
	}
	@RequestMapping("/del")
	public String del(RedirectAttributes redirectAttributes, HttpServletRequest request){
		String id_picture[] = request.getParameterValues("id_picture");
		if(id_picture == null){
			redirectAttributes.addFlashAttribute("msg", "Bạn chưa chọn mục cần xóa");
			return "redirect:/admin/picture";
		}
		for (int i = 0; i < id_picture.length; i++) {
			int idPicture = Integer.parseInt(id_picture[i]);
			String old_picture = pictureDao.getItem(idPicture).getName_picture();
			if(pictureDao.del(idPicture) > 0){
				if(!"".equals(old_picture)){
					String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_picture;
					File delFile = new File(dirFile_old);
					delFile.delete();
				}
			} else{
				redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
			}
		}
		redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		return "redirect:/admin/picture";
	}
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public String search(@ModelAttribute("objPicture") Picture objPicture, RedirectAttributes redirectAttributes, ModelMap modelMap){
		String sql = "SELECT name_product, id_picture, name_picture FROM slide_picture As s INNER JOIN products As p"
				+ " ON s.id_product = p.id_product WHERE";
		boolean check=false;
		System.out.println(objPicture.getId_product());
		if(objPicture.getId_product() != 0){
			sql = sql + " s.id_product = "+objPicture.getId_product()+"";
			check = true;
		}
		if(check == false){
			redirectAttributes.addFlashAttribute("msg", "Bạn chưa chọn điều kiện cần tìm");
			return "redirect:/admin/picture";
		}
		List<Picture> alPicture = pictureDao.searchItems(sql);
		if(alPicture.size() == 0){
			modelMap.addAttribute("msgSearch", "Không tìm thấy kết quả" );
		}
		modelMap.addAttribute("alProduct", productDao.getAllItem());
		modelMap.addAttribute("alPicture", pictureDao.searchItems(sql));
		return "admin.picture.search";
	}
}