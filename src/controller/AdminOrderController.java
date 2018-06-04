package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.BrandDao;
import dao.CatDao;
import dao.OrderDao;
import dao.OrderItemDao;
import utils.StringUtils;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {
	@Autowired
	private Defines defines;
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CatDao catDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderItemDao orderItemDao;
	@Autowired
	private StringUtils stringUtils;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
		modelMap.addAttribute("alCat", catDao.getItems());
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("alBrand", brandDao.getItems());
		modelMap.addAttribute("stringUtils", stringUtils);
	}
	@RequestMapping("")
	public String index(@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap){
		int row_count = defines.getROW_COUNT_ADMIN();
		int totalPage = (int)Math.ceil((float)orderDao.getSumAll()/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1)*row_count;
		modelMap.addAttribute("alOrder", orderDao.getItems(offset, row_count));
		modelMap.addAttribute("sumPage", totalPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_ADMIN());
		return "admin.order.index";
	}
	@RequestMapping("/view/{idOrder}")
	public String view(@PathVariable("idOrder") int idOrder, ModelMap modelMap){
		modelMap.addAttribute("objOrder", orderDao.getItem(idOrder));
		modelMap.addAttribute("alOrderItem",orderItemDao.getItemsByIdOrder(idOrder));
		return "admin.order.view";
	}
	@RequestMapping("/del/{idOrder}")
	public String del(@PathVariable("idOrder") int idOrder, ModelMap modelMap, RedirectAttributes redirectAttributes){
		if(orderDao.delItem(idOrder) > 0){
			orderItemDao.delItems(idOrder);
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi tring quá trình xử lý");
		}
		return "redirect:/admin/order";
	}
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public String search(@RequestParam("from_date") String from_date, @RequestParam("to_date") String to_date, ModelMap modelMap){
		System.out.println(from_date +"/"+to_date);
		modelMap.addAttribute("alOrder", orderDao.searchItems(from_date, to_date));
		return "admin.order.search";
	}
}
