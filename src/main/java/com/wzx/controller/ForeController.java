package com.wzx.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.wzx.pojo.Address;
import com.wzx.pojo.Category;
import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.Order;
import com.wzx.pojo.OrderItem;
import com.wzx.pojo.Product;
import com.wzx.pojo.ProductImage;
import com.wzx.pojo.PropertyValue;
import com.wzx.pojo.Review;
import com.wzx.pojo.User;
import com.wzx.service.*;
import com.wzx.util.comparator.*;

@Controller
@RequestMapping("")
public class ForeController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;
    @Autowired
    UserService userService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    ColorAndSizeService colorAndSizeService;
    @Autowired
    TopCategoryService topCategoryService;
    @Autowired
    SolrService solrService;
    @Autowired
    AddressService addressService;
    @RequestMapping("forehome")
    public String home(Model model) {
        List<Category> cs= categoryService.listbyshow();
        productService.fill(cs);
         model.addAttribute("cs", cs);
       
        return "fore/home";
    }
    @RequestMapping("foreregister")
    @ResponseBody
    public String register(Model model,User user) {
        String name =  user.getUserName();
        name = HtmlUtils.htmlEscape(name);
        user.setUserName(name);
        boolean exist = userService.isExist(name);
         
        if(exist){
            return "failed";
        }
        user.setCreateDate(new Date());
        userService.add(user);
    
        return "success";
    }
    
    @RequestMapping("forelogin")
    @ResponseBody
    public String login(@RequestParam("userName") String name, @RequestParam("password") String password, Model model, HttpSession session) {
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name,password);
 
        if(null==user){
            return "failed";
        }
        session.setAttribute("user", user);
        return "success";
    }
    @RequestMapping("forelogout")
    public String logout( HttpSession session) {
        session.removeAttribute("user");
        return "redirect:forehome";
    }

    @RequestMapping("foreproduct")
    public String product( int pid, Model model) {
        Product p = productService.get(pid);
 
        List<ProductImage> productSingleImages = productImageService.listExclude(p.getProductId(), ProductImageService.type_detail);
        List<ProductImage> productDetailImages = productImageService.list(p.getProductId(), ProductImageService.type_detail);
        p.setProductSingleImages(productSingleImages);
        p.setProductDetailImages(productDetailImages);
        List<PropertyValue> pvs = propertyValueService.list(p.getProductId());
        List<Review> reviews = reviewService.list(p.getProductId());
        reviewService.setColorAndSize(reviews);
        LinkedHashSet<String> colorSet =colorAndSizeService.listColor(pid);
        LinkedHashSet<String> sizeSet =colorAndSizeService.listSize(pid);
       
        
        String stock=null;
        if (colorSet.iterator().hasNext()&&sizeSet.iterator().hasNext()) {
        	stock = getstock(colorSet.iterator().next(), sizeSet.iterator().next(),pid);
		}
         
        if(stock==null)
        	stock="0";
        p.setStock(Integer.valueOf(stock));
        productService.setFirstProductImage(p);
        productService.setSaleAndReviewNumber(p);
        model.addAttribute("reviews", reviews);
        model.addAttribute("p", p);
        model.addAttribute("pvs", pvs);
        model.addAttribute("colors", colorSet);
        model.addAttribute("sizes", sizeSet);
        return "fore/product";
    }
    
    @RequestMapping("forecheckLogin")
    @ResponseBody
    public String checkLogin( HttpSession session) {
        User user =(User)  session.getAttribute("user");
        if(null!=user)
            return "success";
        return "fail";
    }
 
    @RequestMapping(value = "foreloginAjax")
    @ResponseBody
    public String loginAjax(@RequestParam("userName") String name, @RequestParam("password") String password,HttpSession session) {
      
    	name = HtmlUtils.htmlEscape(name);
    	
        User user = userService.get(name,password);
        
        if(!userService.isExist(name)){
            return "nameError";
        }
        else if(user==null) {
        	return "passwordError";
        }
        session.setAttribute("user", user);
        return "success";
    }
 
    @RequestMapping("forecategory")
    public String category(int cid,String sort,Integer type, Model model) {
        Category c = categoryService.get(cid);
        if (type==null) {
        	 productService.fill(c);
		}
        else
        productService.fillByType(c,type);
        productService.setSaleAndReviewNumber(c.getProducts());
 
        if(null!=sort){
            switch(sort){
                case "review":
                    Collections.sort(c.getProducts(),new ProductReviewComparator());
                    break;
                case "date" :
                    Collections.sort(c.getProducts(),new ProductDateComparator());
                    break;
 
                case "saleCount" :
                    Collections.sort(c.getProducts(),new ProductSaleCountComparator());
                    break;
 
                case "price":
                    Collections.sort(c.getProducts(),new ProductPriceComparator());
                    break;
 
                case "all":
                    Collections.sort(c.getProducts(),new ProductAllComparator());
                    break;
            }
        }
 
        model.addAttribute("c", c);
        return "fore/category";
    }
    @RequestMapping("foresearch")
    public String search( String keyword,Model model){
 
        List<Product> ps= solrService.searchBykey(keyword);
        for(Product p:ps) {
        	 productService.setFirstProductImage(p);
        }
        productService.setSaleAndReviewNumber(ps);
        model.addAttribute("ps",ps);
        return "fore/searchResult";
    }
    
    @RequestMapping("forebuyone")
    public String buyone(int pid, int csid,int num, HttpSession session) {
        int oiid = 0;
        ColorAndSize cs = colorAndSizeService.get(csid);
        User user =(User)  session.getAttribute("user");
        boolean found = false;
        List<OrderItem> ois = orderItemService.listByUser(user.getUserId());
        if(!found){
            OrderItem oi = new OrderItem();
            oi.setUid(user.getUserId());
            oi.setNumber(num);
            oi.setPid(pid);
            oi.setCsid(cs.getCsid());
            orderItemService.add(oi);
            oiid = oi.getOrderItemId();
        }
        return "redirect:forebuy?oiid="+oiid;
    }
    @RequestMapping("forebuy")
    public String buy( Model model,String[] oiid,HttpSession session){
        List<OrderItem> ois = new ArrayList<>();
        float total = 0;
 
        for (String strid : oiid) {
            int id = Integer.parseInt(strid);
            OrderItem oi= orderItemService.get(id);
            total +=oi.getProduct().getPromotePrice()*oi.getNumber();
            ois.add(oi);
        }
 
        User sUser = (User) session.getAttribute("user");
    	if (sUser!=null) {
    		model.addAttribute("address", addressService.list(sUser.getUserId()));
		}
        
        session.setAttribute("ois", ois);
        model.addAttribute("total", total);
        return "fore/buy";
    }
    @RequestMapping("foreaddCart")
    @ResponseBody
    public String addCart(int pid,int num, int csid, Model model,HttpSession session) {
        ColorAndSize cs = colorAndSizeService.get(csid);
        User user =(User)  session.getAttribute("user");
        boolean found = false;
        List<OrderItem> ois = orderItemService.listByUser(user.getUserId());
        for (OrderItem oi : ois) {
            if(oi.getProduct().getProductId().intValue()==pid&&
            		oi.getCsid().intValue()==cs.getCsid().intValue()){
                //如果购物车中的数量超过库存,就阻止该加购操作
                if((oi.getNumber()+num)>cs.getStock())
                {
                	
                    return "failed";
                }
                oi.setNumber(oi.getNumber()+num);
                orderItemService.update(oi);
                found = true;
                break;
            }
        }
 
        if(!found){
            OrderItem oi = new OrderItem();
            oi.setUid(user.getUserId());
            oi.setNumber(num);
            oi.setPid(pid);
            oi.setCsid(cs.getCsid());
            orderItemService.add(oi);
        }
        return "success";
    }
    @RequestMapping("forecart")
    public String cart( Model model,HttpSession session) {
        User user =(User)  session.getAttribute("user");
        List<OrderItem> ois = orderItemService.listByUser(user.getUserId());
        model.addAttribute("ois", ois);
        return "fore/cart";
    }
    @RequestMapping("forechangeOrderItem")
    @ResponseBody
    public String changeOrderItem( Model model,HttpSession session, int oiid, int number) {
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";
        OrderItem oi=orderItemService.get(oiid);
        
        oi.setNumber(number);
        orderItemService.update(oi);
          
 
        return "success";
    }
 
    @RequestMapping("foredeleteOrderItem")
    @ResponseBody
    public String deleteOrderItem( Model model,HttpSession session,int oiid){
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";
        orderItemService.delete(oiid);
        return "success";
    }
    @RequestMapping("forecreateOrder")
    public String createOrder( Model model,Order order,HttpSession session){
        User user =(User)  session.getAttribute("user");
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setUid(user.getUserId());
        order.setStatus(OrderService.waitPay);
        List<OrderItem> ois= (List<OrderItem>)session.getAttribute("ois");
//        更新库存
        colorAndSizeService.updateStock(ois);
        orderService.add(order,ois);
        return "redirect:forealipay?oid="+order.getOrderId() +"&total="+order.getOrderPrice();
    }
    @RequestMapping("forepayed")
    public String payed(int oid, float total, Model model) {
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        model.addAttribute("o", order);
        return "fore/payed";
    }
    @RequestMapping("forebought")
    public String bought( Model model,HttpSession session) {
        User user =(User)  session.getAttribute("user");
        List<Order> os= orderService.list(user.getUserId(),new String[]{OrderService.deleteFinish,OrderService.deleteRefund,OrderService.deleteCancel});
 
        orderItemService.fill(os);
 
        model.addAttribute("os", os);
        return "fore/bought";
    }
    
    
    @RequestMapping("foreListOrderDetail")
    public String listOrderDetail( Model model,HttpSession session,int oid) {
        Order o= orderService.get(oid);
        orderItemService.fill(o);
 
        model.addAttribute("o", o);
        return "fore/listOrderDetail";
    }
    
    
    @RequestMapping("foreEditOrderAddress")
    public String editOrderAddress( Model model,HttpSession session,int oid) {
        Order o= orderService.get(oid);
        orderItemService.fill(o);
 
        model.addAttribute("o", o);
        return "fore/editOrderAddress";
    }
    
    @RequestMapping("foreUpdateOrderAddress")
    @ResponseBody
    public String updateOrderAddress(Model model,Order o) {
    	orderService.update(o);
    	return "success";
    }
    @RequestMapping("foreconfirmPay")
    public String confirmPay( Model model,int oid) {
        Order o = orderService.get(oid);
        orderItemService.fill(o);
        model.addAttribute("o", o);
        return "fore/confirmPay";
    }
    @RequestMapping("foreorderConfirmed")
    public String orderConfirmed( Model model,int oid) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.waitReview);
        o.setConfirmDate(new Date());
        orderService.update(o);
        return "fore/orderConfirmed";
    }
    //退款
    @RequestMapping("foreRefund")
    @ResponseBody
    public String orderRefund(Model model,int oid) {
    	Order o = orderService.get(oid);
        o.setStatus(OrderService.waitRefund);
        orderService.update(o);
        return "success";
    }
  
    //取消订单
    @RequestMapping("foreCancel")
    @ResponseBody
    public String cancelOrder(Model model,int oid) {
    	Order o = orderService.get(oid);
        o.setStatus(OrderService.cancelOrder);
        orderService.update(o);
        List<OrderItem> ois = orderItemService.listByOid(oid);
        //更新库存
        colorAndSizeService.updateStockOnBack(ois);
        return "success";
    }
    
    @RequestMapping("foredeleteOrder")
    @ResponseBody
    public String deleteOrder( Model model,int oid){
        Order o = orderService.get(oid);
        String status = o.getStatus();
        if(status.equals(OrderService.finish))
        o.setStatus(OrderService.deleteFinish);
        else if(status.equals(OrderService.cancelOrder))
        	o.setStatus(OrderService.deleteCancel);
        else if(status.equals(OrderService.completeRefund))
        	o.setStatus(OrderService.deleteRefund);
        else {
			return "failed";
		}
        orderService.update(o);
        return "success";
    }
    @RequestMapping("forereview")
    public String review( Model model,int oid) {
        Order o = orderService.get(oid);
        orderItemService.fill(o);
//        Product p = o.getOrderItems().get(0).getProduct();
//        List<Review> reviews = reviewService.list(p.getProductId());
//        productService.setSaleAndReviewNumber(p);
//        model.addAttribute("p", p);
        o = orderService.notReviewOrder(o);
        model.addAttribute("o", o);
//        model.addAttribute("reviews", reviews);
        if (orderService.isDoAllReview(oid)) {
        	o.setStatus(OrderService.finish);
        	orderService.update(o);
        	model.addAttribute("finish", "99");
		}
        return "fore/review";
    }
    @Transactional(propagation= Propagation.REQUIRED, rollbackForClassName = {"Exception"})
    @RequestMapping("foredoreview")
    public String doreview( Model model,HttpSession session,Integer oid,Integer pid,Integer csid,String content) {
        
    	Order o = orderService.get(oid);
        
        content = HtmlUtils.htmlEscape(content);
        User user =(User)  session.getAttribute("user");
        Review review = new Review();
        if(content!=null&&!content.equals(""));
        content="该用户未作出任何评价";
        review.setContent(content);
        review.setPid(pid);
        review.setCreateDate(new Date());
        review.setUid(user.getUserId());
        review.setOid(oid);
        review.setCsid(csid);
        reviewService.add(review);
        return "redirect:forereview?oid="+oid;
    }
    @RequestMapping("getstock")
    @ResponseBody
    public String getstock(String color,String size,Integer pid){
    	if(color!=null&&size!=null) {
    		ColorAndSize cs =colorAndSizeService.get(color, size, pid);
        	return cs!=null?cs.getStock().toString():"0";
    	}
    	return "0";
    }
    @RequestMapping("getcsid")
    @ResponseBody
    public String getcsid(String color,String size,Integer pid){
    	if(color!=null&&size!=null) {
    		ColorAndSize cs =colorAndSizeService.get(color, size,pid);
        	return cs!=null?cs.getCsid().toString():"该产品款式无库存";
    	}
    	return "该产品款式无库存";
    }
    @RequestMapping("foreUserInfo")
    public String userInfo(Model model){
    	return "fore/userInfo";
    }
    
    @RequestMapping("foreEditPassword")
    public String editPassword(Model model){
    	return "fore/editPassword";
    }
    @RequestMapping("foreUpdatePassword")
    @ResponseBody
    public String updatePassword(String password,String oldPassword,Model model,HttpSession session){
    	User user = (User) session.getAttribute("user");
    	
    	if(userService.get(user.getUserName(), oldPassword)!=null) {
    		user.setPassword(password);
    		userService.update(user);
    		return "success";
    	}
    	return "false";
    }
    
    @RequestMapping("foreEditInfo")
    public String EditInfo(Model model,HttpSession session){
    	 User user = (User) session.getAttribute("user");
    	 if(user!=null)
    		 model.addAttribute("u",  userService.get(user.getUserId()));
        
    	return "fore/editInfo";
    }
    @RequestMapping("foreUpdateUserInfo")
    @ResponseBody
    public String updateUserInfo(User u,HttpSession session){
    	User user = (User) session.getAttribute("user");
    	if(user==null)
    		return "false";
    	u.setUserId(user.getUserId());
    	userService.update(u);
    	return "success";
    }
    
    
    @RequestMapping("foreEditAddress")
    public String editAddress(Model model,HttpSession session){
    	User sUser = (User) session.getAttribute("user");
    	if (sUser!=null) {
    		model.addAttribute("address", addressService.list(sUser.getUserId()));
		}
    	return "fore/editAddress";
    }
    @RequestMapping("foreNewAddress")
    public String NewAddress(Model model){
    	return "fore/addAddress";
    }
    @RequestMapping("foreCreateAddress")
    @ResponseBody
    public String createAddress(HttpSession session,Address address){
    	User user = (User)session.getAttribute("user");
    	address.setUid(user.getUserId());
    	addressService.add(address);
    	return "success";
    }
    @RequestMapping("foreDeleteAddress")
    @ResponseBody
    public String deleteAddress(HttpSession session,int id){
    	addressService.delete(id);
    	return "success";
    }
    @RequestMapping("foreUpdateAddress")
    public String updateAddress(Model model,int id){
    	Address address = addressService.get(id);
    	
    	 model.addAttribute("ad", address);
    	return "fore/updateAddress";
    }
    
    
    @RequestMapping("foreUpdateOneAddress")
    @ResponseBody
    public String UpdateOneAddress(HttpSession session,Address address){
    	addressService.update(address);
    	return "success";
    }
    
    @RequestMapping("ForgetPassword")
    public String forgetPassword(Model model){
        return "fore/forgetPassword";
    }
    
    @RequestMapping(value = "GetTopAndCate", produces = "application/json;charset=utf-8")
	  @ResponseBody
    public List<LinkedHashMap<String, String>> foreGetTop(Model model,int id,HttpSession session){
    	System.err.println(id+"---------------------------");
    	if(id==0&&session.getAttribute("tcandcs0")==null)
    	{
    		List<LinkedHashMap<String, String>> tcandcs0=topCategoryService.listTcAndC(0);
       		 session.setAttribute("tcandcs0", tcandcs0);
       		return  tcandcs0;
    	}
       	if (id==1&&session.getAttribute("tcandcs1")==null) {
       		List<LinkedHashMap<String, String>> tcandcs1=topCategoryService.listTcAndC(1);
      		 session.setAttribute("tcandcs1", tcandcs1);
      		return  tcandcs1;
   		}
       	
       	if (id==2&&session.getAttribute("tcandcs2")==null) {
       		List<LinkedHashMap<String, String>> tcandcs2=topCategoryService.listTcAndC(2);
      		 session.setAttribute("tcandcs2", tcandcs2);
      		return  tcandcs2;
   		}
       	
    	
        return null;
    }
}


 
