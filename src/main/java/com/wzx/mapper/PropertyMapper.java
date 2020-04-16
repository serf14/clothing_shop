package com.wzx.mapper;

import com.wzx.pojo.Property;
import com.wzx.pojo.PropertyExample;
import java.util.List;

public interface PropertyMapper {
    int deleteByPrimaryKey(Integer propertyId);

    int insert(Property record);

    int insertSelective(Property record);

    List<Property> selectByExample(PropertyExample example);

    Property selectByPrimaryKey(Integer propertyId);

    int updateByPrimaryKeySelective(Property record);

    int updateByPrimaryKey(Property record);
}