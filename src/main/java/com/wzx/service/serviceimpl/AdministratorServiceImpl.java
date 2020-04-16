package com.wzx.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.wzx.mapper.AdministratorMapper;
import com.wzx.pojo.Administrator;
import com.wzx.pojo.AdministratorExample;
import com.wzx.service.AdministratorService;

@Service
@CacheConfig(cacheNames="AdministratorS")
public class AdministratorServiceImpl implements AdministratorService {

	@Autowired
	AdministratorMapper AdministratorMapper;
	
	@Override
//	@Cacheable(key="'AdministratorS-EX-'+ #p0")
	public boolean isExist(String account) {
		AdministratorExample example = new AdministratorExample();
		example.createCriteria().andAccountEqualTo(account);
		List<Administrator> result= AdministratorMapper.selectByExample(example);
		if (!result.isEmpty()) {
			return true;
		}
		return false;
	}

	@Override
//	@Cacheable(key="'AdministratorS-isRight-'+ #p0")
	public boolean isRight(String account, String password) {
		AdministratorExample example = new AdministratorExample();
		example.createCriteria().andAccountEqualTo(account).andPasswordEqualTo(password);
		List<Administrator> result= AdministratorMapper.selectByExample(example);
		if (!result.isEmpty()) {
				return true;
		}
		return false;
	}

	@Override
//	@Cacheable(key="'AdministratorS-one-'+ #p0")
	public Administrator get(String account, String password) {
		AdministratorExample example = new AdministratorExample();
		example.createCriteria().andAccountEqualTo(account).andPasswordEqualTo(password);
		List<Administrator> result= AdministratorMapper.selectByExample(example);
		return result.get(0);
	}

	@Override
//	@Cacheable(key="'AdministratorS-all'")
	public List<Administrator> list() {
		AdministratorExample example = new AdministratorExample();
		return AdministratorMapper.selectByExample(example);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void add(Administrator administrator) {
		AdministratorMapper.insertSelective(administrator);
	}

}
