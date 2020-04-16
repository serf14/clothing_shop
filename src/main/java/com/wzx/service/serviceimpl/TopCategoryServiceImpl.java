package com.wzx.service.serviceimpl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.CategoryMapper;
import com.wzx.mapper.TopCategoryMapper;
import com.wzx.pojo.Category;
import com.wzx.pojo.CategoryExample;
import com.wzx.pojo.TopCategory;
import com.wzx.pojo.TopCategoryExample;
import com.wzx.service.TopCategoryService;
import com.wzx.util.SpringContextUtil;

@Service
@CacheConfig(cacheNames="TopCategoryS")
public class TopCategoryServiceImpl implements TopCategoryService{

	@Autowired
	TopCategoryMapper topCategoryMapper;
	@Autowired
	CategoryMapper categoryMapper;
	@Override
//	@Cacheable(key="'TopCategoryS-all-'")后台使用
	public List<TopCategory> list() {
		TopCategoryExample example = new TopCategoryExample();
		List<TopCategory> list = topCategoryMapper.selectByExample(example);
		return list;
	}
	
	public List<Integer>  getTypeList(int type) {
		List<Integer> list = new ArrayList<Integer>();
//		男装
		if (type==0) {
			list.add(0);
			list.add(3);
			list.add(4);
			list.add(6);
		}
//		女装
		if (type==1) {
			list.add(1);
			list.add(3);
			list.add(5);
			list.add(6);
		}
//		童装
		if (type==2) {
			list.add(2);
			list.add(4);
			list.add(5);
			list.add(6);
		}
		return list;
	}
	@Override
	@Cacheable(key="'TopCategoryS-listT-'+#p0")//前台使用
	public List<TopCategory> listByType(int type) {
		List<Integer> list = getTypeList(type);
		TopCategoryExample example = new TopCategoryExample();
		example.createCriteria().andTypeIn(list);
		List<TopCategory> listtc = topCategoryMapper.selectByExample(example);
		return listtc;
	}

	@Override
	public int total() {
		return 0;
	}

	@Override
	@CacheEvict(allEntries=true)
	public void add(TopCategory topCategory) {
		topCategoryMapper.insert(topCategory);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void delete(Integer id) {
		topCategoryMapper.deleteByPrimaryKey(id);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void update(TopCategory topCategory) {
		topCategoryMapper.updateByPrimaryKeySelective(topCategory);
	}

	@Override
//	@Cacheable(key="'TopCategoryS-one-'+#p0")
	public TopCategory get(Integer topCategoryId) {
		return topCategoryMapper.selectByPrimaryKey(topCategoryId);
	}

	@Override
//	@Cacheable(key="'TopCategoryS-EX-'+#p0")
	public boolean isExist(String name) {
		TopCategoryExample example = new TopCategoryExample();
		example.createCriteria().andTopCategoryNameEqualTo(name);
		List<TopCategory> list = topCategoryMapper.selectByExample(example);
		if (list.size()!=0) {
			return true;
		}
		return false;
	}

	@Override
	 @Cacheable(key="'TopCategoryS-tcandc-'+#p0")
	public List<LinkedHashMap<String,String>> listTcAndC(int type) {
		List<LinkedHashMap<String,String>> list =new ArrayList<>();
		LinkedHashMap<String,String> oneList =null;
		TopCategoryService topCategoryService = SpringContextUtil.getBean(TopCategoryService.class);
		List<TopCategory> tcList = topCategoryService.listByType(type);
		List<Integer> typeList =  getTypeList(type);
		for(TopCategory tc:tcList) {
				oneList = new LinkedHashMap<String,String>();
				oneList.put(tc.getTopCategoryId().toString(),tc.getTopCategoryName());
				CategoryExample example = new CategoryExample();
				example.createCriteria().andTcidEqualTo(tc.getTopCategoryId()).andTypeIn(typeList);
				List<Category> cs = categoryMapper.selectByExample(example);
				for(Category c:cs) {
					oneList.put(c.getCategoryId().toString(),c.getCategoryName());
				}
				list.add(oneList);
		}
	
		return list;
	}
}
