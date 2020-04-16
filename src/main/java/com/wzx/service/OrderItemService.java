package com.wzx.service;
  
import java.util.List;
 
import com.wzx.pojo.Order;
import com.wzx.pojo.OrderItem;
 
public interface OrderItemService {
      
    void add(OrderItem c);
 
    void delete(int id);
    void update(OrderItem c);
    OrderItem get(int id);
    List<OrderItem> list();
    List<OrderItem> listByOid(int oid);
    void fill(List<Order> os);
    //检测是否某产品有相关订单信息
    Boolean isExistProductInfo(int pid);
    Boolean isExistCSInfo(int csid);
    void fill(Order o);
    int getSaleCount(int  pid);
    List<OrderItem> listByUser(int uid);
}