package com.wzx.service;
  
import java.util.Date;
import java.util.List;
 
import com.wzx.pojo.Order;
import com.wzx.pojo.OrderItem;
 
public interface OrderService {
 
    String waitPay = "waitPay";//待付款
    String cancelOrder = "cancelOrder";//取消订单
    String waitDelivery = "waitDelivery";//待发货
    String waitConfirm = "waitConfirm";//确认收货
    String waitReview = "waitReview";//待评价
    String waitRefund = "waitRefund";//退款中
    String completeRefund = "completeRefund";//退款完成
    String finish = "finish";//交易完成
    String deleteFinish = "deleteFinish";//确认收货或交易完成后删除订单，该状态说明交易完成可以计算入销量
    String deleteCancel = "deleteCancel";//取消订单后删除订单，该状态的订单数不可以计入销量
    String deleteRefund = "deleteRefund";//退款后删除订单，该状态的订单数不可以计入销量
    void add(Order c);
    float add(Order c,List<OrderItem> ois);
    void delete(int id);
    void update(Order c);
    Order get(int id);
    List<Order> list();
    List<Order> listByStatus(String status);
    
    List<Order>  list(int uid, String[] excludedStatus);
    Boolean isDoAllReview(int oid);
    
    Order notReviewOrder(Order o);
    
    int getTodayOrderNum();
    List<Order> listByTime(Date start, Date end);
    List<Order> listByTimeAndStatus(Date start, Date end,String status);
    double getAllOrderPay(List<Order> os);
    List<Order>  getPriceByTime(Date start, Date end);
}