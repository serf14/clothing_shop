package com.wzx.util.comparator;

import java.util.Comparator;

import com.wzx.pojo.Product;


/**
 * 
 * 产品综合比较器
 *
 */
public class ProductAllComparator implements Comparator<Product>{

	@Override
	public int compare(Product p1, Product p2) {
		return p2.getReviewCount()*p2.getSaleCount()-p1.getReviewCount()*p1.getSaleCount();
	}

}

