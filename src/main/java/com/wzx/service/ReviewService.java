package com.wzx.service;
  
import java.util.List;

import com.wzx.pojo.OrderItem;
import com.wzx.pojo.Review;
 
public interface ReviewService {
      
    void add(Review c);
 
    void delete(int id);
    void update(Review c);
    Review get(int id);
    List<Review> list(int pid);
    List<Review> listByOid(int oid);
    boolean isReview(OrderItem oi);
    int getCount(int pid);
    int getCountByOid(int oid);
    void setColorAndSize(Review r);
    void setColorAndSize(List<Review> rs);
}