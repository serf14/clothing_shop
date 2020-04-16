package com.wzx.util.comparator;


import java.util.Comparator;

import com.wzx.pojo.Product;
/**
 * 
 * 产品销量比较器
 *
 */
public class ProductSaleCountComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		return p2.getSaleCount()-p1.getSaleCount();
	}

}

