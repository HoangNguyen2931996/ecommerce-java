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
import dao.OrderDao;
import dao.OrderItemDao;
import dao.PaymentDao;
import dao.ProductDao;
import dao.UserDao;
import entities.Cart;
import entities.Order;
import utils.StringUtils;

@Controller
@RequestMapping("/checkout")
public class PublicCheckoutController {
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CatDao catDao;
	@Autowired
	private StringUtils stringUtils;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderItemDao orderItemDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private PaymentDao paymentDao;
	
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
	public String index(ModelMap modelMap, HttpServletRequest request, Principal principal){
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart != null){
			modelMap.addAttribute("alCart", alCart);
		} else{
			return "redirect:/";
		}
		modelMap.addAttribute("alPayment", paymentDao.getItems());
		modelMap.addAttribute("active1", "checkout");
		modelMap.addAttribute("objUser", userDao.getItemByUsername(principal.getName()));
		return "public.checkout.index";
	}
	@RequestMapping(value="", method=RequestMethod.POST)
	public String index(@ModelAttribute("objOder") Order objOrder,HttpServletRequest request, Principal principal, ModelMap modelMap){
		if(objOrder.getId_payment() == 0){
			return "redirect:/checkout";
		}
		objOrder.setName_payment(paymentDao.getItemById(objOrder.getId_payment()).getName_payment());
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		int total_order = 0;
		if(alCart != null){
			for (Cart objCart : alCart) {
				total_order += objCart.getTotal_amount();
			}
		}
		objOrder.setTotal_order(total_order);
		objOrder.setUsername(principal.getName());
		session.setAttribute("objOrder", objOrder);
		return "redirect:/checkout/confirm";
	}
	@RequestMapping("/confirm")
	public String invoice(HttpServletRequest request, ModelMap modelMap){
		HttpSession session = request.getSession();
		Order objOrder = (Order) session.getAttribute("objOrder");
		if(objOrder != null){
			modelMap.addAttribute("objOrder", objOrder);
		} else{
			return "redirect:/";
		}
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(alCart != null){
			modelMap.addAttribute("alCart", alCart);
		}
		return "public.checkout.invoice";
	}
	@RequestMapping(value="/confirm", method=RequestMethod.POST)
	public String invoice(HttpServletRequest request, RedirectAttributes redirectAttributes){
		HttpSession session = request.getSession();
		Order objOrder = (Order) session.getAttribute("objOrder");
		@SuppressWarnings("unchecked")
		ArrayList<Cart> alCart = (ArrayList<Cart>) session.getAttribute("alCart");
		if(objOrder != null && alCart != null){
			int id_order = orderDao.addOrder(objOrder);
			for (Cart objCart : alCart) {
				if(orderItemDao.addOrderItem(objCart, id_order)>0){
					
				}else{
					
				}
			}
			session.removeAttribute("alCart");
			session.removeAttribute("objOrder");
			redirectAttributes.addFlashAttribute("success", "1");
		}
		return "redirect:/";
	}
}
