package controller;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.BrandDao;
import dao.CatDao;
import dao.ProductDao;
import dao.UserDao;
import entities.Cart;
import entities.User;
import utils.StringUtils;

@Controller
public class AuthController {
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CatDao catDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private StringUtils stringUtils;
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
		}
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart != null){
			modelMap.addAttribute("alCart", alCart);
		}
	}
	@RequestMapping("/login")
	public String login(){
		return "public.auth.login";
	}
	@RequestMapping("/signup")
	public String signup(){
		return "public.auth.login";
	}
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public String add(@Valid @ModelAttribute("objUser") User objUser,BindingResult result ,RedirectAttributes redirectAttributes){
		if(result.hasErrors()){
			return "public.auth.login";
		}
		if(!userDao.checkUsername(objUser.getUsername())){
			redirectAttributes.addFlashAttribute("msg","Username đã tồn tại");
			return "redirect:/signup";
		}
		
		if(objUser.getRole()== null){
			objUser.setRole("Member");
		}
		System.out.println(objUser.getUsername());
		objUser.setPassword(stringUtils.md5(objUser.getPassword()));
		if(userDao.addItem(objUser)>0){
			redirectAttributes.addFlashAttribute("message", "Đăng kí thành công");
		} else{
			redirectAttributes.addFlashAttribute("message", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/signup";
	}
	@RequestMapping("/403")
	public String error403(){
		return "redirect:/";
	}
	@RequestMapping("/admin/err403")
	public String err403(){
		return "auth.error403";
	}
}
