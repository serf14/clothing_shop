package com.wzx.service;

import java.util.LinkedHashSet;
import java.util.List;

import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.OrderItem;

public interface ColorAndSizeService {
	 	void add(ColorAndSize cs);
	    void update(ColorAndSize cs);
	    void delete(int id);
	    ColorAndSize get(int id);
	    ColorAndSize get(String color,String size,Integer pid);
	    List<ColorAndSize> listbyColor(int pid,String type);
	    List<ColorAndSize> list(int pid);
	    LinkedHashSet<String> listColor(int pid);
	    LinkedHashSet<String> listSize(int pid);
	    void updateStock(List<OrderItem> orderitems);//生成订单时更新库存
	    void updateStockOnBack(List<OrderItem> orderitems);//订单取消或退款完成时更新库存
}
