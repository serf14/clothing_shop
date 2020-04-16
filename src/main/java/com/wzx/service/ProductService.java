package com.wzx.service;

import java.util.List;

import com.wzx.pojo.Category;
import com.wzx.pojo.Product;

public interface ProductService {
	  void add(Product p);
	    void delete(int id);
	    void update(Product p);
	    Product get(int id);
	    List<Product> list(int cid);
	    List<Product> listAll();
	    List<Product> listallshow();
	    List<Product> listByStatus(int cid,int status);
	    List<Product> listByStatusAndType(int cid,int status,int type); 
	    void setFirstProductImage(Product p);
	    //分类产品填充方法
	    void fill(List<Category> cs);
	    void fill(Category c);
	    void fillByType(Category c,int type);
	    void fillByRow(List<Category> cs);
	    int getStock(int id);
	    void setSaleAndReviewNumber(Product p);
	    void upordown(Product p);
	    void setSaleAndReviewNumber(List<Product> ps);
	    List<Product> search(String keyword);
		boolean isExist(String name);
		boolean isExistExclude(String name,int pid);
		List<Product> listSearch(int cid, String name);
}
