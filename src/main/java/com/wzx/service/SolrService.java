package com.wzx.service;

import java.util.List;

import com.wzx.pojo.Product;

public interface SolrService {

	public void importProduct(List<Product> p);
	public  void remove(String id);
	public  void add(Product item);
	public  List<Product> searchBykey(String keywords);
	public  List<Product> searchBykeyPage(String keywords);
}
