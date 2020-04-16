package com.wzx.service;

import java.util.List;

import com.wzx.pojo.Category;

public interface CategoryService {
	
	List<Category> list();
	List<Category> listbyshow();
	List<Category> listByTcid(int tcid);
	List<Category> listByTcidAndName(int tcid,String name);
    int total();
    void add(Category category);
    void delete(Integer id);
    Category get(Integer categoryId);
    void update(Category category);
    boolean isExist(String name,int  id);
}
