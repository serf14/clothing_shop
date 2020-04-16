package com.wzx.pojo;

import java.io.Serializable;

public class PropertyValue implements Serializable{
    private Integer propertyValueId;

    private Integer pid;

    private Integer ptid;

    private String value;
    private Property property;

    public Integer getPropertyValueId() {
        return propertyValueId;
    }

    public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public void setPropertyValueId(Integer propertyValueId) {
        this.propertyValueId = propertyValueId;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getPtid() {
        return ptid;
    }

    public void setPtid(Integer ptid) {
        this.ptid = ptid;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }
}