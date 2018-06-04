package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import constant.Defines;
import dao.ReviewDao;

@Controller
@RequestMapping("admin/review")
public class AdminReviewController {
	@Autowired
	private Defines defines;
	@Autowired
	private ReviewDao reviewDao;
	@ModelAttribute
	public void addCommonsObject(ModelMap modelMap){
		modelMap.addAttribute("defines", defines);
	} 
	@RequestMapping("")
	public String index(@RequestParam(value="page", defaultValue="1") int currentPage, ModelMap modelMap){
		int row_count = defines.getROW_COUNT_ADMIN();
		int totalPage = (int)Math.ceil((float)reviewDao.getSumAll()/row_count);
		int numLink = (int)Math.floor((float) defines.getPAGE_NUM_ADMIN()/2);
		int offset = (currentPage - 1)*row_count;
		modelMap.addAttribute("alReview", reviewDao.getItems(offset, row_count));
		modelMap.addAttribute("sumPage", totalPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numLink", numLink);
		modelMap.addAttribute("pageNum", defines.getPAGE_NUM_ADMIN());
		return "admin.review.index";
	}
	@RequestMapping("/view/{id_review}")
	public String edit(@PathVariable("id_review") int id_review, ModelMap modelMap){
		modelMap.addAttribute("objReview", reviewDao.getItem(id_review));
		return "admin.review.view";
	}
	@RequestMapping("/del/{id_review}")
	public String del(@PathVariable("id_review") int id_review, RedirectAttributes redirectAttributes){
		if(reviewDao.delItem(id_review) > 0){
			redirectAttributes.addFlashAttribute("msg", "Xóa thành công!");
		} else{
			redirectAttributes.addFlashAttribute("msg", "Có lỗi trong quá trình xử lý!");
		}
		return "redirect:/admin/review";
	}

}