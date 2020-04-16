package com.wzx.pojo;

import java.io.Serializable;
import java.util.List;

public class TopCategory implements Serializable {
    private Integer topCategoryId;

    private String topCategoryName;
    private Integer type;//0:男装，1：女装，2：童装，3：男女通用
    private List<Category> categories;
    public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public Integer getTopCategoryId() {
        return topCategoryId;
    }

    public void setTopCategoryId(Integer topCategoryId) {
        this.topCategoryId = topCategoryId;
    }

    public String getTopCategoryName() {
        return topCategoryName;
    }

    public void setTopCategoryName(String topCategoryName) {
        this.topCategoryName = topCategoryName == null ? null : topCategoryName.trim();
    }

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}