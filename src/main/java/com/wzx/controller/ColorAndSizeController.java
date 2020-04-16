package com.wzx.controller;


import java.io.File;
import java.util.LinkedHashSet;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wzx.pojo.Category;
import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.Product;
import com.wzx.pojo.ProductImage;
import com.wzx.pojo.TopCategory;
import com.wzx.service.CategoryService;
import com.wzx.service.ColorAndSizeService;
import com.wzx.service.OrderItemService;
import com.wzx.service.ProductImageService;
import com.wzx.service.ProductService;
import com.wzx.service.TopCategoryService;
import com.wzx.util.Page;

@Controller
@RequestMapping("")
public class ColorAndSizeController {
	@Autowired
	ColorAndSizeService colorAndSizeService;
	@Autowired
	ProductService productService;
	@Autowired
	ProductImageService productImageService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	TopCategoryService topCategoryService;
	@Autowired
	OrderItemService orderItemService;
	@RequestMapping("admin_colorAndSize_list")
	public String  list(int pid,Model model,HttpSession session) {
		Product product = productService.get(pid);
		Category category = categoryService.get(product.getCid());
		TopCategory tc= topCategoryService.get(category.getTcid());
		List<ColorAndSize> colorAndSizes= colorAndSizeService.list(pid);
		System.err.println(colorAndSizes.toString());
		LinkedHashSet<String> colors = colorAndSizeService.listColor(pid);
//		 page.setTotal(total);
//		 page.setParam("&pid="+pid);//告诉返回的页面是哪个产品下的颜色尺码管理
		 String isadd = "";
	        isadd=(String) session.getAttribute("isadd");
	        if(isadd!=null&&isadd.equals("true")) {
	        	model.addAttribute("msg", "success");
	        	session.removeAttribute("isadd");
	        }
	        String deleteWaringByOrder = (String) session.getAttribute("deleteWaringByOrder");
	    	 if (deleteWaringByOrder!=null&&deleteWaringByOrder.equals("true")) {
	         	model.addAttribute("deleteWaringByOrder", "删除失败，该产品款式存在订单交易信息");
	         	 session.removeAttribute("deleteWaringByOrder");
	 		}
	        
	     model.addAttribute("cs", colorAndSizes);
	     model.addAttribute("colors", colors);
	     model.addAttribute("p", product);
	     model.addAttribute("c", category);
	     model.addAttribute("tc", tc);
		return "admin/listColorAndSize";
		
	}
	@RequestMapping("admin_colorAndSize_add")
	public String add(ColorAndSize colorAndSize,Model model,HttpSession session)
	{
		colorAndSizeService.add(colorAndSize);
		session.setAttribute("isadd", "true");
		return "redirect:admin_colorAndSize_list?pid="+colorAndSize.getPid();
	}
	@RequestMapping("admin_colorAndSize_delete")
	public String delete(int id,HttpSession session) {
		ColorAndSize cs = colorAndSizeService.get(id);
		//只有该颜色尺码不存在订单信息中才能删除
		if(orderItemService.isExistCSInfo(id)) {
			session.setAttribute("deleteWaringByOrder", "true");
			return "redirect:admin_colorAndSize_list?pid="+cs.getPid();
		}
		colorAndSizeService.delete(id);
		List<ColorAndSize> colorAndSizes= colorAndSizeService.listbyColor(cs.getPid(), cs.getColorValue());
		if(colorAndSizes.size()==0) {
			List<ProductImage> ps = productImageService.deletebycolor(cs.getPid(), cs.getColorValue());
			String imageFolder= session.getServletContext().getRealPath("img/productSingle");
			String   imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
			String  imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
			
			for(ProductImage pr:ps) {
				File imageFile = new File(imageFolder,pr.getProductImageId()+".jpg");
	            File f_small = new File(imageFolder_small,pr.getProductImageId()+".jpg");
	            File f_middle = new File(imageFolder_middle,pr.getProductImageId()+".jpg");
	            imageFile.delete();
	            f_small.delete();
	            f_middle.delete();
			}
			
	            
			
		}
		return "redirect:admin_colorAndSize_list?pid="+cs.getPid();
	}
	@RequestMapping("admin_colorAndSize_edit")
	public String edit(Model model, int id) {
		ColorAndSize cs = colorAndSizeService.get(id);
		Product p = productService.get(cs.getPid());
        Category c = categoryService.get(p.getCid());
        TopCategory tc= topCategoryService.get(c.getTcid());
	     
        p.setCategory(c);
        model.addAttribute("p", p);
		model.addAttribute("cs", cs);
		model.addAttribute("tc", tc);
		return "admin/editColorAndSize";
	}
	@RequestMapping("admin_colorAndSize_update")
	public String update(ColorAndSize cs,HttpSession session) {
		colorAndSizeService.update(cs);
		session.setAttribute("isadd", "true");
		return "redirect:admin_colorAndSize_list?pid="+cs.getPid();
	}
	@RequestMapping("admin_check_colorAndSize")
	@ResponseBody
	public String checkcs(String color,String size,Integer pid,Integer csid) {
		ColorAndSize cs= colorAndSizeService.get(color, size,pid);
		if(csid==null) {
			if(cs!=null&&cs.getPid()==pid) {
				return "exist";
			}
			else 
				return "notExist";
		}
		else if(cs!=null&&cs.getCsid()!=csid&&cs.getPid()==pid)
			return "exist";
		return "notExist";
	}
	
}
