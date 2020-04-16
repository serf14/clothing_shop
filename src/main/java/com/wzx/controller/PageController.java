package com.wzx.controller;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wzx.service.TopCategoryService;


//单纯用来做服务端跳转
@Controller
@RequestMapping("")
public class PageController {
	
	@Autowired
	TopCategoryService topCategoryService;
	
    @RequestMapping("registerPage")
    public String registerPage(Model model) {
        return "fore/register";
    }
    @RequestMapping("registerSuccessPage")
    public String registerSuccessPage(Model model) {
    	return "fore/registerSuccess";
    }
    @RequestMapping("editPasswordSuccessPage")
    public String editPasswordSuccessPage(Model model) {
    	return "fore/editPasswordSuccess";
    }
    
    
    @RequestMapping("loginPage")
    public String loginPage(Model model) {
        return "fore/login";
    }
    @RequestMapping("loginAdmin")
	 public String tologin() {
		 return"admin/adminLogin";
	 }
    @RequestMapping("forealipay")
    public String alipay(Model model){
        return "fore/alipay";
    }
    

    
}