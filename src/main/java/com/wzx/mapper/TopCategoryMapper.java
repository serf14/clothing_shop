package com.wzx.mapper;

import com.wzx.pojo.TopCategory;
import com.wzx.pojo.TopCategoryExample;
import java.util.List;

public interface TopCategoryMapper {
    int deleteByPrimaryKey(Integer topCategoryId);

    int insert(TopCategory record);

    int insertSelective(TopCategory record);

    List<TopCategory> selectByExample(TopCategoryExample example);

    TopCategory selectByPrimaryKey(Integer topCategoryId);

    int updateByPrimaryKeySelective(TopCategory record);

    int updateByPrimaryKey(TopCategory record);
}