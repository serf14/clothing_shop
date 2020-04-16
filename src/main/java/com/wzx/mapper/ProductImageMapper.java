package com.wzx.mapper;

import com.wzx.pojo.ProductImage;
import com.wzx.pojo.ProductImageExample;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ProductImageMapper {
    int deleteByPrimaryKey(Integer productImageId);

    int insert(ProductImage record);

    int insertSelective(ProductImage record);

    List<ProductImage> selectByExample(ProductImageExample example);

    ProductImage selectByPrimaryKey(Integer productImageId);

    int updateByPrimaryKeySelective(ProductImage record);

    int updateByPrimaryKey(ProductImage record);
    
    int deleteByColor(@Param("pid")int id,@Param("type")String color);
}