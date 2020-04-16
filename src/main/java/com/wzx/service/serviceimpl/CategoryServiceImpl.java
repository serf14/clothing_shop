package com.wzx.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.CategoryMapper;
import com.wzx.pojo.Category;
import com.wzx.pojo.CategoryExample;
import com.wzx.service.CategoryService;

@Service
@CacheConfig(cacheNames="CategoryS")
public class CategoryServiceImpl implements CategoryService{

	@Autowired
	CategoryMapper categoryMapper;
	@Override
//	@Cacheable(key="'CategoryS-all'")
	public List<Category> list() {
		CategoryExample example = new CategoryExample();
		example.setOrderByClause("showLevel desc");
		return categoryMapper.selectByExample(example);
	}
	@Override
	@Cacheable(key="'CategoryS-show'")
	public List<Category> listbyshow() {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andIsShowHomeEqualTo(1);
		example.setOrderByClause("showLevel desc");
		System.err.println("查询显示主页的分类");
		List<Category> list =categoryMapper.selectByExample(example);
		return list;
	}
	
	@Override
	public int total() {
		return categoryMapper.total();
	}

	@Override
	@CacheEvict(allEntries=true)
	public void add(Category category) {
		categoryMapper.insert(category);
		
	}

	@Override
	@CacheEvict(allEntries=true)
	public void delete(Integer id) {
		categoryMapper.deleteByPrimaryKey(id);
	}

	@Override
	@Cacheable(key="'CategoryS-one-'+ #p0")
	public Category get(Integer categoryId) {
		return categoryMapper.selectByPrimaryKey(categoryId);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void update(Category category) {
		categoryMapper.updateByPrimaryKeySelective(category);
		
	}

	@Override
//	@Cacheable(key="'CategoryS-TC'+ #p0")
	public List<Category> listByTcid(int tcid) {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andTcidEqualTo(tcid);
		example.setOrderByClause("showLevel desc");
		return categoryMapper.selectByExample(example);
	}

	@Override
	@Cacheable(key="'CategoryS-EX'+ #p0")
	public boolean isExist(String name,int id) {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andCategoryNameEqualTo(name);
		List<Category> list = categoryMapper.selectByExample(example);
		if(list.size()==0||list.get(0).getCategoryId()==id)
			return false;
		
		return true;
	}

	@Override
//	@Cacheable(key="'CategoryS-TCN'+ #p0")
	public List<Category> listByTcidAndName(int tcid, String name) {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andTcidEqualTo(tcid).andCategoryNameLike("%"+name+"%");
		return categoryMapper.selectByExample(example);
		
	}




		
	
}
