package controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import constant.Defines;
import dao.BrandDao;
import dao.CatDao;
import dao.ContactDao;
import dao.OrderDao;
import dao.ProductDao;
import dao.ReviewDao;
import dao.UserDao;
import entities.Brand;
import entities.Cat;
import entities.Chart;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CatDao catDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private UserDao userDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(ModelMap modelMap){
		ArrayList<Chart> alChartBrand = new ArrayList<>();
		ArrayList<Chart> alChartCat = new ArrayList<>();
		for (Brand objBrand : brandDao.getItems()) {
			Chart objChart = new Chart(objBrand.getName_brand(),productDao.getTotalByIdBrand(objBrand.getId_brand()));
			alChartBrand.add(objChart);
		}
		for (Cat objCat : catDao.getItems()) {
			if(objCat.getId_parent() !=0){
				Chart objChart = new Chart(objCat.getName_cat(), catDao.getTotalByIdCat(objCat.getId_cat()));
				alChartCat.add(objChart);
			}
		}
		modelMap.addAttribute("alChartCat", alChartCat);
		modelMap.addAttribute("objNewUser", userDao.getItemNew());
		modelMap.addAttribute("objNewContact", contactDao.getItemNew());
		modelMap.addAttribute("objNewReview", reviewDao.getItemNew());
		modelMap.addAttribute("objNewOrder", orderDao.getItemNew());
		modelMap.addAttribute("alChartBrand", alChartBrand);
		return "admin.dashboard.index";
	}
}