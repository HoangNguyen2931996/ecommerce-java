package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.PaymentDao;
import entities.Payment;

@Controller
@RequestMapping("admin/payment")
public class AdminPaymentController {
	@Autowired
	private Defines defines;
	@Autowired
	private PaymentDao paymentDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(ModelMap modelMap){
		modelMap.addAttribute("alPayment", paymentDao.getItems());
		return "admin.payment.index";
	}
	@RequestMapping("/add")
	public String add(){
		return "admin.payment.add";
	}
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@ModelAttribute("objPayment") Payment objPayment, RedirectAttributes redirectAttributes){
		if(paymentDao.addItem(objPayment) > 0){
			redirectAttributes.addFlashAttribute("msg", "Thêm thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/payment/add";
	}
	@RequestMapping("/edit/{idPayment}")
	public String edit(@PathVariable("idPayment") int idPayment, ModelMap modelMap){
		modelMap.addAttribute("objPayment", paymentDao.getItemById(idPayment));
		return "admin.payment.edit";
	}
	@RequestMapping(value="/edit/{idPayment}", method=RequestMethod.POST)
	public String edit(@ModelAttribute("objPayment") Payment objPayment ,@PathVariable("idPayment") int idPayment, RedirectAttributes redirectAttributes){
		objPayment.setId_payment(idPayment);
		if(paymentDao.editItem(objPayment) > 0){
			redirectAttributes.addFlashAttribute("msg", "Sửa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/payment";
	}
	@RequestMapping("/del/{idPayment}")
	public String del(@PathVariable("idPayment") int idPayment, RedirectAttributes redirectAttributes){
		if(paymentDao.delItem(idPayment) > 0){
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Xảy ra lỗi trong quá trình xử lý");
		}
		return "redirect:/admin/payment";
	}
}