package com.wzx.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzx.pojo.Administrator;
import com.wzx.service.AdministratorService;
import com.wzx.util.Page;

@Controller
@RequestMapping("")
public class AdministratorController {

	 @Autowired
	 AdministratorService administratorService;
	 
	
	 @RequestMapping("LoginByAdmin")
	 public String login(@RequestParam("account") String account, @RequestParam("password") String password, Model model, HttpSession session) {
		 account = HtmlUtils.htmlEscape(account);
	        
	 
	        if(!administratorService.isExist(account)){
	            model.addAttribute("msg", "账号不存在");
	            return "admin/adminLogin";
	        }
	        else if(!administratorService.isRight(account, password)){
	        	model.addAttribute("msg", "密码错误");
	            return "admin/adminLogin";
	        }
	        Administrator administrator = administratorService.get(account, password);
	        session.setAttribute("administrator", administrator);
	        return "redirect:admin_shop_detail";
	    }
	 
	    @RequestMapping("admin_logout")
	    public String logout( HttpSession session) {
	        session.removeAttribute("administrator");
	        return "redirect:loginAdmin";
	    }
	 @RequestMapping("admin_list_Administrator")
	 public String list(Model model, Page page,HttpSession session){
	        PageHelper.offsetPage(page.getStart(),page.getCount());
	 
	        List<Administrator> as= administratorService.list();
	        int total = (int) new PageInfo<>(as).getTotal();
	        page.setTotal(total);
	        String isfirSt = "";
	        isfirSt=(String) session.getAttribute("isFirst");
	        if (isfirSt!=null&&isfirSt.equals("true")) {
	        	model.addAttribute("msg", "success");
	        	session.removeAttribute("isFirst");
			}
	        
	        model.addAttribute("as", as);
	        model.addAttribute("page", page);
	 
	        return "admin/listAdmins";
	    }
	 @RequestMapping("admin_add_Administrator")
	 public String create(Model model,Administrator administrator,HttpSession session) {
		 administratorService.add(administrator);
		 session.setAttribute("isFirst", "true");
		 return "redirect:admin_list_Administrator";
		 }
	 @RequestMapping("admin_checkAccount")
	 @ResponseBody
	 public String checkAccount(String account){
		 if(administratorService.isExist(account))
		 return"exist";
		 
		 return "notExist";
	 }
	 
}
