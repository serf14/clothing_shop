package com.wzx.pojo;

import java.io.Serializable;

public class Address implements Serializable{
    private Integer id;

    private String name;

    private Integer uid;

    private String phone;

    private Integer postCode;

    private String simpleArea;

    private String detailedArea;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Integer getPostCode() {
        return postCode;
    }

    public void setPostCode(Integer postCode) {
        this.postCode = postCode;
    }

    public String getSimpleArea() {
        return simpleArea;
    }

    public void setSimpleArea(String simpleArea) {
        this.simpleArea = simpleArea == null ? null : simpleArea.trim();
    }

    public String getDetailedArea() {
        return detailedArea;
    }

    public void setDetailedArea(String detailedArea) {
        this.detailedArea = detailedArea == null ? null : detailedArea.trim();
    }
}