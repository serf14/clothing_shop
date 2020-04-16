package com.wzx.service.serviceimpl;
 
import java.util.Date;
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
 
import com.wzx.mapper.UserMapper;
import com.wzx.pojo.User;
import com.wzx.pojo.UserExample;
import com.wzx.service.UserService;
 
@Service
@CacheConfig(cacheNames="UserS")
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
 
    @Override
    @CacheEvict(allEntries=true)
    public void add(User u) {
        userMapper.insert(u);
    }
 
    @Override
    @CacheEvict(allEntries=true)
    public void delete(int id) {
        userMapper.deleteByPrimaryKey(id);
    }
 
    @Override
    @CacheEvict(allEntries=true)
    public void update(User u) {
        userMapper.updateByPrimaryKeySelective(u);
    }
 
    @Override
    @Cacheable(key="'UserS-one-'+#p0")
    public User get(int id) {
        return userMapper.selectByPrimaryKey(id);
    }
//    @Cacheable(key="'UserS-all-'")
    public List<User> list(){
        UserExample example =new UserExample();
        example.setOrderByClause("userId desc");
        return userMapper.selectByExample(example);
 
    }
    @Override
    @Cacheable(key="'UserS-EX-'+#p0")
    public boolean isExist(String name) {
        UserExample example =new UserExample();
        example.createCriteria().andUserNameEqualTo(name);
        List<User> result= userMapper.selectByExample(example);
        if(!result.isEmpty())
            return true;
        return false;
 
    }
    @Override
    @Cacheable(key="'UserS-getone-'+#p0")
    public User get(String name, String password) {
        UserExample example =new UserExample();
        example.createCriteria().andUserNameEqualTo(name).andPasswordEqualTo(password);
        List<User> result= userMapper.selectByExample(example);
        if(result.isEmpty())
            return null;
        return result.get(0);
    }

	@Override
//	 @Cacheable(key="'UserS-listT-'+#p0")
	public List<User> listByTime(Date start,Date end) {
		  UserExample example =new UserExample();
	      example.createCriteria().andCreateDateBetween(start, end);
	      return userMapper.selectByExample(example);
	}
 
}