package com.wzx.util;

import org.springframework.web.multipart.MultipartFile;
/**
*图片类,用于保存上传的图片文件
**/
public class UploadImg {
	MultipartFile image;
	  
    public MultipartFile getImage() {
        return image;
    }
  
    public void setImage(MultipartFile image) {
        this.image = image;
    }
}
