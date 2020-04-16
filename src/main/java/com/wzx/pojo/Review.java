package com.wzx.pojo;

import java.io.Serializable;
import java.util.Date;

public class Review implements Serializable{
    private Integer reviewId;

    private String content;

    private Integer uid;
    private Integer csid;
	private Integer pid;
    private Integer oid;

    private Date createDate;

    private User user;
    private ColorAndSize colorAndSize;
    public ColorAndSize getColorAndSize() {
		return colorAndSize;
	}

	public void setColorAndSize(ColorAndSize colorAndSize) {
		this.colorAndSize = colorAndSize;
	}

	public Integer getCsid() {
		return csid;
	}

	public void setCsid(Integer csid) {
		this.csid = csid;
	}

	public Integer getOid() {
		return oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}
    public Integer getReviewId() {
        return reviewId;
    }

    public void setReviewId(Integer reviewId) {
        this.reviewId = reviewId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}