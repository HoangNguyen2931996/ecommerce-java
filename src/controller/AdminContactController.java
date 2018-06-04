package controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.ContactDao;
import dao.UserDao;
import entities.Contact;
import entities.User;

@Controller
@RequestMapping("admin/contact")
public class AdminContactController {
	@Autowired
	private Defines defines;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private UserDao userDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap, Principal principal){
		int row_count = defines.getROW_COUNT_ADMIN();
		int totalPage = (int)Math.ceil((float)contactDao.getSumAll()/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_PUBLIC()/2);
		int offset = (currentPage - 1)*row_count;
		modelMap.addAttribute("alContact", contactDao.getItems(offset, row_count));
		modelMap.addAttribute("sumPage", totalPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_PUBLIC());
		return "admin.contact.index";
	}
	@RequestMapping("/view/{idContact}")
	public String edit(@PathVariable("idContact") int idContact, ModelMap modelMap){
		modelMap.addAttribute("objContact", contactDao.getItem(idContact));
		return "admin.contact.view";
	}
	@RequestMapping("/del/{idContact}")
	public String del(@PathVariable("idContact") int idContact, RedirectAttributes redirectAttributes){
		if(contactDao.delItem(idContact) > 0){
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công!");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Có lỗi trong quá trình xử lý!");
		}
		return "redirect:/admin/contact";
	}
	@RequestMapping("/answer/{idContact}")
	public String answer(@PathVariable("idContact") int idContact, ModelMap modelMap, Principal principal){
		User sobjUser = userDao.getItemByUsername(principal.getName());
		if("Mod".equals(sobjUser.getRole())){
			return "redirect:/admin/err403";
		}
		modelMap.addAttribute("objContact", contactDao.getItem(idContact));
		return "admin.contact.answer";
	}
	@RequestMapping(value="/answer/{idContact}", method=RequestMethod.POST)
	public String answer(@PathVariable("idContact") int idContact, @RequestParam("title") String title, @RequestParam("content") String content, RedirectAttributes redirectAttributes){
		Contact objContact = contactDao.getItem(idContact);
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo(objContact.getMail());
		email.setSubject(title);
		email.setText(content);
		try{
			mailSender.send(email);
			if(contactDao.updateStatus(idContact) > 0){
				redirectAttributes.addFlashAttribute("msg", "Thư đã gởi");
			}
		} catch(MailException mailException){
			redirectAttributes.addFlashAttribute("msg","Xảy ra lỗi trong quá trình gửi thư");
		}
		return "redirect:/admin/contact";
	}
}