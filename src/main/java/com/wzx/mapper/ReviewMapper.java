package com.wzx.mapper;

import com.wzx.pojo.Review;
import com.wzx.pojo.ReviewExample;
import java.util.List;

public interface ReviewMapper {
    int deleteByPrimaryKey(Integer reviewId);

    int insert(Review record);

    int insertSelective(Review record);

    List<Review> selectByExample(ReviewExample example);

    Review selectByPrimaryKey(Integer reviewId);

    int updateByPrimaryKeySelective(Review record);

    int updateByPrimaryKey(Review record);
}