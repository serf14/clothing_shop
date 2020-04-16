package com.wzx.pojo;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable{
    private Integer userId;

    private String userName;

    private String password;
    
    private Date createDate;
    private String nickName;
    
    private String phone;
    private String anonymousName;
    private String email;
    public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }
   //获取匿名显示名称
    public String getAnonymousName(){
        if(null==userName)
            return null;
 
        if(userName.length()<=1)
            return "*";
 
        if(userName.length()==2)
            return userName.substring(0,1) +"*";
 
        char[] cs =userName.toCharArray();
        for (int i = 1; i < cs.length-1; i++) {
            cs[i]='*';
        }
        return new String(cs);
 
    }

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}