package com.wzx.util.comparator;


import java.util.Comparator;

import com.wzx.pojo.Product;

/**
 * 
 * 产品价格比较器
 *
 */
public class ProductPriceComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		return (int) (p1.getPromotePrice()-p2.getPromotePrice());
	}

}

