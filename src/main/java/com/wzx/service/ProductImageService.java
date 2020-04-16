package com.wzx.service;

import java.util.List;

import com.wzx.pojo.ProductImage;

public interface ProductImageService {
    String type_detail = "type_detail";//详情图片
 
    void add(ProductImage pi);
    void delete(int id);
    void update(ProductImage pi);
    ProductImage get(int id);
    List<ProductImage> list(int pid, String type);
    List<ProductImage> listExclude(int pid, String type);
    List<ProductImage> deletebycolor(int pid,String color);
}
