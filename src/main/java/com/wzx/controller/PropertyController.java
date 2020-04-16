package com.wzx.controller;

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
import com.wzx.pojo.Property;
import com.wzx.pojo.TopCategory;
import com.wzx.service.CategoryService;
import com.wzx.service.PropertyService;
import com.wzx.service.TopCategoryService;
import com.wzx.util.Page;

@Controller
@RequestMapping("")
public class PropertyController {
	 	@Autowired
	    CategoryService categoryService;
	    @Autowired
	    PropertyService propertyService;
	    @Autowired
	    TopCategoryService topCategoryService;
	    @RequestMapping("admin_property_add")
	    public String add(Model model, Property p,HttpSession session) {
	        propertyService.add(p);
	        session.setAttribute("isadd", "true");
	        return "redirect:admin_property_list?cid="+p.getCid();
	    }
	 
	    @RequestMapping("admin_property_delete")
	    public String delete(int id) {
	        Property p = propertyService.get(id);
	        propertyService.delete(id);
	        return "redirect:admin_property_list?cid="+p.getCid();
	    }
	 
	    @RequestMapping("admin_property_edit")
	    public String edit(Model model, int id) {
	        Property p = propertyService.get(id);
	        Category c = categoryService.get(p.getCid());
	        TopCategory tc= topCategoryService.get(c.getTcid());
	       
	        p.setCategory(c);
	        model.addAttribute("tc", tc);
	        model.addAttribute("p", p);
	        return "admin/editProperty";
	    }
	 
	    @RequestMapping("admin_property_update")
	    public String update(Property p,HttpSession session) {
	        propertyService.update(p);
	        session.setAttribute("isadd", "true");
	        return "redirect:admin_property_list?cid="+p.getCid();
	    }
	 
	    @RequestMapping("admin_property_list")
	    public String list(int cid, Model model,Page page,HttpSession session) {
	        Category c = categoryService.get(cid);
	        TopCategory tc= topCategoryService.get(c.getTcid());
		      
	        PageHelper.offsetPage(page.getStart(),page.getCount());
	        List<Property> ps = propertyService.list(cid);
	 
	        int total = (int) new PageInfo<>(ps).getTotal();
	        page.setTotal(total);
	        page.setParam("&cid="+c.getCategoryId());
	        String isadd = "";
	        isadd=(String) session.getAttribute("isadd");
	        if(isadd!=null&&isadd.equals("true")) {
	        	model.addAttribute("msg", "success");
	        	session.setAttribute("isadd", "false");
	        }
	        model.addAttribute("ps", ps);
	        model.addAttribute("c", c);
	        model.addAttribute("tc", tc);
	        model.addAttribute("page", page);
	 
	        return "admin/listProperty";
	    }
	    @RequestMapping("admin_check_property")
	    @ResponseBody
		  public String checkpt(String name,int cid) {
			  if (propertyService.isExist(name,cid)) {
				  return"exist";
			}
			  return"notExist";
		  }
}
