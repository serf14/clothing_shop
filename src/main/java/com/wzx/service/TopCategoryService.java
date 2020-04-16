package com.wzx.service;

import java.util.LinkedHashMap;
import java.util.List;

import com.wzx.pojo.TopCategory;

public interface TopCategoryService {
	List<TopCategory> list();
	List<TopCategory> listByType(int type);
    int total();
    void add(TopCategory topCategory);
    void delete(Integer id);
    TopCategory get(Integer topCategoryId);
    void update(TopCategory topCategory);
    boolean isExist(String name);
    List<LinkedHashMap<String,String>>listTcAndC(int type);
}
