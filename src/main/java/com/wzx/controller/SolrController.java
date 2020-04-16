package com.wzx.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wzx.pojo.Product;
import com.wzx.service.ProductService;
import com.wzx.service.SolrService;
@Controller
public class SolrController {
	   @Autowired
	    SolrService solrService;
	   @Autowired
	   ProductService porductService;
	   @RequestMapping("admin_import_product")
	   public String importProduct(Model model) {
		 List<Product>  list = porductService.listallshow();
		   solrService.importProduct(list);
		   
		return "redirect:admin_shop_detail";
		   
	   }
}
