package controller;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.BrandDao;
import dao.CatDao;
import dao.ContactDao;
import dao.OrderDao;
import dao.ProductDao;
import dao.UserDao;
import entities.Cart;
import entities.Contact;
import utils.StringUtils;

@Controller
@RequestMapping("/lien-he")
public class PublicContactController {
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CatDao catDao;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private StringUtils stringUtils;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrderDao orderDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap, HttpServletRequest request, Principal principal){
		modelMap.addAttribute("defines", defines);
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("stringUtils", stringUtils);
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
		modelMap.addAttribute("active1", "Liên hệ");
		return "public.contact.index";
	}
	@RequestMapping(value="", method=RequestMethod.POST)
	public String index(@ModelAttribute("objContact") Contact objContact, RedirectAttributes redirectAttributes){
		if(contactDao.addItem(objContact)>0){
			redirectAttributes.addFlashAttribute("msg","Thư của bạn đã được gởi đi");
		}else{
			redirectAttributes.addFlashAttribute("msg","Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/lien-he";
	}
}
