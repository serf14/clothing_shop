package com.wzx.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.LinkedHashSet;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wzx.pojo.Category;
import com.wzx.pojo.Product;
import com.wzx.pojo.ProductImage;
import com.wzx.pojo.TopCategory;
import com.wzx.service.CategoryService;
import com.wzx.service.ColorAndSizeService;
import com.wzx.service.ProductImageService;
import com.wzx.service.ProductService;
import com.wzx.service.TopCategoryService;
import com.wzx.util.ImageUtil;
import com.wzx.util.UploadImg;

@Controller
@RequestMapping("")
public class ProductImageController {
	 	@Autowired
	    ProductService productService;
	 	@Autowired
		TopCategoryService topCategoryService;
	 	@Autowired
		CategoryService categoryService;
	    @Autowired
	    ProductImageService productImageService;
	    @Autowired
	    ColorAndSizeService colorAndSizeService;
	    @RequestMapping("admin_productImage_add")
	    public String add(ProductImage  pi, String colorValue,HttpSession session, UploadImg uploadedImageFile) {
	        productImageService.add(pi);
	        String fileName = pi.getProductImageId()+".jpg";
	        System.out.println(fileName+"------------------------------------------------");
	        String imageFolder;
	        String imageFolder_small=null;
	        String imageFolder_middle=null;
	        if(!ProductImageService.type_detail.equals(pi.getType())){
	            imageFolder= session.getServletContext().getRealPath("img/productSingle");
	            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
	            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
	        }
	        else{
	            imageFolder= session.getServletContext().getRealPath("img/productDetail");
	        }
	 
	        File f = new File(imageFolder, fileName);
	        f.getParentFile().mkdirs();
	        try {
	            uploadedImageFile.getImage().transferTo(f);
	            BufferedImage img = ImageUtil.change2jpg(f);
	            ImageIO.write(img, "jpg", f);
	 
	            if(!ProductImageService.type_detail.equals(pi.getType())) {
	                File f_small = new File(imageFolder_small, fileName);
	                File f_middle = new File(imageFolder_middle, fileName);
	 
	                ImageUtil.resizeImage(f, 56, 56, f_small);
	                ImageUtil.resizeImage(f, 217, 190, f_middle);
	            }
	 
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "redirect:admin_productImage_list?pid="+pi.getPid();
	    }
	 
	    @RequestMapping("admin_productImage_delete")
	    public String delete(int id,HttpSession session) {
	        ProductImage pi = productImageService.get(id);
	 
	        String fileName = pi.getProductImageId()+ ".jpg";
	        String imageFolder;
	        String imageFolder_small=null;
	        String imageFolder_middle=null;
	 
	        if(!ProductImageService.type_detail.equals(pi.getType())){
	            imageFolder= session.getServletContext().getRealPath("img/productSingle");
	            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
	            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
	            File imageFile = new File(imageFolder,fileName);
	            File f_small = new File(imageFolder_small,fileName);
	            File f_middle = new File(imageFolder_middle,fileName);
	            imageFile.delete();
	            f_small.delete();
	            f_middle.delete();
	 
	        }
	        else{
	            imageFolder= session.getServletContext().getRealPath("img/productDetail");
	            File imageFile = new File(imageFolder,fileName);
	            imageFile.delete();
	        }
	 
	        productImageService.delete(id);
	 
	        return "redirect:admin_productImage_list?pid="+pi.getPid();
	    }
	 
	    @RequestMapping("admin_productImage_list")
	    public String list(int pid, Model model) {
	        Product p =productService.get(pid);
	        List<ProductImage> pisSingle = productImageService.listExclude(pid, ProductImageService.type_detail);
	        List<ProductImage> pisDetail = productImageService.list(pid, ProductImageService.type_detail);
	        LinkedHashSet<String> colorSet =colorAndSizeService.listColor(pid);
	        Category c = categoryService.get(p.getCid());
	        TopCategory tc= topCategoryService.get(c.getTcid());
	        model.addAttribute("tc", tc);
	        model.addAttribute("p", p);
	        model.addAttribute("c", c);
	        model.addAttribute("colors", colorSet);
	        model.addAttribute("pisSingle", pisSingle);
	        model.addAttribute("pisDetail", pisDetail);
	        
	        return "admin/listProductImage";
	    }
	    
	    @RequestMapping("admin_list_lunbo")
	    public String listlunbo(Model model) {
	    	return "admin/listlunbo";
	    	
	    }
	    @RequestMapping("admin_edit_lunbo")
	    public String editlunbo(int id, Model model) {
	    	model.addAttribute("id",id);
	    	return "admin/editlunbo";
	    	
	    }
	    @RequestMapping("admin_update_lunbo")
	    public String editupdatelunbo(int id, HttpSession session,Model model,UploadImg uploadedImageFile) {
	    	String fileName = id+".jpg";
	    	String imageFolder= session.getServletContext().getRealPath("img/lunbo");
	    	  File f = new File(imageFolder, fileName);
//	    	  f.delete();
		        f.getParentFile().mkdirs();
		        
		        try {
		        	uploadedImageFile.getImage().transferTo(f);
		            BufferedImage img = ImageUtil.change2jpg(f);
		            ImageIO.write(img, "jpg", f);
				} catch (Exception e) {
				}
	    	return "admin/listlunbo";
	    	
	    }
	    
}
