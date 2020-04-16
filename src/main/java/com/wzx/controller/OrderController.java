package com.wzx.controller;
 
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzx.pojo.Order;
import com.wzx.pojo.OrderItem;
import com.wzx.service.ColorAndSizeService;
import com.wzx.service.OrderItemService;
import com.wzx.service.OrderService;
import com.wzx.service.UserService;
import com.wzx.util.Page;
import com.wzx.util.TimeUtil;
 
@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ColorAndSizeService colorAndSizeService;
    @Autowired
    UserService userService;
    @RequestMapping("admin_order_list")
    public String list(Model model, Page page,String status,String startTime,String endTime,String timeNum) throws ParseException{
    	List<Order> os;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Date startDate =null;
    	Date endDate= null;
//    	System.err.println(startTime);
    	if(timeNum==null) {
    		timeNum="0";
    	}
    	if(status==null) {
    		status="all";
    	}
    	if(!timeNum.equals("0")) {
    		 startDate = sdf.parse(startTime);
        	 endDate = sdf.parse(endTime);
    	}
    	
        PageHelper.offsetPage(page.getStart(),page.getCount());
        //选择状态没选时间
        if (!"all".equals(status)&&"0".equals(timeNum)) {
        	os= orderService.listByStatus(status);
        	System.err.println("选择状态没选时间");
		}//选择时间没选状态
        else if("all".equals(status)&&!"0".equals(timeNum)){
        	os= orderService.listByTime(startDate, endDate);
        	System.err.println("选择时间没选状态");
        }//都选了
        else if(!"all".equals(status)&&!"0".equals(timeNum)){
        	os= orderService.listByTimeAndStatus(startDate, endDate,status);
        	System.err.println("都选了");
        }
        else
        os= orderService.list();
 
        
        if(timeNum=="0") {
        	startTime="";
        	endTime="";
        }
        int total = (int) new PageInfo<>(os).getTotal();
        page.setTotal(total);
        String paString ="&status="+status+"&startTime="+startTime+"&endTime="+endTime+"&timeNum="+timeNum;
        page.setParam(paString);
        orderItemService.fill(os);
 
        model.addAttribute("os", os);
        model.addAttribute("page", page);
        model.addAttribute("status", status);
        model.addAttribute("timeNum", timeNum);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        return "admin/listOrder";
    }
 
    @RequestMapping("admin_order_delivery")
    public String delivery(Order o,int start ) throws IOException {
        o.setDeliveryDate(new Date());
        o.setStatus(OrderService.waitConfirm);
        orderService.update(o);
        return "redirect:admin_order_list?start="+start;
    }
    @RequestMapping("admin_order_refund")
    public String refund(Order o,int start) {
    	o.setStatus(OrderService.completeRefund);
        orderService.update(o);
        List<OrderItem> ois = orderItemService.listByOid(o.getOrderId());
        //更新库存
        colorAndSizeService.updateStockOnBack(ois);
        return "redirect:admin_order_list?start="+start;
    }
    @RequestMapping("admin_shop_detail")
    public String detail(Model model) {
    	List<Order> os= orderService.listByStatus(OrderService.waitDelivery);
    	//待处理订单
    	int waitNum = os.size();
    	//今日订单数
    	int orderNum = orderService.getTodayOrderNum();
    	
    	//获取今日订单销售额
    	os = orderService.listByTime(TimeUtil.getStartTime(), TimeUtil.getEndTime());
    	orderItemService.fill(os);
    	double todayPay=orderService.getAllOrderPay(os);
    	
    	//今日注册数
    	int TodayUserNum = userService.listByTime(TimeUtil.getStartTime(), TimeUtil.getEndTime()).size();
    	
    	List<Double> weekEachPay = new ArrayList<Double>();//过去7天每天销售额
    	double weekPay = todayPay;//第一周总销售额
    	weekEachPay.add(todayPay);
//    	最近七天销售额
    	for(int i=0;i<6;i++) {
//    		过去一天
    		os = orderService.listByTime(TimeUtil.getPastDate(i+1), TimeUtil.getPastDate(i));
        	double eachPay = orderService.getAllOrderPay(os);
        	weekEachPay.add(eachPay);
        	weekPay+=eachPay;
    	}
    	
    	
    	List<Double> fourweekPay = new ArrayList<Double>();//过去4周每周销售额
    	fourweekPay.add(weekPay);
    	double anweekPay = 0;//一周总销售额
//    	最近4周
    		anweekPay = 0;
    		for(int i=6;i<27;) {
//        		过去一周
        		os = orderService.getPriceByTime(TimeUtil.getPastDate(i+7), TimeUtil.getPastDate(i));
            	double eachPay = orderService.getAllOrderPay(os);
            	anweekPay+=eachPay;
            	fourweekPay.add(anweekPay);
            	anweekPay=0;
            	i+=7;
        	}
    		
    	
    	List<Double> lastmonthPay = new ArrayList<Double>();//过去一个月上中下旬销售额
    	double tenPay = 0;//一旬总销售额
    		for(int i=0;i<3;i++) {
//        		过去一天
    			if(i<2)
        		os = orderService.getPriceByTime(TimeUtil.getPastDatebyMonth((i+1)*10), TimeUtil.getPastDatebyMonth(i*10));
    			else {
    				os = orderService.getPriceByTime(TimeUtil.getPastDatebyMonth(TimeUtil.getCurrentMonthLastDay()+1), TimeUtil.getPastDatebyMonth(i*10));
				}
    			double eachPay = orderService.getAllOrderPay(os);
    			lastmonthPay.add(eachPay);
    			eachPay=0;
            	
        	}
    	model.addAttribute("waitNum", waitNum);
    	model.addAttribute("orderNum", orderNum);
    	model.addAttribute("todayPay", todayPay);
    	model.addAttribute("TodayUserNum", TodayUserNum);
    	model.addAttribute("weekPay", weekPay);
    	model.addAttribute("weekEachPay", weekEachPay);
    	model.addAttribute("fourweekPay", fourweekPay);
    	model.addAttribute("lastmonthPay", lastmonthPay);
        return "admin/shopDetail";
    }
    
    @RequestMapping(value = "admin_list_chart", produces = "application/json;charset=utf-8")
	  @ResponseBody
	  public List<HashMap<String, String>> listByTcid(Integer tcid) {
    	List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
    	List<Order> os = orderService.listByTime(TimeUtil.getStartTime(), TimeUtil.getEndTime());
    	orderItemService.fill(os);
    	double todayPay=orderService.getAllOrderPay(os);
    	List<String> weekEachPay = new ArrayList<String>();//过去7天每天销售额
    	weekEachPay.add(""+todayPay);
//    	最近七天销售额
    	for(int i=0;i<6;i++) {
//    		过去一天
    		os = orderService.listByTime(TimeUtil.getPastDate(i+1), TimeUtil.getPastDate(i));
        	orderItemService.fill(os);
        	double eachPay = orderService.getAllOrderPay(os);
        	
        	HashMap<String,String> payHashMap =new HashMap<String, String>();
        	payHashMap.put("pay",""+eachPay);
        	payHashMap.put("day","200"+i);
        	dataList.add(payHashMap);
    	}
		  return dataList;
	  }
}