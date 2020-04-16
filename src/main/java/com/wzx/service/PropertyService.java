package com.wzx.service;

import java.util.List;

import com.wzx.pojo.Property;

public interface PropertyService {
	void add(Property c);
    void delete(int id);
    void update(Property c);
    Property get(int id);
    List<Property> list(int cid);
	boolean isExist(String name, int cid);
}
