package controller;

import java.security.Principal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.BrandDao;
import dao.CatDao;
import dao.OrderDao;
import dao.OrderItemDao;
import dao.ProductDao;
import dao.ReviewDao;
import dao.SlideDao;
import dao.UserDao;
import entities.Cart;
import entities.Product;
import entities.User;
import utils.SlugUtils;
import utils.StringUtils;

@Controller
@RequestMapping("/")
public class PublicIndexController {
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CatDao catDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private SlideDao slideDao;
	@Autowired
	private StringUtils stringUtils;
	@Autowired
	private SlugUtils slugUtils;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderItemDao orderItemDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap, HttpServletRequest request, Principal principal){
		modelMap.addAttribute("defines", defines);
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("stringUtils", stringUtils);
		modelMap.addAttribute("slugUtils", slugUtils);
		modelMap.addAttribute("alProductTopHL", productDao.getItemsByTopHT());
		modelMap.addAttribute("alProductTopSale", productDao.getItemsByTopSale());
		modelMap.addAttribute("alProductTopSell", productDao.getItemsByTopSell());
		if(principal != null){
			modelMap.addAttribute("objUser", userDao.getItemByUsername(principal.getName()));
			if(orderDao.vieworder(principal.getName()) != null){
				modelMap.addAttribute("objOrder", orderDao.vieworder(principal.getName()));
			}
		}
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart != null){
			modelMap.addAttribute("alCart", alCart);
		}
	}
	@RequestMapping("")
	public String index(ModelMap modelMap){
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("alProductByHL", productDao.getItemsByHT());
		modelMap.addAttribute("alProductByDis",productDao.getItemsByDis(0));
		modelMap.addAttribute("alProductNew", productDao.getItemsNew(0));
		modelMap.addAttribute("alProductSeller", productDao.getItemsSeller());
		modelMap.addAttribute("alSlide", slideDao.getItems());
		return "public.index.index";
	}
	@RequestMapping("/{slug}-{idCat}")
	public String cat(@PathVariable("idCat") int idCat,@PathVariable("slug") String slug, @RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap){
		if(!slug.equals(SlugUtils.makeSlug(catDao.getItem(idCat).getName_cat()))){
			return "redirect:/"+SlugUtils.makeSlug(catDao.getItem(idCat).getName_cat())+"-"+idCat;
		}
		int row_count = defines.getROW_COUNT_PUBLIC();
		int sumPage = (int)Math.ceil( (float) productDao.getSumByIdCat(idCat)/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1) * row_count;
		modelMap.addAttribute("alProduct", productDao.getItemsByIdCat(idCat, offset, row_count));
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("sumPage", sumPage);
		modelMap.addAttribute("sumItem", productDao.getSumByIdCat(idCat));
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_PUBLIC());
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("objCat", catDao.getItem(idCat));
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("active1", catDao.getItem(idCat).getName_cat());
		modelMap.addAttribute("alProductNew", productDao.getItemsNew(0));
		return "public.index.cat";
	}
	@RequestMapping("/{slug}-{idProduct}.html")
	public String detail(@PathVariable("idProduct") int idProduct,@PathVariable("slug") String slug, ModelMap modelMap){
		if(!slug.equals(SlugUtils.makeSlug(productDao.getItem(idProduct).getName_product()))){
			return "redirect:/"+SlugUtils.makeSlug(productDao.getItem(idProduct).getName_product())+"-"+idProduct+".html";
		}
		modelMap.addAttribute("objProduct", productDao.getItem(idProduct));
		modelMap.addAttribute("alPicture", productDao.getItemsByIdPic(idProduct));
		modelMap.addAttribute("alProductLQ", productDao.getItemsLQ(idProduct,productDao.getItem(idProduct).getId_cat()));
		modelMap.addAttribute("active1", productDao.getItem(idProduct).getName_cat());
		modelMap.addAttribute("active2", productDao.getItem(idProduct).getName_product());
		modelMap.addAttribute("alReview", reviewDao.getItemsByIdProduct(idProduct));
		if(reviewDao.getMaxScoreByidProduct(idProduct) != 0){
			modelMap.addAttribute("maxReview", reviewDao.getMaxScoreByidProduct(idProduct));
		} else{
			modelMap.addAttribute("maxReview", 0);
		}
		return "public.index.detail";
	}
	@RequestMapping("/{slug}-{idBrand}.php")
	public String brand(@PathVariable("idBrand") int idBrand,@PathVariable("slug") String slug,@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap){
		if(!slug.equals(SlugUtils.makeSlug(brandDao.getItem(idBrand).getName_brand()))){
			return "redirect:/"+SlugUtils.makeSlug(brandDao.getItem(idBrand).getName_brand())+"-"+idBrand+".php";
		}
		int row_count = defines.getROW_COUNT_PUBLIC();
		int sumPage = (int)Math.ceil( (float) productDao.getSumByIdBrand(idBrand)/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1) * row_count;
		modelMap.addAttribute("alProduct", productDao.getItemsByIdBrand(idBrand, offset, row_count));
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("sumPage", sumPage);
		modelMap.addAttribute("sumItem", productDao.getSumByIdBrand(idBrand));
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_PUBLIC());
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("objBrand", brandDao.getItem(idBrand));
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("active1", brandDao.getItem(idBrand).getName_brand());
		modelMap.addAttribute("alProductByDis",productDao.getItemsByDis(0));
		return "public.index.brand";
	}
	@RequestMapping("/cart")
	public String cart(ModelMap modelMap,HttpServletRequest request){
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart !=null && alCart.size() != 0){
			modelMap.addAttribute("alCart", alCart);
		} else{
			return "redirect:/";
		}
		modelMap.addAttribute("active1", "Giỏ hàng");
		return "public.index.cart";
	}
	@RequestMapping(value="/loadMoreHL", method=RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String loadMoreHL(@RequestParam("Id_lastProduct") int id_lastProduct, HttpServletRequest request){
		String str = "";
		List<Product> alProductByHL = productDao.getItemsByLoadHL(id_lastProduct);
		int Id_lastProduct = 0;
		
		String red = "";
		String green = "";
		String price = "";
		for (Product product : alProductByHL) {
			if(product.getDiscount_product() > 0){
				red = "<div class='ribbon red'><span>sale</span></div>";
				green = "<div class='label-discount green'>-"+product.getDiscount_product()+"% sale</div>";
				price = "<div class='price-prev'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>"+
		            	"<div class='price-current pull-right'>"+stringUtils.changeMoney(stringUtils.currentPrice(product.getPrice_product(), product.getDiscount_product()))+"</div>";
		        	
			}
			if(product.getDiscount_product() == 0){
				red="";
				green = "";
				price = "<div class='price-prev'></div>"+
						"<div class='price-current pull-right'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>";
			}
			String urlProduct = request.getContextPath()+"/"+SlugUtils.makeSlug(product.getName_product())+"-"+product.getId_product()+".html";
			String urlPicture = request.getContextPath() + "/files/" + product.getPicture_product();
			Id_lastProduct = product.getId_product();
			str = str+"<div class='col-sm-4 col-md-3 no-margin product-item-holder hover'>"+
		"<div class='product-item'>"+
            red+
            "<div class='image'>"+
                "<img style='width: 246px; height: 186px' alt='' src='"+urlPicture+"'  />"+
            "</div>"+
            "<div class='body'>"+
                green+
                "<div class='title'>"+
                    "<a href='"+urlProduct+"'>"+product.getName_product()+"</a>"+
                "</div>"+
                "<div class='brand'>sony</div>"+
            "</div>"+
            "<div class='prices'>"+
            price+
            "</div>"+
        	"<div class='hover-area'>"+
        		"<div class='add-cart-button'>"+
        			"<a href='javascript:void(0)' class='le-button' onclick='return loadCart("+product.getId_product()+")'>add to cart</a>"+
    			"</div>"+
			"</div>"+
		"</div>"+
		"</div>";
		}
		if(alProductByHL.size()==4){
		str = str + "<div class='loadmore-holder text-center' id='remove_row'>"+
				
		        "<a class='btn-loadmore' href='javascript:void(0)' onclick='return loadMoreHL("+Id_lastProduct+")'>"+
				"<i class='fa fa-plus'></i>"+
				"<span id='btn_more'>load more products</span></a>"+
				"</div>";
		}
		return "<div class='product-grid-holder'>" + str +"</div";
	}
	@RequestMapping(value="/loadMoreDis", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public @ResponseBody String loadMoreDis(@RequestParam("Offset") int offset, HttpServletRequest request){
		String str = "";
		List<Product> alProductByDis = productDao.getItemsByDis(offset);
		String red = "";
		String green = "";
		String price = "";
		for (Product product : alProductByDis) {
			if(product.getDiscount_product() > 0){
				red = "<div class='ribbon red'><span>sale</span></div>";
				green = "<div class='label-discount green'>-"+product.getDiscount_product()+"% sale</div>";
				price = "<div class='price-prev'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>"+
		            	"<div class='price-current pull-right'>"+stringUtils.changeMoney(stringUtils.currentPrice(product.getPrice_product(), product.getDiscount_product()))+"</div>";
		        	
			}
			if(product.getDiscount_product() == 0){
				red="";
				green = "";
				price = "<div class='price-prev'></div>"+
						"<div class='price-current pull-right'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>";
			}
			String urlProduct = request.getContextPath()+"/"+SlugUtils.makeSlug(product.getName_product())+"-"+product.getId_product()+".html";
			String urlPicture = request.getContextPath() + "/files/" + product.getPicture_product();
			str = str+"<div class='col-sm-4 col-md-3 no-margin product-item-holder hover'>"+
		"<div class='product-item'>"+
            red+
            "<div class='image'>"+
                "<img style='width: 246px; height: 186px' alt='' src='"+urlPicture+"' />"+
            "</div>"+
            "<div class='body'>"+
                green+
                "<div class='title'>"+
                    "<a href='"+urlProduct+"'>"+product.getName_product()+"</a>"+
                "</div>"+
                "<div class='brand'>sony</div>"+
            "</div>"+
            "<div class='prices'>"+
            	price+
        	"</div>"+
        	"<div class='hover-area'>"+
        		"<div class='add-cart-button'>"+
        			"<a href='javascript:void(0)' class='le-button' onclick='return loadCart("+product.getId_product()+")'>add to cart</a>"+
    			"</div>"+
			"</div>"+
		"</div>"+
		"</div>";
		}
		if(alProductByDis.size()==4){
		str = str + "<div class='loadmore-holder text-center' id='remove_row_sale'>"+
		        "<a class='btn-loadmore' href='javascript:void(0)' onclick='return loadMoreDis("+(offset+4)+")'>"+
				"<i class='fa fa-plus'></i>"+
				"<span id='btn_more_sale'>load more products</span></a>"+
				"</div>";
		}
		return "<div class='product-grid-holder'>" + str +"</div";
	}
	@RequestMapping(value="/loadMoreNew", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public @ResponseBody String loadMoreNew(@RequestParam("Offset") int offset, HttpServletRequest request){
		String str = "";
		String red = "";
		String green = "";
		String price = "";
		List<Product> alProductNew = productDao.getItemsNew(offset);
		for (Product product : alProductNew) {
			if(product.getDiscount_product() > 0){
				red = "<div class='ribbon red'><span>sale</span></div>";
				green = "<div class='label-discount green'>-"+product.getDiscount_product()+"% sale</div>";
				price = "<div class='price-prev'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>"+
		            	"<div class='price-current pull-right'>"+stringUtils.changeMoney(stringUtils.currentPrice(product.getPrice_product(), product.getDiscount_product()))+"</div>";
		        	
			}
			if(product.getDiscount_product() == 0){
				red="";
				green = "";
				price = "<div class='price-prev'></div>"+
						"<div class='price-current pull-right'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>";
			}
			String urlProduct = request.getContextPath()+"/"+SlugUtils.makeSlug(product.getName_product())+"-"+product.getId_product()+".html";
			String urlPicture = request.getContextPath() + "/files/" + product.getPicture_product();
			str = str+"<div class='col-sm-4 col-md-3 no-margin product-item-holder hover'>"+
		"<div class='product-item'>"+
            red+
            "<div class='image'>"+
                "<img style='width: 246px; height: 186px' alt='' src='"+urlPicture+"'/>"+
            "</div>"+
            "<div class='body'>"+
                green+
                "<div class='title'>"+
                    "<a href='"+urlProduct+"'>"+product.getName_product()+"</a>"+
                "</div>"+
                "<div class='brand'>sony</div>"+
            "</div>"+
            "<div class='prices'>"+
            	price+
        	"</div>"+
        	"<div class='hover-area'>"+
        		"<div class='add-cart-button'>"+
        			"<a href='javascript:void(0)' class='le-button' onclick='return loadCart("+product.getId_product()+")'>add to cart</a>"+
    			"</div>"+
			"</div>"+
		"</div>"+
		"</div>";
		}
		if(alProductNew.size()==4){
		str = str + "<div class='loadmore-holder text-center' id='remove_row_new'>"+
		        "<a class='btn-loadmore' href='javascript:void(0)' onclick='return loadMoreNew("+(offset+4)+")'>"+
				"<i class='fa fa-plus'></i>"+
				"<span id='btn_more_new'>load more products</span></a>"+
				"</div>";
		}
		return "<div class='product-grid-holder'>" + str +"</div";
	}
	@RequestMapping(value="/loadCart", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public @ResponseBody String loadCart(@RequestParam("idProduct") int idProduct, HttpServletRequest request){
		boolean check = false;
		Product objProduct = productDao.getItem(idProduct);
		String name_product = objProduct.getName_product();
		int total_amount = stringUtils.currentPrice(objProduct.getPrice_product(), objProduct.getDiscount_product());
		int price_product = objProduct.getPrice_product();
		int quantity = 1;
		String picture_product = objProduct.getPicture_product();
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart == null){
			Cart objCart = new Cart(idProduct, name_product, quantity, total_amount, picture_product,price_product,objProduct.getName_brand(),objProduct.getDiscount_product());
			alCart = new ArrayList<>();
			alCart.add(objCart);
			session.setAttribute("alCart", alCart);
		} else{
			for (Cart objcart : alCart) {
				if(objcart.getId_product() == idProduct){
					int quantiy_temp = objcart.getQuantity() + 1;
					objcart.setQuantity(quantiy_temp);
					objcart.setTotal_amount(quantiy_temp*total_amount);
					check = true;
				}
			}
			if(check == false){
				Cart objCart = new Cart(idProduct, name_product, quantity, total_amount,picture_product,price_product,objProduct.getName_brand(),objProduct.getDiscount_product());
				alCart.add(objCart);
			}
			session.setAttribute("alCart", alCart);
		}
		int total_price = 0;
		String strMenu = "<ul class='dropdown-menu'>";
		for (Cart objCart : alCart) {
			total_price = total_price + objCart.getTotal_amount();
			String urlPic = request.getContextPath() + "/files/" +objCart.getPicture_product();
			strMenu = strMenu +
				"<li>"+
			        "<div class='basket-item'>"+
						"<div class='row'>"+
							"<div class='col-xs-4 col-sm-4 no-margin text-center'>"+
								"<div class='thumb'>"+
									"<img style='width: 73px; height: 73px' alt='' src='"+urlPic+"' />"+
								"</div>"+
							"</div>"+
							"<div class='col-xs-8 col-sm-8 no-margin'>"+
								"<div class='title'>"+objCart.getName_product()+"</div>"+
								"<div>Số lượng: <span style='font-weight: bold;color: red'>"+objCart.getQuantity()+"</span></div>"+
								"<div class='price'>"+stringUtils.changeMoney(objCart.getTotal_amount())+"</div>"+
							"</div>"+
						"</div>"+
						"<a class='close-btn' href='javascript:void(0)' onclick='return deleteItem("+objCart.getId_product()+")'></a>"+
					"</div>"+
				"</li>";
		}
		String urlCart = request.getContextPath()+"/cart";
		String urlCheckout = request.getContextPath()+"/checkout";
		strMenu = strMenu+
			"<li class='checkout'>"+
		        "<div class='basket-item'>"+
		            "<div class='row'>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCart+"' class='le-button inverse'>View cart</a>"+
		                "</div>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCheckout+"' class='le-button'>Checkout</a>"+
		                "</div>"+
		            "</div>"+
		        "</div>"+
		    "</li>"+
		"</ul>";
		
		String strToggle = ""+
			"<a class='dropdown-toggle' data-toggle='dropdown' href='#'>"+
		        "<div class='basket-item-count'>"+
		            "<span class='count'>"+alCart.size()+"</span>"+
		            "<img src='"+defines.getURL_PUBLIC()+"/images/icon-cart.png' alt='' />"+
		        "</div>"+
		        "<div class='total-price-basket'>"+
		            "<span class='lbl'>your cart:</span>"+
		            "<span class='total-price'>"+
		            "<span class='value'>"+stringUtils.changeMoney(total_price)+"</span>"+
		            "</span>"+
		        "</div>"+
		    "</a>";	
		return strToggle+strMenu;
	}
	@RequestMapping(value="/updateDetail", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public @ResponseBody String updateDetail(@RequestParam("idProduct") int idProduct,@RequestParam("quantity") int quantity, HttpServletRequest request){
		boolean check = false;
		Product objProduct = productDao.getItem(idProduct);
		String name_product = objProduct.getName_product();
		int price_product = objProduct.getPrice_product();
		int price_current = stringUtils.currentPrice(objProduct.getPrice_product(), objProduct.getDiscount_product());
		String picture_product = objProduct.getPicture_product();
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart == null){
			Cart objCart = new Cart(idProduct, name_product, quantity, price_current*quantity, picture_product,price_product,objProduct.getName_brand(), objProduct.getDiscount_product());
			alCart = new ArrayList<>();
			alCart.add(objCart);
			session.setAttribute("alCart", alCart);
		} else{
			for (Cart objcart : alCart) {
				if(objcart.getId_product() == idProduct){
					int quantiy_temp = objcart.getQuantity() + quantity;
					objcart.setQuantity(quantiy_temp);
					objcart.setTotal_amount(quantiy_temp*price_current);
					check = true;
				}
			}
			if(check == false){
				Cart objCart = new Cart(idProduct, name_product, quantity, price_current*quantity,picture_product,price_product,objProduct.getName_brand(),objProduct.getDiscount_product());
				alCart.add(objCart);
			}
			session.setAttribute("alCart", alCart);
		}
		int total_price = 0;
		String strMenu = "<ul class='dropdown-menu'>";
		for (Cart objCart : alCart) {
			total_price = total_price + objCart.getTotal_amount();
			String urlPic = request.getContextPath() + "/files/" +objCart.getPicture_product();
			strMenu = strMenu +
				"<li>"+
			        "<div class='basket-item'>"+
						"<div class='row'>"+
							"<div class='col-xs-4 col-sm-4 no-margin text-center'>"+
								"<div class='thumb'>"+
									"<img style='width: 73px; height: 73px' alt='' src='"+urlPic+"' />"+
								"</div>"+
							"</div>"+
							"<div class='col-xs-8 col-sm-8 no-margin'>"+
								"<div class='title'>"+objCart.getName_product()+"</div>"+
								"<div>Số lượng: <span style='font-weight: bold;color: red'>"+objCart.getQuantity()+"</span></div>"+
								"<div class='price'>"+stringUtils.changeMoney(objCart.getTotal_amount())+"</div>"+
							"</div>"+
						"</div>"+
						"<a class='close-btn' href='javascript:void(0)' onclick='return deleteItem("+objCart.getId_product()+")'></a>"+
					"</div>"+
				"</li>";
		}
		String urlCart = request.getContextPath()+"/cart";
		String urlCheckout = request.getContextPath()+"/checkout";
		strMenu = strMenu+
			"<li class='checkout'>"+
		        "<div class='basket-item'>"+
		            "<div class='row'>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCart+"' class='le-button inverse'>View cart</a>"+
		                "</div>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCheckout+"' class='le-button'>Checkout</a>"+
		                "</div>"+
		            "</div>"+
		        "</div>"+
		    "</li>"+
		"</ul>";
		
		String strToggle = ""+
			"<a class='dropdown-toggle' data-toggle='dropdown' href='#'>"+
		        "<div class='basket-item-count'>"+
		            "<span class='count'>"+alCart.size()+"</span>"+
		            "<img src='"+defines.getURL_PUBLIC()+"/images/icon-cart.png' alt='' />"+
		        "</div>"+
		        "<div class='total-price-basket'>"+
		            "<span class='lbl'>your cart:</span>"+
		            "<span class='total-price'>"+
		            "<span class='value'>"+stringUtils.changeMoney(total_price)+"</span>"+
		            "</span>"+
		        "</div>"+
		    "</a>";	
		return strToggle+strMenu;
	}
	@RequestMapping(value="/updateCart", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8",headers = "Accept=application/json")
	public @ResponseBody ArrayList<String> updateCart(@RequestParam("idProduct") int idProduct,@RequestParam("quantity") int quantity, HttpServletRequest request){
		HttpSession session = request.getSession();
		Product objProduct = productDao.getItem(idProduct);
		int currentPrice = stringUtils.currentPrice(objProduct.getPrice_product(), objProduct.getDiscount_product());
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart != null){
			for (Cart objcart : alCart) {
				if(objcart.getId_product() == idProduct){
					objcart.setQuantity(quantity);
					objcart.setTotal_amount(quantity*currentPrice);
				}
			}
		}
		session.setAttribute("alCart", alCart);
		String strMenu = "<ul class='dropdown-menu'>";
		int total_price = 0;
		for (Cart objCart : alCart) {
			total_price = total_price + objCart.getTotal_amount();
			String urlPic = request.getContextPath() + "/files/" +objCart.getPicture_product();
			strMenu = strMenu +
				"<li>"+
			        "<div class='basket-item'>"+
						"<div class='row'>"+
							"<div class='col-xs-4 col-sm-4 no-margin text-center'>"+
								"<div class='thumb'>"+
									"<img style='width: 73px; height: 73px' alt='' src='"+urlPic+"' />"+
								"</div>"+
							"</div>"+
							"<div class='col-xs-8 col-sm-8 no-margin'>"+
								"<div class='title'>"+objCart.getName_product()+"</div>"+
								"<div>Số lượng: <span style='font-weight: bold;color: red'>"+objCart.getQuantity()+"</span></div>"+
								"<div class='price'>"+stringUtils.changeMoney(objCart.getTotal_amount())+"</div>"+
							"</div>"+
						"</div>"+
						"<a class='close-btn' href='javascript:void(0)' onclick='return deleteItem("+objCart.getId_product()+")'></a>"+
					"</div>"+
				"</li>";
		}
		String urlCart = request.getContextPath()+"/cart";
		String urlCheckout = request.getContextPath()+"/checkout";
		strMenu = strMenu+
			"<li class='checkout'>"+
		        "<div class='basket-item'>"+
		            "<div class='row'>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCart+"' class='le-button inverse'>View cart</a>"+
		                "</div>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCheckout+"' class='le-button'>Checkout</a>"+
		                "</div>"+
		            "</div>"+
		        "</div>"+
		    "</li>"+
		"</ul>";
		String strToggle = ""+
			"<a class='dropdown-toggle' data-toggle='dropdown' href='#'>"+
		        "<div class='basket-item-count'>"+
		            "<span class='count'>"+alCart.size()+"</span>"+
		            "<img src='"+defines.getURL_PUBLIC()+"/images/icon-cart.png' alt='' />"+
		        "</div>"+
		        "<div class='total-price-basket'>"+
		            "<span class='lbl'>your cart:</span>"+
		            "<span class='total-price'>"+
		            "<span class='value'>"+stringUtils.changeMoney(total_price)+"</span>"+
		            "</span>"+
		        "</div>"+
		    "</a>";
		String urlCheck = request.getContextPath()+"/checkout";
		String urlHome = request.getContextPath();
		strMenu = strToggle+strMenu;
		String strTotal = ""+
			"<ul class='tabled-data no-border inverse-bold'>"+
		        "<li>"+
		            "<label>Tổng tiền đã mua</label>"+
		            "<div class='value pull-right'>"+stringUtils.changeMoney(total_price)+"</div>"+
		        "</li>"+
		        "<li>"+
		            "<label>shipping</label>"+
		            "<div class='value pull-right'>free shipping</div>"+
		        "</li>"+
		    "</ul>"+
		    "<ul id='total-price' class='tabled-data inverse-bold no-border'>"+
		        "<li>"+
		            "<label>Tổng tiền</label>"+
		            "<div class='value pull-right'>"+stringUtils.changeMoney(total_price)+"</div>"+
		        "</li>"+
		    "</ul>"+
		    "<div class='buttons-holder'>"+
		        "<a class='le-button big' href='"+urlCheck+"' >checkout</a>"+
		        "<a class='simple-link block' href='"+urlHome+"' >continue shopping</a>"+
		    "</div>";
		ArrayList<String> alStr = new ArrayList<>();
		alStr.add(strMenu);
		alStr.add(strTotal);
		return alStr;
	}
	@RequestMapping(value="/deleteItem", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8",headers = "Accept=application/json")
	public @ResponseBody ArrayList<String> deleteItem(@RequestParam("idProduct") int idProduct, HttpServletRequest request){
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart != null){
			Iterator<Cart> it = alCart.iterator();
			while (it.hasNext()) {
				if(it.next().getId_product() == idProduct){
					it.remove();
				}
				
			}
		}
		session.setAttribute("alCart", alCart);
		int total_price = 0;
		String strMenu = "";
		if(alCart.size() != 0){
		strMenu = "<ul class='dropdown-menu'>";
		for (Cart objCart : alCart) {
			total_price = total_price + objCart.getTotal_amount();
			String urlPic = request.getContextPath() + "/files/" +objCart.getPicture_product();
			strMenu = strMenu +
				"<li>"+
			        "<div class='basket-item'>"+
						"<div class='row'>"+
							"<div class='col-xs-4 col-sm-4 no-margin text-center'>"+
								"<div class='thumb'>"+
									"<img style='width: 73px; height: 73px' alt='' src='"+urlPic+"' />"+
								"</div>"+
							"</div>"+
							"<div class='col-xs-8 col-sm-8 no-margin'>"+
								"<div class='title'>"+objCart.getName_product()+"</div>"+
								"<div>Số lượng: <span style='font-weight: bold;color: red'>"+objCart.getQuantity()+"</span></div>"+
								"<div class='price'>"+stringUtils.changeMoney(objCart.getTotal_amount())+"</div>"+
							"</div>"+
						"</div>"+
						"<a class='close-btn' href='javascript:void(0)' onclick='return deleteItem("+objCart.getId_product()+")'></a>"+
					"</div>"+
				"</li>";
		}
		String urlCart = request.getContextPath()+"/cart";
		String urlCheckout = request.getContextPath()+"/checkout";
		strMenu = strMenu+
			"<li class='checkout'>"+
		        "<div class='basket-item'>"+
		            "<div class='row'>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCart+"' class='le-button inverse'>View cart</a>"+
		                "</div>"+
		                "<div class='col-xs-12 col-sm-6'>"+
		                    "<a href='"+urlCheckout+"' class='le-button'>Checkout</a>"+
		                "</div>"+
		            "</div>"+
		        "</div>"+
		    "</li>"+
		"</ul>";
		}
		String strToggle = ""+
			"<a class='dropdown-toggle' data-toggle='dropdown' href='#'>"+
		        "<div class='basket-item-count'>"+
		            "<span class='count'>"+alCart.size()+"</span>"+
		            "<img src='"+defines.getURL_PUBLIC()+"/images/icon-cart.png' alt='' />"+
		        "</div>"+
		        "<div class='total-price-basket'>"+
		            "<span class='lbl'>your cart:</span>"+
		            "<span class='total-price'>"+
		            "<span class='value'>"+stringUtils.changeMoney(total_price)+"</span>"+
		            "</span>"+
		        "</div>"+
		    "</a>";
		strMenu = strToggle+strMenu;
		String urlCheck = request.getContextPath()+"/checkout";
		String urlHome = request.getContextPath();
		String strTotal = ""+
			"<ul class='tabled-data no-border inverse-bold'>"+
		        "<li>"+
		            "<label>Tổng tiền đã mua</label>"+
		            "<div class='value pull-right'>"+stringUtils.changeMoney(total_price)+"</div>"+
		        "</li>"+
		        "<li>"+
		            "<label>shipping</label>"+
		            "<div class='value pull-right'>free shipping</div>"+
		        "</li>"+
		    "</ul>"+
		    "<ul id='total-price' class='tabled-data inverse-bold no-border'>"+
		        "<li>"+
		            "<label>Tổng tiền</label>"+
		            "<div class='value pull-right'>"+stringUtils.changeMoney(total_price)+"</div>"+
		        "</li>"+
		    "</ul>"+
		    "<div class='buttons-holder'>"+
		        "<a class='le-button big' href='"+urlCheck+"' >checkout</a>"+
		        "<a class='simple-link block' href='"+urlHome+"' >continue shopping</a>"+
		    "</div>";
		ArrayList<String> alStr = new ArrayList<>();
		alStr.add(strMenu);
		alStr.add(strTotal);
		return alStr;
	}
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public String search(@RequestParam("key_word") String key_word, ModelMap modelMap){
		modelMap.addAttribute("alProduct", productDao.getItemsByKey(key_word));
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("alProductNew", productDao.getItemsNew(0));
		modelMap.addAttribute("active1", "Kết quả tìm kiếm");
		return "public.index.search";
	}
	@RequestMapping(value="/searchPrice", method=RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String searchPrice(@RequestParam("price") String price, @RequestParam("id_cat") int idCat, HttpServletRequest request){
		String[] alPrice = price.split(",");
		int min = Integer.parseInt(alPrice[0]);
		int max = Integer.parseInt(alPrice[1]);
		System.out.println(min+"/"+max);
		List<Product> alProduct = productDao.getItemsPriceByCat(idCat, min, max);
		String str = "";
		String red = "";
		String green = "";
		String money = "";
		for (Product product : alProduct) {
			if(product.getDiscount_product() > 0){
				red = "<div class='ribbon red'><span>sale</span></div>";
				green = "<div class='label-discount green'>-"+product.getDiscount_product()+"% sale</div>";
				money = "<div class='price-prev'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>"+
		            	"<div class='price-current pull-right'>"+stringUtils.changeMoney(stringUtils.currentPrice(product.getPrice_product(), product.getDiscount_product()))+"</div>";
		        	
			}
			if(product.getDiscount_product() == 0){
				red="";
				green = "";
				money = "<div class='price-prev'></div>"+
						"<div class='price-current pull-right'>"+stringUtils.changeMoney(product.getPrice_product())+"</div>";
			}
			String urlProduct = request.getContextPath()+"/"+SlugUtils.makeSlug(product.getName_product())+"-"+product.getId_product()+".html";
			String urlPicture = request.getContextPath() + "/files/" + product.getPicture_product();
			str = str +
			"<div class='col-xs-12 col-sm-4 no-margin product-item-holder hover'>"+
	            "<div class='product-item'>"+
					red+
	                "<div class='image'>"+
	                    "<img style='width: 246px; height: 186px;' alt='' src='"+urlPicture+"'/>"+
	                "</div>"+
	                "<div class='body'>"+
						green+
	                    "<div class='title'>"+
	                        "<a href='"+urlProduct+"'>"+product.getName_product()+"</a>"+
	                    "</div>"+
	                    "<div class='brand'>"+product.getName_brand()+"</div>"+
	                "</div>"+
	                "<div class='prices'>"+
						money+
	                "</div>"+
	                "<div class='hover-area'>"+
	                    "<div class='add-cart-button'>"+
	                        "<a href='javascript:void(0)' class='le-button' onclick='return loadCart("+product.getId_product()+")'>add to cart</a>"+
	                    "</div>"+
	                "</div>"+
	            "</div>"+
	        "</div>";
			
		}
		return "<div class='product-grid-holder'><div class='row no-margin'>"+str+"</div></div>";
	}
	@RequestMapping(value="/review", method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public @ResponseBody String review(HttpServletRequest request){
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		int score_review = Integer.parseInt(request.getParameter("score_review"));
		String message = request.getParameter("message");
		int id_product = Integer.parseInt(request.getParameter("id_product"));
		String str = "";
		if(reviewDao.addItem(name, email, score_review, message, id_product) > 0){
			Date date = new Date(System.currentTimeMillis());
			SimpleDateFormat tf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
			tf.format(date.getTime());
			str = str + 
			"<div class='comment-item'>"+
	            "<div class='row no-margin'>"+
	                "<div class='col-lg-1 col-xs-12 col-sm-2 no-margin'>"+
	                    "<div class='avatar'>"+
	                        "<img alt='avatar' src='"+defines.getURL_PUBLIC()+"/images/default-avatar.jpg'>"+
	                    "</div>"+
	                "</div>"+
	                "<div class='col-xs-12 col-lg-11 col-sm-10 no-margin'>"+
	                    "<div class='comment-body'>"+
	                        "<div class='meta-info'>"+
	                            "<div class='author inline'>"+
	                                "<a href='javascript:void(0)' class='bold'>"+name+"</a>"+
	                            "</div>"+
	                            "<div class='star-holder inline'>"+
	                                "<div class='star' data-score='"+score_review+"'></div>"+
	                            "</div>"+
	                            "<div class='date inline pull-right'>"+
	                            	tf.format(date.getTime())+
	                            "</div>"+
	                        "</div>"+
	                        "<p class='comment-text'>"+
	                            message+ 
	                        "</p>"+
	                    "</div>"+
	                "</div>"+
	            "</div>"+
	        "</div>"+
	        "<script type='text/javascript'>"+
		        "$(document).ready(function () {"+
		            "if ($('.star').length > 0) {"+
		                "$('.star').each(function(){"+
	                        "var $star = $(this);"+
	                        "if(!$star.hasClass('big')){"+
		                        "$star.raty({"+
		                            "starOff: '/ecommerce/templates/public/images/star-off.png',"+
		                            "starOn: '/ecommerce/templates/public/images/star-on.png',"+
		                            "space: false,"+
		                            "readOnly: true,"+
		                            "score: function() {"+
		                                "return $(this).attr('data-score');"+
		                            "}"+
		                        "});"+
		                     "}"+
		                "});"+
		            "}"+
		        "});"+
			"</script>";
		}
		return str;
	}
	@RequestMapping("/view/{idOrder}")
	public String view(@PathVariable("idOrder") int idOrder, ModelMap modelMap, Principal principal){
		if(principal == null){
			return "redirect:/";
		}
		if(orderDao.vieworder(principal.getName()).getId_order() != idOrder){
			return "redirect:/";
		}
		modelMap.addAttribute("objOrder", orderDao.getItem(idOrder));
		modelMap.addAttribute("alOrderItem",orderItemDao.getItemsByIdOrder(idOrder));
		return "public.order.view";
	}
	@RequestMapping("/sua/{idUser}")
	public String edit(@PathVariable("idUser") int idUser, ModelMap modelMap, Principal principal){
		if(principal == null){
			return "redirect:/";
		}
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if(sobjUser.getId_user() != idUser){
			return "redirect:/";
		}
		User objUser = userDao.getItem(idUser);
		modelMap.addAttribute("access", "access");
		modelMap.addAttribute("sobjUser", sobjUser);
		modelMap.addAttribute("objUser", objUser);
		return "public.index.editUser";
	}
	@RequestMapping(value="/sua/{idUser}", method=RequestMethod.POST)
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
		return "redirect:/sua/"+idUser;
	}
}
