package com.wzx.util.comparator;


import java.util.Comparator;

import com.wzx.pojo.Product;
/**
 * 
 * 产品评价比较器
 *
 */
public class ProductReviewComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		return p2.getReviewCount()-p1.getReviewCount();
	}

}

