package com.wzx.mapper;

import com.wzx.pojo.Order;
import com.wzx.pojo.OrderExample;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface OrderMapper {
    int deleteByPrimaryKey(Integer orderId);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
    
    List<Order> selectPriceByDate(@Param("startTime")Date startTime,@Param("endTime")Date endTime);
    
}