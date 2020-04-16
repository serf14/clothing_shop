package com.wzx.service;

import java.util.List;

import com.wzx.pojo.Product;
import com.wzx.pojo.PropertyValue;

public interface PropertyValueService {
		void init(Product p);
	    void update(PropertyValue pv);
	    PropertyValue get(int ptid, int pid);
	    List<PropertyValue> list(int pid);
}
