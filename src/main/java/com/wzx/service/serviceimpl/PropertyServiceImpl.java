package com.wzx.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.PropertyMapper;
import com.wzx.pojo.Property;
import com.wzx.pojo.PropertyExample;
import com.wzx.service.PropertyService;

@Service
@CacheConfig(cacheNames="PropertyS")
public class PropertyServiceImpl implements PropertyService{

	 @Autowired
	  PropertyMapper propertyMapper;
	@Override
	 @CacheEvict(allEntries=true)
	public void add(Property c) {
		propertyMapper.insert(c);
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void delete(int id) {
		propertyMapper.deleteByPrimaryKey(id);
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void update(Property c) {
		propertyMapper.updateByPrimaryKeySelective(c);
	}

	@Override
//	@Cacheable(key="'PropertyS-one-'+#p0")
	public Property get(int id) {
		return propertyMapper.selectByPrimaryKey(id);
	}

	@Override
//	@Cacheable(key="'PropertyS-list-'+#p0")
	public List<Property> list(int cid) {
		PropertyExample example =new PropertyExample();
        example.createCriteria().andCidEqualTo(cid);
        example.setOrderByClause("propertyId desc");
        return propertyMapper.selectByExample(example);
        }

	@Override
//	@Cacheable(key="'PropertyS-EX-'+#p1+#p0")
	public boolean isExist(String name, int cid) {
		PropertyExample example =new PropertyExample();
        example.createCriteria().andCidEqualTo(cid).andPropertyNameEqualTo(name);
        List<Property> list = propertyMapper.selectByExample(example);
        if(list.size()==0)
		return false;
        
        return true;
	}

}
