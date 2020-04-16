package com.wzx.service.serviceimpl;
  
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.wzx.mapper.ReviewMapper;
import com.wzx.pojo.OrderItem;
import com.wzx.pojo.Review;
import com.wzx.pojo.ReviewExample;
import com.wzx.pojo.User;
import com.wzx.service.ColorAndSizeService;
import com.wzx.service.ReviewService;
import com.wzx.service.UserService;
  
@Service
@CacheConfig(cacheNames="ReviewS")
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    ReviewMapper reviewMapper;
    @Autowired
    UserService userService;
    @Autowired
    ColorAndSizeService ColorAndSizeService;
    @Override
    @CacheEvict(allEntries=true)
    public void add(Review c) {
        reviewMapper.insert(c);
    }
  
    @Override
    @CacheEvict(allEntries=true)
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }
  
    @Override
    @CacheEvict(allEntries=true)
    public void update(Review c) {
        reviewMapper.updateByPrimaryKeySelective(c);
    }
  
    @Override
    @Cacheable(key="'ReviewS-one-'+#p0")
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }
    @Cacheable(key="'ReviewS-list-'+#p0")
    public List<Review> list(int pid){
        ReviewExample example =new ReviewExample();
        example.createCriteria().andPidEqualTo(pid);
        example.setOrderByClause("reviewId desc");
  
        List<Review> result =reviewMapper.selectByExample(example);
        setUser(result);
        return result;
    }
  
    public void setUser(List<Review> reviews){
        for (Review review : reviews) {
            setUser(review);
        }
    }
  
    private void setUser(Review review) {
        int uid = review.getUid();
        User user =userService.get(uid);
        review.setUser(user);
    }
  
    @Override
    public int getCount(int pid) {
        return list(pid).size();
    }

	@Override
	public int getCountByOid(int oid) {
		return listByOid(oid).size();
	}

	@Override
	@Cacheable(key="'ReviewS-isRE-'+#p0.orderItemId")
	public boolean isReview(OrderItem oi) {
		 ReviewExample example =new ReviewExample();
	     example.createCriteria().andUidEqualTo(oi.getUid()).andOidEqualTo(oi.getOid()).
	     andPidEqualTo(oi.getPid()).andCsidEqualTo(oi.getCsid());
	     List<Review> result =reviewMapper.selectByExample(example);
	     if (!result.isEmpty()) {
			return true;
		}
		return false;
	}

	@Override
	@Cacheable(key="'ReviewS-listO-'+#p0")
	public List<Review> listByOid(int oid) {
		ReviewExample example =new ReviewExample();
        example.createCriteria().andOidEqualTo(oid);
        List<Review> result =reviewMapper.selectByExample(example);
        return result;
	}

	@Override
	public void setColorAndSize(Review r) {
		r.setColorAndSize(ColorAndSizeService.get(r.getCsid()));
	}
	@Override
	public void setColorAndSize(List<Review>  rs) {
		for (Review r:rs) {
			setColorAndSize(r);
		}
	}
}