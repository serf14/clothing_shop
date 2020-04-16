package com.wzx.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.PropertyValueMapper;
import com.wzx.pojo.Product;
import com.wzx.pojo.Property;
import com.wzx.pojo.PropertyValue;
import com.wzx.pojo.PropertyValueExample;
import com.wzx.service.PropertyService;
import com.wzx.service.PropertyValueService;

@Service
@CacheConfig(cacheNames="PropertyValueS")
public class PropertyValueServiceImpl implements PropertyValueService {

    @Autowired
    PropertyValueMapper propertyValueMapper;


    @Autowired
    PropertyService propertyService;


    @Override
    @CacheEvict(allEntries=true)
    public void init(Product p) {

        List<Property> pts = propertyService.list(p.getCid());

        for (Property pt: pts) {
            PropertyValue pv = get(pt.getPropertyId(),p.getProductId());
            if(null==pv){
                pv = new PropertyValue();
                pv.setPid(p.getProductId());
                pv.setPtid(pt.getPropertyId());
                int i = propertyValueMapper.insert(pv);
                System.out.println(i+"-------------------------检测");
            }
        }

    }

    @Override
    @CacheEvict(allEntries=true)
    public void update(PropertyValue pv) {
        propertyValueMapper.updateByPrimaryKeySelective(pv);
    }

    @Override
    @Cacheable(key="'PropertyValueS-one-'+#p0+#p1")
    public PropertyValue get(int ptid, int pid) {
        PropertyValueExample example = new PropertyValueExample();
        example.createCriteria().andPtidEqualTo(ptid).andPidEqualTo(pid);
        List<PropertyValue> pvs= propertyValueMapper.selectByExample(example);
        if (pvs.isEmpty())
            return null;
        return pvs.get(0);
    }

    @Override
    @Cacheable(key="'PropertyValueS-list-'+#p0")
    public List<PropertyValue> list(int pid) {
        PropertyValueExample example = new PropertyValueExample();
        example.createCriteria().andPidEqualTo(pid);
        List<PropertyValue> result = propertyValueMapper.selectByExample(example);
        for (PropertyValue pv : result) {
            Property property = propertyService.get(pv.getPtid());
            pv.setProperty(property);
        }
        return result;
    }
}
