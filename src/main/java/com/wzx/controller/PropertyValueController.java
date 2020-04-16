package com.wzx.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wzx.pojo.Category;
import com.wzx.pojo.Product;
import com.wzx.pojo.PropertyValue;
import com.wzx.pojo.TopCategory;
import com.wzx.service.CategoryService;
import com.wzx.service.ProductService;
import com.wzx.service.PropertyValueService;
import com.wzx.service.TopCategoryService;

@Controller
@RequestMapping("")
public class PropertyValueController {
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    ProductService productService;
    @Autowired
	CategoryService categoryService;
	@Autowired
	TopCategoryService topCategoryService;
    @RequestMapping("admin_propertyValue_edit")
    public String edit(Model model,int pid) {
        Product p = productService.get(pid);
        propertyValueService.init(p);
        List<PropertyValue> pvs = propertyValueService.list(p.getProductId());
        Category c = categoryService.get(p.getCid());
        TopCategory tc= topCategoryService.get(c.getTcid());
        model.addAttribute("p", p);
        model.addAttribute("c", c);
        model.addAttribute("tc", tc);
        model.addAttribute("pvs", pvs);
        return "admin/editPropertyValue";
    }
    @RequestMapping("admin_propertyValue_update")
    @ResponseBody
    public String update(PropertyValue pv) {
        propertyValueService.update(pv);
        return "success";
    }
}