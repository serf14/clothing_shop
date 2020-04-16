package com.wzx.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzx.pojo.Category;
import com.wzx.pojo.TopCategory;
import com.wzx.service.CategoryService;
import com.wzx.service.TopCategoryService;
import com.wzx.util.Page;
@Controller
@RequestMapping("")
public class CategoryController {
	  @Autowired
	   CategoryService categoryService;
	  @Autowired
	   TopCategoryService topCategoryService;
	  @RequestMapping("admin_list_Category")
	  public String list(Model model,Page page,Integer tcid,HttpSession session) {
		  TopCategory tc = new TopCategory();
		  List<TopCategory> tcs=topCategoryService.list();
		  List<Category> cs=new ArrayList<Category>();
		  PageHelper.offsetPage(page.getStart(),page.getCount());
		  	if(tcid!=null&&tcid!=0) {
				  cs= categoryService.listByTcid(tcid);
				  tc= topCategoryService.get(tcid);
		  	}
		  	else {
		  		cs= categoryService.list();
		  		tcid=0;
		  		tc.setTopCategoryId(0);
		  		tc.setTopCategoryName("所有分类");
		  	}
	        int total = (int) new PageInfo<>(cs).getTotal();
	        
	        page.setTotal(total);
	        page.setParam("&tcid="+tcid);
	        String isadd = "";
	        isadd=(String) session.getAttribute("isadd");
	        if(isadd!=null&&isadd.equals("true")) {
	        	model.addAttribute("msg", "success");
	           	session.removeAttribute("isadd");
	        }
	        
	    	String deleteWaring = (String) session.getAttribute("deleteWaring");
	    	 if (deleteWaring!=null&&deleteWaring.equals("true")) {
	         	model.addAttribute("deleteWaring", "删除失败，该分类下存在子项");
	         	 session.removeAttribute("deleteWaring");
	 		}
	    	
	    	
	        model.addAttribute("cs", cs);
	        model.addAttribute("tc", tc);
	        model.addAttribute("tcs", tcs);
	        model.addAttribute("page", page);
	        return "admin/listCategory";
	 
	  }
	  @RequestMapping("admin_list_SearchCategory")
	  public String listSearch(Model model,Page page,int tcid,String name,HttpSession session) throws UnsupportedEncodingException {
		  	TopCategory tc = topCategoryService.get(tcid);
		  	
		  	name = URLDecoder.decode(name, "UTF-8");
		  	PageHelper.offsetPage(page.getStart(),5);
		  	List<Category> cs= categoryService.listByTcidAndName(tcid, name);
	        int total = (int) new PageInfo<>(cs).getTotal();
	    	
//	        转码问题，将中文字符的参数转义成utf_8b编码格式
	    	 name = URLEncoder.encode(URLEncoder.encode(name, "UTF-8"),"UTF-8");
	    	 String s = "&tcid="+tcid+"&name="+name;
		  	 page.setParam(s);
	        page.setTotal(total);
	       
	        String isadd = "";
	        isadd=(String) session.getAttribute("isadd");
	        if(isadd!=null&&isadd.equals("true")) {
	        	model.addAttribute("msg", "success");
	        	session.setAttribute("isadd", "false");
	        }
	        model.addAttribute("cs", cs);
	        model.addAttribute("tc", tc);
	        model.addAttribute("page", page);
	        return "admin/listCategory";
	 
	  }
	  
	  @RequestMapping("admin_add_Category")
	  public String add(Category c, HttpSession session) throws IOException {
	      categoryService.add(c);
	      session.setAttribute("isadd", "true");
	      return "redirect:/admin_list_Category?tcid="+c.getTcid();
	  }
	  
	  @RequestMapping("admin_delete_Category")
	  public String delete(Integer id,HttpSession session)throws IOException {
		  Category c= categoryService.get(id);
		  try {
			  categoryService.delete(id);
		} catch (Exception e) {
			session.setAttribute("deleteWaring", "true");
		}
		 
		  return "redirect:/admin_list_Category?tcid="+c.getTcid();
	  }
	  @RequestMapping("admin_edit_Category")
	  public String edit(int id,Model model) throws IOException {
	      Category c= categoryService.get(id);
	      TopCategory tc= topCategoryService.get(c.getTcid());
	      int  total =categoryService.total();
	      model.addAttribute("tc", tc);
	      model.addAttribute("c", c);
	      model.addAttribute("total", total);
	      return "admin/editCategory";
	  }
	  @RequestMapping("admin_update_Category")
	  public String update(Category c, HttpSession session) throws IOException {
		    categoryService.update(c);
		    session.setAttribute("isadd", "true");
		    return "redirect:/admin_list_Category?tcid="+c.getTcid();
		}
	
	  @RequestMapping("admin_check_Category")
	  @ResponseBody
	  public String checktp(String name,int id) {
		  if (categoryService.isExist(name,id)) {
			  return"exist";
		}
		  return"notExist";
	  }
	  @RequestMapping(value = "admin_list_CategoryByTcid", produces = "application/json;charset=utf-8")
	  @ResponseBody
	  public List<Category> listByTcid(Integer tcid) {
		  if (tcid==0) {
			  return null;
		}
		  return categoryService.listByTcid(tcid);
	  }
	  @RequestMapping("admin_category_up")
	  @ResponseBody
	  public String upIsShow(Category category) {
		  
		  categoryService.update(category);
		  return null;
	  }
	  
}
