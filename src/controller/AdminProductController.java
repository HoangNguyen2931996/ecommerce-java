package controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.BrandDao;
import dao.CatDao;
import dao.OrderItemDao;
import dao.PictureDao;
import dao.ProductDao;
import dao.ReviewDao;
import dao.SlideDao;
import entities.Picture;
import entities.Product;
import entities.Slide;
import utils.LibraryFile;

@Controller
@RequestMapping("admin/product")
public class AdminProductController {
	private final String DIR_UPLOAD = "files";
	@Autowired
	private Defines defines;
	@Autowired
	private CatDao catDao;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private PictureDao pictureDao;
	@Autowired
	private SlideDao slideDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private OrderItemDao orderItemDao;
	@Autowired
	private LibraryFile libraryFile;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap){
		int row_count = defines.getROW_COUNT_ADMIN();
		int totalPage = (int)Math.ceil((float)productDao.getSumAll()/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1)*row_count;
		modelMap.addAttribute("alProduct", productDao.getItems(offset, row_count));
		modelMap.addAttribute("sumPage", totalPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_ADMIN());
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("alBrand", brandDao.getItems());
		return "admin.product.index";
	}
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		return "admin.product.add";
	}
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@Valid @ModelAttribute("objProduct") Product objProduct, BindingResult result,@RequestParam("picture") CommonsMultipartFile cmf,@RequestParam("status_product") int status_product,@RequestParam("highlight") int highlight, HttpServletRequest request, RedirectAttributes redirectAttributes){
		if(result.hasErrors()){
			return "admin.product.add";
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
		objProduct.setPicture_product(fileName);
		objProduct.setStatus_product(status_product);;
		objProduct.setHighlight(highlight);
		if(productDao.addItem(objProduct)>0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành Công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/product/add";
	}
	@RequestMapping("/edit/{idProduct}")
	public String edit(@PathVariable("idProduct") int idProduct, ModelMap modelMap){
		modelMap.addAttribute("objProduct", productDao.getItem(idProduct));
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("libraryFile", libraryFile);
		return "admin.product.edit";
	}
	@RequestMapping(value="/edit/{idProduct}", method=RequestMethod.POST)
	public String edit(@Valid @ModelAttribute("objProduct") Product objProduct,BindingResult result ,@PathVariable("idProduct") int idProduct,@RequestParam("picture") CommonsMultipartFile cmf,@RequestParam("status_product") int status_product,@RequestParam("highlight") int highlight, HttpServletRequest request, RedirectAttributes redirectAttributes ){
		if(result.hasErrors()){
			return "admin.product.edit";
		}
		Product objProductOld = productDao.getItem(idProduct);
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
			String oldPicture = objProductOld.getPicture_product();
			if(!"".equals(oldPicture)){
				String filePath_old = dirPath + File.separator + oldPicture;
				File delFile = new File(filePath_old);
				delFile.delete();
			}
		}else{
			fileName = objProductOld.getPicture_product();
		}
		objProduct.setId_product(idProduct);
		objProduct.setPicture_product(fileName);
		objProduct.setStatus_product(status_product);;
		objProduct.setHighlight(highlight);
		if(productDao.editItem(objProduct) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/product";
	}
	@RequestMapping("/del/{idProduct}")
	public String del(@PathVariable("idProduct") int idProduct, RedirectAttributes redirectAttributes, HttpServletRequest request){
		if(orderItemDao.checkProduct(idProduct).size()>0){
			redirectAttributes.addFlashAttribute("msg", "Sản phẩm này đang có trong đơn đặt hàng, không thể xóa");
			return "redirect:/admin/product";
		}
		String old_picture = productDao.getItem(idProduct).getPicture_product();
		List<Picture> alPicture = pictureDao.getItemsByIdProduct(idProduct);
		for (Picture picture : alPicture) {
			String old_pic = pictureDao.getItem(picture.getId_picture()).getName_picture();
			if(pictureDao.del(picture.getId_picture()) > 0){
				if(!"".equals(old_pic)){
					String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_pic;
					File delFile = new File(dirFile_old);
					delFile.delete();
				}
			} 
		}
		List<Slide> alSlide = slideDao.getItemsByIdProduct(idProduct);
		for (Slide slide : alSlide) {
			String old_pic = slideDao.getItem(slide.getId_slide()).getPic_slide();
			if(slideDao.del(slide.getId_slide()) > 0){
				if(!"".equals(old_pic)){
					String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_pic;
					File delFile = new File(dirFile_old);
					delFile.delete();
				}
			} 
		}
		if(reviewDao.delItemsByIdProduct(idProduct) > 0){
			
		}
		if(productDao.delItem(idProduct) > 0){
			if(!"".equals(old_picture)){
				String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_picture;
				File delFile = new File(dirFile_old);
				delFile.delete();
			}
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/product";
	}
	@RequestMapping("/del")
	public String del(RedirectAttributes redirectAttributes, HttpServletRequest request){
		String id_product[] = request.getParameterValues("id_product");
		if(id_product == null){
			redirectAttributes.addFlashAttribute("msg", "Bạn chưa chọn mục cần xóa");
			return "redirect:/admin/product";
		}
		for (int i = 0; i < id_product.length; i++) {
			int idProduct = Integer.parseInt(id_product[i]);
			if(orderItemDao.checkProduct(idProduct).size()>0){
				redirectAttributes.addFlashAttribute("msg", "Sản phẩm đang có trong đơn đặt hàng, không thể xóa");
				return "redirect:/admin/product";
			}
		}
		for (int i = 0; i < id_product.length; i++) {
			int idProduct = Integer.parseInt(id_product[i]);
			String old_picture = productDao.getItem(idProduct).getPicture_product();
			List<Picture> alPicture = pictureDao.getItemsByIdProduct(idProduct);
			for (Picture picture : alPicture) {
				String old_pic = pictureDao.getItem(picture.getId_picture()).getName_picture();
				if(pictureDao.del(picture.getId_picture()) > 0){
					if(!"".equals(old_pic)){
						String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_pic;
						File delFile = new File(dirFile_old);
						delFile.delete();
					}
				} 
			}
			List<Slide> alSlide = slideDao.getItemsByIdProduct(idProduct);
			for (Slide slide : alSlide) {
				String old_pic = slideDao.getItem(slide.getId_slide()).getPic_slide();
				if(slideDao.del(slide.getId_slide()) > 0){
					if(!"".equals(old_pic)){
						String dirFile_old = request.getServletContext().getRealPath("files") + File.separator + old_pic;
						File delFile = new File(dirFile_old);
						delFile.delete();
					}
				} 
			}
			if(reviewDao.delItemsByIdProduct(idProduct) > 0){
				
			}
			if(productDao.delItem(idProduct) > 0){
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
		return "redirect:/admin/product";
	}
	@RequestMapping("/picture/{idProduct}")
	public String picture(@PathVariable("idProduct") int idProduct,ModelMap modelMap){
		modelMap.addAttribute("alPicture", productDao.getItemsByIdPic(idProduct));
		modelMap.addAttribute("idProduct", idProduct);
		return "admin.product.picture";
	}
	@RequestMapping("picture/add/{idProduct}")
	public String pictureAdd(@PathVariable("idProduct") int idProduct, ModelMap modelMap){
		modelMap.addAttribute("objProduct", productDao.getItem(idProduct));
		return "admin.product.picture.add";
	}
	@RequestMapping(value="picture/add/{idProduct}", method=RequestMethod.POST)
	public String pictureAdd(@PathVariable("idProduct") int idProduct,@RequestParam("picture") CommonsMultipartFile cmf, HttpServletRequest request, RedirectAttributes redirectAttributes){
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
		if(productDao.addItemPic(idProduct, fileName)>0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành Công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/product/picture/add/"+idProduct;
	}
	@RequestMapping("/picture/edit/{idPicture}")
	public String pictureEdit(@PathVariable("idPicture") int idPicture, ModelMap modelMap){
		modelMap.addAttribute("objPicture", pictureDao.getItem(idPicture));
		return "admin.product.picture.edit";
	}
	@RequestMapping(value="/picture/edit/{idPicture}", method=RequestMethod.POST)
	public String edit(@PathVariable("idPicture") int idPicture,@RequestParam("picture") CommonsMultipartFile cmf,HttpServletRequest request ,RedirectAttributes redirectAttributes){
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
		
		if(productDao.editPic(idPicture, fileName) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/product/picture/"+pictureDao.getItem(idPicture).getId_product();
	}
	@RequestMapping("/picture/del/{idPicture}")
	public String picDel(@PathVariable("idPicture") int idPicture, RedirectAttributes redirectAttributes, HttpServletRequest request){
		String old_picture = pictureDao.getItem(idPicture).getName_picture();
		int idProduct = pictureDao.getItem(idPicture).getId_product();
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
		return "redirect:/admin/product/picture/"+idProduct;
	}
	@RequestMapping(value="/status", method=RequestMethod.POST)
	public @ResponseBody String status(HttpServletRequest request, Principal principal){
		int id_product = Integer.parseInt(request.getParameter("Id_product"));
		int status = Integer.parseInt(request.getParameter("status"));
		String str = "";
		if(productDao.updateStatus(id_product, status) > 0){
			if(status == 1){
				str = "<img id='"+ id_product +"' class='turnOn' style='padding-left: 10px;' alt='' src='"+ defines.getURL_ADMIN()+"/img/notification-tick.gif' onclick='return turnOn(this.id)'>";
			} else{
				str = "<img id='"+ id_product +"' class='turnOff' style='padding-left: 10px;' alt='' src='"+ defines.getURL_ADMIN() +"/img/minus-circle.gif' onclick='return turnOff(this.id)'>";
			}
		}
		return str;
	}
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public String search(@ModelAttribute("objProduct") Product objproduct, RedirectAttributes redirectAttributes, ModelMap modelMap){
		String sql = "SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE ";
		boolean check=false;
		if(!"".equals(objproduct.getName_product())){
			sql = sql + "name_product LIKE '%"+objproduct.getName_product()+"%'";
			check = true;
		}
		if(objproduct.getId_cat()!=0){
			if(check == true){
				sql = sql + " AND c.id_cat = "+objproduct.getId_cat();
			}else{
				sql = sql + "c.id_cat = "+objproduct.getId_cat();
				check = true;
			}
		}
		if(objproduct.getId_brand()!=0){
			if(check == true){
				sql = sql + " AND b.id_brand = "+objproduct.getId_brand();
			}else{
				sql = sql + "b.id_brand = "+objproduct.getId_brand();
				check = true;
			}
		}
		if(check == false){
			redirectAttributes.addFlashAttribute("msg", "Bạn chưa chọn điều kiện cần tìm");
			return "redirect:/admin/product";
		}
		List<Product> alProduct = productDao.searchItems(sql);
		if(alProduct.size() == 0){
			modelMap.addAttribute("msgSearch", "Không tìm thấy kết quả" );
		}
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("alProduct", productDao.searchItems(sql));
		return "admin.index.search";
	}
}
