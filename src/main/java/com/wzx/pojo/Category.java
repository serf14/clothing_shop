package com.wzx.pojo;

import java.io.Serializable;
import java.util.List;

public class Category implements Serializable{
    
	private Integer categoryId;
    private Integer tcid;
    private Integer type;//0:男装，1：女装，2：童装，3：男装女装，4：男装童装，5：女装童装，6：男装女装童装
    private String categoryName;
    private Integer isShowHome;//0:不显示，1：显示在首页

    private Integer showLevel;//显示等级
    


	//用于产品推荐字段
    private List<Product> products;
    
    public Integer getIsShowHome() {
		return isShowHome;
	}

	public void setIsShowHome(Integer isShowHome) {
		this.isShowHome = isShowHome;
	}

	public Integer getShowLevel() {
		return showLevel;
	}

	public void setShowLevel(Integer showLevel) {
		this.showLevel = showLevel;
	}
    
    public Integer getTcid() {
		return tcid;
	}

	public void setTcid(Integer tcid) {
		this.tcid = tcid;
	}

    public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<List<Product>> getProductsByRow() {
		return productsByRow;
	}

	public void setProductsByRow(List<List<Product>> productsByRow) {
		this.productsByRow = productsByRow;
	}

	private List<List<Product>> productsByRow;

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName == null ? null : categoryName.trim();
    }

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}