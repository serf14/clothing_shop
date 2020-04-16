package com.wzx.pojo;
 
import com.wzx.service.OrderService;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
 
public class Order implements Serializable{
    private Integer orderId;
 
	private String orderCode;
 
    private String address;
 
    private String post;
 
    private String receiver;
 
    private String mobile;
 
    private String userMessage;
 
    private Date createDate;
 
    private Date payDate;
 
    private Date deliveryDate;
 
    private Date confirmDate;
 
    private Integer uid;
 
    private String status;
    
    private Float orderPrice;
 
    /*如下是非数据库字段*/
    private List<OrderItem> orderItems =new ArrayList<OrderItem>();
 
    private User user;
 
//    private float total;
 
    private int totalNumber;
 
    private String statusDesc;
 
    public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getOrderCode() {
        return orderCode;
    }
 
    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode == null ? null : orderCode.trim();
    }
 
    public String getAddress() {
        return address;
    }
 
    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }
 
    public String getPost() {
        return post;
    }
 
    public void setPost(String post) {
        this.post = post == null ? null : post.trim();
    }
 
    public String getReceiver() {
        return receiver;
    }
 
    public void setReceiver(String receiver) {
        this.receiver = receiver == null ? null : receiver.trim();
    }
 
    public String getMobile() {
        return mobile;
    }
 
    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }
 
    public String getUserMessage() {
        return userMessage;
    }
 
    public void setUserMessage(String userMessage) {
        this.userMessage = userMessage == null ? null : userMessage.trim();
    }
 
    public Date getCreateDate() {
        return createDate;
    }
 
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
 
    public Date getPayDate() {
        return payDate;
    }
 
    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }
 
    public Date getDeliveryDate() {
        return deliveryDate;
    }
 
    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }
 
    public Date getConfirmDate() {
        return confirmDate;
    }
 
    public void setConfirmDate(Date confirmDate) {
        this.confirmDate = confirmDate;
    }
 
    public Integer getUid() {
        return uid;
    }
 
    public void setUid(Integer uid) {
        this.uid = uid;
    }
 
    public String getStatus() {
        return status;
    }
 
    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }
 
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
 
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
     
//    public static void main(String args[]){
//        Order o  = new Order();
//        o.setStatus(OrderService.delete);
//        System.out.println(o.getStatusDesc());
//    }
    public String getStatusDesc(){
        String desc ="未知";
        switch(status){
            case OrderService.waitPay:
                desc="待付款";
                break;
            case OrderService.cancelOrder:
                desc="订单已取消";
                break;
            case OrderService.waitRefund:
                desc="等待退款中";
                break;
            case OrderService.completeRefund:
                desc="退款完成";
                break;
            case OrderService.waitDelivery:
                desc="待发货";
                break;
            case OrderService.waitConfirm:
                desc="待收货";
                break;
            case OrderService.waitReview:
                desc="待评价";
                break;
            case OrderService.finish:
                desc="交易完成";
                break;
            case OrderService.deleteCancel:
                desc="订单取消并被刪除";
                break;
            case OrderService.deleteFinish:
                desc="订单完成并被刪除";
                break;
            default:
                desc="未知";
        }
        return desc;
    }
 
 
    public int getTotalNumber() {
        return totalNumber;
    }
 
    public void setTotalNumber(int totalNumber) {
        this.totalNumber = totalNumber;
    }
 
    public User getUser() {
        return user;
    }
 
    public void setUser(User user) {
        this.user = user;
    }

	public Float getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(Float orderPrice) {
		this.orderPrice = orderPrice;
	}
}