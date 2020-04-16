package com.wzx.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.tools.classfile.StackMapTable_attribute.same_frame;
import com.wzx.pojo.Category;
import com.wzx.pojo.Product;
import com.wzx.pojo.TopCategory;
import com.wzx.service.CategoryService;
import com.wzx.service.OrderItemService;
import com.wzx.service.ProductService;
import com.wzx.service.SolrService;
import com.wzx.service.TopCategoryService;
import com.wzx.util.Page;

@Controller
@RequestMapping("")
public class ProductController {

	 	@Autowired
	    CategoryService categoryService;
	    @Autowired
	    ProductService productService;
	    @Autowired
		TopCategoryService topCategoryService;
	    @Autowired
	    SolrService solrService;
	    @Autowired
	    OrderItemService orderItemService;
	    @RequestMapping("admin_product_add")
	    public String add(Product p,HttpSession session) {
	        p.setCreateDate(new Date());
	        p.setStatus(0);
	        productService.add(p);
	        session.setAttribute("isadd", "true");
	        return "redirect:admin_product_list?cid="+p.getCid();
	    }
	    @RequestMapping("admin_product_addpage")
	    public String addpage(Model model) {
	    	List<TopCategory> tcs=topCategoryService.list();
	    	model.addAttribute("tcs", tcs);
	    	return "admin/addProduct";
	    }
	 
	    @RequestMapping("admin_product_delete")
	    public String delete(int id,HttpSession session) {
	        Product p = productService.get(id);
	       //只有当产品不存在与任何订单中才能删除
	        if (orderItemService.isExistProductInfo(id)) {
	        	session.setAttribute("deleteWaringByOrder", "true");
	        	return "redirect:admin_product_list?cid="+p.getCid();
			}
	        try {
	        	 productService.delete(id);
	        	 solrService.remove(id+"");
			} catch (Exception e) {
				session.setAttribute("deleteWaring", "true");
			}
	       
	        return "redirect:admin_product_list?cid="+p.getCid();
	    }
	 
	    @RequestMapping("admin_product_edit")
	    public String edit(Model model, int id) {
	        Product p = productService.get(id);
	        Category c = categoryService.get(p.getCid());
	        TopCategory tc= topCategoryService.get(c.getTcid());
	        p.setCategory(c);
	        model.addAttribute("p", p);
	        model.addAttribute("tc", tc);
	        return "admin/editProduct";
	    }
	 
	    @RequestMapping("admin_product_update")
	    public String update(Product p,HttpSession session) {
	    	p.setUpdateDate(new Date());
	        productService.update(p);
	        if (p.getStatus()==1) {
	        	solrService.add(p);
			}
	        session.setAttribute("isadd", "true");
	        return "redirect:admin_product_list?cid="+p.getCid();
	    }
	    
	    @RequestMapping("admin_product_up")
	    public String up(Integer id,Integer cid,HttpSession session) {
	        Product p = new Product();
	        p.setProductId(id);
	        p.setStatus(1);
	        solrService.add(p);
	    	productService.upordown(p);
	        return "redirect:admin_product_list?cid="+cid;
	    }
	    @RequestMapping("admin_product_down")
	    public String down(Integer id,Integer cid,HttpSession session) {
	        Product p = new Product();
	        p.setProductId(id);
	        p.setStatus(0);
	        solrService.remove(id+"");
	    	productService.upordown(p);
	        return "redirect:admin_product_list?cid="+cid;
	    }
	    @RequestMapping("admin_product_list")
	    public String list(Integer cid, Model model, Page page,HttpSession session) {
	    	Category c =new Category();
	        TopCategory tc= new TopCategory();
	        List<TopCategory> tcs=topCategoryService.list();
	        List<Category> cs = new ArrayList<Category>();
	        List<Product> ps = new ArrayList<Product>();
	        PageHelper.offsetPage(page.getStart(),page.getCount());
	    	if(cid!=null&&cid!=0) {
	    		ps = productService.list(cid);
	    		 c = categoryService.get(cid);
				tc= topCategoryService.get(c.getTcid());
				 cs=categoryService.listByTcid(c.getTcid());
		  	}
	    	else {
	    		ps = productService.listAll();
	    		tc.setTopCategoryId(0);
	    		tc.setTopCategoryName("所有一级分类");
	    		c.setCategoryId(0);
	    		c.setCategoryName("所有分类");
	    		cs=null;
	    	}
	        
	        for(Product p:ps) {
	        	p.setStock(productService.getStock(p.getProductId()));
	        }
	        int total = (int) new PageInfo<>(ps).getTotal();
	        page.setTotal(total);
	        page.setParam("&cid="+c.getCategoryId());
	        String isadd = "";
	        isadd=(String) session.getAttribute("isadd");
	        if(isadd!=null&&isadd.equals("true")) {
	        	model.addAttribute("msg", "success");
	        	session.removeAttribute("isadd");
	        }
	        
	        String deleteWaring = (String) session.getAttribute("deleteWaring");
	    	 if (deleteWaring!=null&&deleteWaring.equals("true")) {
	         	model.addAttribute("deleteWaring", "删除失败，该产品下存在相关项");
	         	 session.removeAttribute("deleteWaring");
	 		}
    	    String deleteWaringByOrder = (String) session.getAttribute("deleteWaringByOrder");
	    	 if (deleteWaringByOrder!=null&&deleteWaringByOrder.equals("true")) {
	         	model.addAttribute("deleteWaringByOrder", "删除失败，该产品存在订单交易信息");
	         	 session.removeAttribute("deleteWaringByOrder");
	 		}
	        model.addAttribute("ps", ps);
	        model.addAttribute("c", c);
	        model.addAttribute("tc", tc);
	        model.addAttribute("tcs", tcs);
	        model.addAttribute("cs", cs);
	        model.addAttribute("page", page);
	 
	        return "admin/listProduct";
	    }
	    @RequestMapping("admin_product_searchList")
	    public String searchList(int cid, String name,Model model, Page page,HttpSession session) throws UnsupportedEncodingException {
	        Category c = categoryService.get(cid);
	        TopCategory tc= topCategoryService.get(c.getTcid());
	        name = URLDecoder.decode(name, "UTF-8");
	        PageHelper.offsetPage(page.getStart(),page.getCount());
	        List<Product> ps = productService.listSearch(cid,name);
	        for(Product p:ps) {
	        	p.setStock(productService.getStock(p.getProductId()));
	        }
	        int total = (int) new PageInfo<>(ps).getTotal();
	        
	        name = URLEncoder.encode(URLEncoder.encode(name, "UTF-8"),"UTF-8");
	    	 String s = "&cid="+cid+"&name="+name;
		  	 page.setParam(s);
		  	 
	        page.setTotal(total);
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
	 
	        return "admin/listProduct";
	    }
	    @RequestMapping("admin_check_Product")
		  @ResponseBody
		  public String checktp(String name,Integer pid) {
	    	if (pid==null) {
	    		if(productService.isExist(name))
	    			 return"exist";
	    		else {
	    			 return"notExist";
				}
			}
	    	else if (productService.isExistExclude(name,pid)) {
				  return"exist";
			}
			  return"notExist";
		  }
}
