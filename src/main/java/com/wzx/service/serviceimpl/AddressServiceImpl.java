package com.wzx.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.AddressMapper;
import com.wzx.pojo.Address;
import com.wzx.pojo.AddressExample;
import com.wzx.service.AddressService;

@Service
@CacheConfig(cacheNames="AddressS")
public class AddressServiceImpl implements AddressService{
	@Autowired
	AddressMapper AddressMapper;

	@Override
	@CacheEvict(allEntries=true)
	public void add(Address address) {
		AddressMapper.insert(address);
	}

	@Override
	@Cacheable(key="'AddressS-all-'+ #p0")
	public List<Address> list(int uid) {
		AddressExample example = new AddressExample();
		example.createCriteria().andUidEqualTo(uid);
		List<Address> list = AddressMapper.selectByExample(example);
		return list;
		
	}

	@Override
	@CacheEvict(allEntries=true)
	public void update(Address address) {
		AddressMapper.updateByPrimaryKeySelective(address);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void delete(int id) {
		AddressMapper.deleteByPrimaryKey(id);
	}

	@Override
	@Cacheable(key="'AddressS-one-'+ #p0")
	public Address get(int id) {
		Address address=AddressMapper.selectByPrimaryKey(id);
		return address;
	}
	
	
}
