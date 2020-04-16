package com.wzx.util.comparator;



import java.util.Comparator;

import com.wzx.pojo.Product;

/**
 * 
 * 产品创建时间比较器
 *
 */
public class ProductDateComparator implements Comparator<Product>{

	@Override
	public int compare(Product p1, Product p2) {
		return p1.getCreateDate().compareTo(p2.getCreateDate());
	}

}
