package com.wzx.service.serviceimpl;

import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.ColorAndSizeMapper;
import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.ColorAndSizeExample;
import com.wzx.pojo.OrderItem;
import com.wzx.service.ColorAndSizeService;
import com.wzx.util.SpringContextUtil;

@Service
@CacheConfig(cacheNames="ColorAndSizeS")
public class ColorAndSizeServiceImpl implements ColorAndSizeService{
	
	@Autowired
	ColorAndSizeMapper colorAndSizeMapper;

	@Override
	@CacheEvict(allEntries=true)
	public void add(ColorAndSize cs) {

		colorAndSizeMapper.insert(cs);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void update(ColorAndSize cs) {
		colorAndSizeMapper.updateByPrimaryKeySelective(cs);
	}

//	通过颜色和尺码获取ColorAndSize
	@Override
	@Cacheable(key="'ColorAndSizeS-getone-'+#p0+#p1")
	public ColorAndSize get(String color,String size,Integer pid) {
		ColorAndSizeExample example = new ColorAndSizeExample();
        example.createCriteria().andPidEqualTo(pid).andColorValueEqualTo(color).andSizeValueEqualTo(size);
        List<ColorAndSize> cs= colorAndSizeMapper.selectByExample(example);
        if (cs.isEmpty())
            return null;
        return cs.get(0);
	}
//获取该产品下的所有颜色尺码组合
	@Override
	@Cacheable(key="'ColorAndSizeS-listcs-'+#p0")
	public List<ColorAndSize> list(int pid) {
		ColorAndSizeExample example = new ColorAndSizeExample();
		example.createCriteria().andPidEqualTo(pid);
		example.setOrderByClause("colorValue desc");
		List<ColorAndSize> cs= colorAndSizeMapper.selectByExample(example);
		 return cs;
	}

	@Override
	@CacheEvict(allEntries=true)
	public void delete(int id) {
		colorAndSizeMapper.deleteByPrimaryKey(id);
	}

	@Override
	@Cacheable(key="'ColorAndSizeS-one-'+#p0")
	public  ColorAndSize get(int id) {
		return colorAndSizeMapper.selectByPrimaryKey(id);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void updateStock(List<OrderItem> orderitems) {
		Integer num = 0;
		Integer id = 0;
		for (OrderItem oi:orderitems ) {
			 num = oi.getNumber();
			 id = oi.getCsid();
			 ColorAndSize colorAndSize = get(id);
			 colorAndSize.setStock(colorAndSize.getStock()-num);
			 update(colorAndSize);
		}
	}

	@Override
	@CacheEvict(allEntries=true)
	public void updateStockOnBack(List<OrderItem> orderitems) {
		Integer num = 0;
		Integer id = 0;
		for (OrderItem oi:orderitems ) {
			 num = oi.getNumber();
			 id = oi.getCsid();
			 ColorAndSize colorAndSize = get(id);
			 colorAndSize.setStock(colorAndSize.getStock()+num);
			 update(colorAndSize);
		}
	}
//  利用set不可重复的特性取出并保存所有种类的颜色
	@Override
	public LinkedHashSet<String> listColor(int pid) {
		ColorAndSizeService colorAndSizeService = SpringContextUtil.getBean(ColorAndSizeService.class);
		List<ColorAndSize> cs = colorAndSizeService.list(pid);
		LinkedHashSet<String> colorSet =new LinkedHashSet<String>();
        Iterator<ColorAndSize> iterator = cs.iterator();
        while(iterator.hasNext())
        {
        	colorSet.add(iterator.next().getColorValue());
        }
        if(colorSet.size()==0)
        {
        	colorSet.add("无");
        }
        return colorSet;
		}

	@Override
	public LinkedHashSet<String> listSize(int pid) {
		ColorAndSizeService colorAndSizeService = SpringContextUtil.getBean(ColorAndSizeService.class);
		List<ColorAndSize> cs = colorAndSizeService.list(pid);
		LinkedHashSet<String> sizeSet =new LinkedHashSet<String>();
        Iterator<ColorAndSize> iterator = cs.iterator();
        while(iterator.hasNext())
        {
        	sizeSet.add(iterator.next().getSizeValue());
        }
        if(sizeSet.size()==0)
        {
        	sizeSet.add("无");
        }
        return sizeSet;
		}

	@Override
	@Cacheable(key="'ColorAndSizeS-onecolor-'+#p0")
	public List<ColorAndSize> listbyColor(int pid, String type) {
		ColorAndSizeExample example = new ColorAndSizeExample();
		example.createCriteria().andPidEqualTo(pid).andColorValueEqualTo(type);
		return colorAndSizeMapper.selectByExample(example);
	}

	
}
