package com.wzx.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.ProductImageMapper;
import com.wzx.pojo.ProductImage;
import com.wzx.pojo.ProductImageExample;
import com.wzx.service.ProductImageService;


@Service
@CacheConfig(cacheNames="ProductImageS")
public class ProductImageServiceImpl implements ProductImageService  {

		@Autowired
	    ProductImageMapper productImageMapper;
	
	@Override
	 @CacheEvict(allEntries=true)
	public void add(ProductImage pi) {
		productImageMapper.insert(pi);
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void delete(int id) {
		 productImageMapper.deleteByPrimaryKey(id);
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void update(ProductImage pi) {
		 productImageMapper.updateByPrimaryKeySelective(pi);		
	}

	@Override
	@Cacheable(key="'ProductImageS-one-'+#p0")
	public ProductImage get(int id) {
		return productImageMapper.selectByPrimaryKey(id);
	}

	@Override
	@Cacheable(key="'ProductImageS-listpt-'+#p0+#p1")//后台使用
	public List<ProductImage> list(int pid, String type) {
		ProductImageExample example =new ProductImageExample();
        example.createCriteria()
                .andPidEqualTo(pid)
                .andTypeEqualTo(type);
        example.setOrderByClause("productImageId desc");
        return productImageMapper.selectByExample(example);
	}

	@Override
	@Cacheable(key="'ProductImageS-notT-'+#p0+#p1")//后台使用
	public List<ProductImage> listExclude(int pid, String type) {
		ProductImageExample example =new ProductImageExample();
        example.createCriteria()
                .andPidEqualTo(pid)
                .andTypeNotEqualTo(type);
        example.setOrderByClause("type desc");
        return productImageMapper.selectByExample(example);
	}

	@Override
	 @CacheEvict(allEntries=true)
	public List<ProductImage> deletebycolor(int pid, String color) {
		ProductImageExample example =new ProductImageExample();
		example.createCriteria().andPidEqualTo(pid).andTypeEqualTo(color);
		
		productImageMapper.deleteByColor(pid, color);
		return productImageMapper.selectByExample(example);
	}

	

}
