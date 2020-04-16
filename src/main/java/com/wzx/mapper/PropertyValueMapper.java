package com.wzx.mapper;

import com.wzx.pojo.PropertyValue;
import com.wzx.pojo.PropertyValueExample;
import java.util.List;

public interface PropertyValueMapper {
    int deleteByPrimaryKey(Integer propertyValueId);

    int insert(PropertyValue record);

    int insertSelective(PropertyValue record);

    List<PropertyValue> selectByExample(PropertyValueExample example);

    PropertyValue selectByPrimaryKey(Integer propertyValueId);

    int updateByPrimaryKeySelective(PropertyValue record);

    int updateByPrimaryKey(PropertyValue record);
}