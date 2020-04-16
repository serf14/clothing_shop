package com.wzx.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzx.pojo.TopCategory;
import com.wzx.service.TopCategoryService;
import com.wzx.util.Page;

@Controller
@RequestMapping("")
public class TopCategoryController {

	@Autowired
	TopCategoryService TopCategoryService;
	
	@RequestMapping("admin_list_TopCategory")
	public String list(Model model,Page page,HttpSession session) {
		String addtp = (String) session.getAttribute("addtp");
		String deleteWaring = (String) session.getAttribute("deleteWaring");
		 if(addtp!=null&&addtp.equals("true")) {
			 model.addAttribute("msg", "success");
			 session.removeAttribute("addtp");
		 }
	  	PageHelper.offsetPage(page.getStart(),5);
	  	List<TopCategory> tcs= TopCategoryService.list();
        int total = (int) new PageInfo<>(tcs).getTotal();

        page.setTotal(total);
        model.addAttribute("tcs", tcs);
        model.addAttribute("page", page);
        if (deleteWaring!=null&&deleteWaring.equals("true")) {
        	model.addAttribute("deleteWaring", "删除失败，该分类下存在子项");
        	 session.removeAttribute("deleteWaring");
		}
        return "admin/listTopCategory";
 
  }
	@RequestMapping("admin_add_TopCategory")
	  public String add(TopCategory tc,HttpSession session) throws IOException {
	      TopCategoryService.add(tc);
	      session.setAttribute("addtp", "true");
	      return "redirect:/admin_list_TopCategory";
	  }
	  
	  @RequestMapping("admin_delete_TopCategory")
	  public String delete(Integer tcid,HttpSession session) {
		  try {
			  TopCategoryService.delete(tcid);
		} catch (Exception e) {
			session.setAttribute("deleteWaring", "true");
		}
		 
		  return "redirect:/admin_list_TopCategory";
	  }
	  @RequestMapping("admin_edit_TopCategory")
	  public String edit(int tcid,Model model) throws IOException {
	      TopCategory tc= TopCategoryService.get(tcid);
	      model.addAttribute("tc", tc);
	      return "admin/editTopCategory";
	  }
	  @RequestMapping("admin_update_TopCategory")
	  public String update(TopCategory tc,HttpSession session) throws IOException {
		    TopCategoryService.update(tc);
		    session.setAttribute("addtp", "true");
		    return "redirect:/admin_list_TopCategory";
		}
	  @RequestMapping("admin_check_TopCategory")
	  @ResponseBody
	  public String checktp(String name) {
		  if (TopCategoryService.isExist(name)) {
			  return"exist";
		}
		  return"notExist";
	  }

}
