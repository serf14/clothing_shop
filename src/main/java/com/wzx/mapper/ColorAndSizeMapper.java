package com.wzx.mapper;

import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.ColorAndSizeExample;
import java.util.List;

public interface ColorAndSizeMapper {
    int deleteByPrimaryKey(Integer csid);

    int insert(ColorAndSize record);

    int insertSelective(ColorAndSize record);

    List<ColorAndSize> selectByExample(ColorAndSizeExample example);

    ColorAndSize selectByPrimaryKey(Integer csid);

    int updateByPrimaryKeySelective(ColorAndSize record);

    int updateByPrimaryKey(ColorAndSize record);
}