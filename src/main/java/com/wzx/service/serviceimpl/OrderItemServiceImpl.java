package com.wzx.service.serviceimpl;
 
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
 
import com.wzx.mapper.OrderItemMapper;
import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.Order;
import com.wzx.pojo.OrderItem;
import com.wzx.pojo.OrderItemExample;
import com.wzx.pojo.Product;
import com.wzx.service.ColorAndSizeService;
import com.wzx.service.OrderItemService;
import com.wzx.service.OrderService;
import com.wzx.service.ProductService;
import com.wzx.util.SpringContextUtil;
 
@Service
@CacheConfig(cacheNames="OrderItemS")
public class OrderItemServiceImpl implements OrderItemService {
    @Autowired
    OrderItemMapper orderItemMapper;
    @Autowired
    OrderService orderService;
    @Autowired
    ProductService productService;
    @Autowired
    ColorAndSizeService colorAndSizeService ;
    @Override
    @CacheEvict(allEntries=true)
    public void add(OrderItem c) {
        orderItemMapper.insert(c);
    }
 
    @Override
    @CacheEvict(allEntries=true)
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }
 
    @Override
    @CacheEvict(allEntries=true)
    public void update(OrderItem c) {
        orderItemMapper.updateByPrimaryKeySelective(c);
    }
 
    @Override
    @Cacheable(key="'OrderItemS-one-'+#p0")//前台使用
    public OrderItem get(int id) {
        OrderItem result = orderItemMapper.selectByPrimaryKey(id);
        setProduct(result);
        return result;
    }
    @Cacheable(key="'OrderItemS-all'")
    public List<OrderItem> list(){
        OrderItemExample example =new OrderItemExample();
        example.setOrderByClause("OrderItemId desc");
        return orderItemMapper.selectByExample(example);
 
    }
 
    @Override
    public void fill(List<Order> os) {
        for (Order o : os) {
            fill(o);
        }
    }
// 为订单填充订单项，总价和数量，为订单项填充产品和尺码
    @Cacheable(key="'OrderItemS-oneOrder-'+#p0.orderId")
    public void fill(Order o) {
    	OrderItemService  orderItemService = SpringContextUtil.getBean(OrderItemService.class);
    	List<OrderItem> ois = orderItemService.listByOid(o.getOrderId());
        setProduct(ois);
 
        int totalNumber = 0;
        for (OrderItem oi : ois) {
            totalNumber+=oi.getNumber();
        }
        o.setTotalNumber(totalNumber);
        o.setOrderItems(ois);
 
    }
 
    public void setProduct(List<OrderItem> ois){
        for (OrderItem oi: ois) {
            setProduct(oi);
        }
    }
 
    private void setProduct(OrderItem oi) {
        Product p = productService.get(oi.getPid());
        ColorAndSize cSize  = colorAndSizeService.get(oi.getCsid());
        p.setColorAndSize(cSize);
        oi.setProduct(p);
    }
 
//    获取所有该商品已完成的订单项来计算销量
    @Override
    @Cacheable(key="'OrderItemS-oneprofin-'+#p0")
    public int getSaleCount(int pid) {
        OrderItemExample example =new OrderItemExample();
//        获取所有在订单中的订单项
        example.createCriteria().andPidEqualTo(pid).andOidIsNotNull();
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
        int result =0;
        for (OrderItem oi : ois) {
//        	判断订单是否已完成
        	String status = orderService.get(oi.getOid()).getStatus();
        	if(status.equals("deleteFinish")||status.equals("finish")||status.equals("waitReview"))
            result+=oi.getNumber();
        }
        return result;
    }
    @Override
    @Cacheable(key="'OrderItemS-oneuser-'+#p0")//前台使用
    public List<OrderItem> listByUser(int uid) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andUidEqualTo(uid).andOidIsNull();
        List<OrderItem> result =orderItemMapper.selectByExample(example);
        setProduct(result);
        return result;
    }

	@Override
	@Cacheable(key="'OrderItemS-byoid-'+#p0")
	public List<OrderItem> listByOid(int oid) {
		OrderItemExample example =new OrderItemExample();
        example.createCriteria().andOidEqualTo(oid);
        List<OrderItem> result =orderItemMapper.selectByExample(example);
        setProduct(result);
        return result;
	}

	@Override
	@Cacheable(key="'OrderItemS-EXpro-'+#p0")
	public Boolean isExistProductInfo(int pid) {
		 OrderItemExample example =new OrderItemExample(); 
		example.createCriteria().andPidEqualTo(pid).andOidIsNotNull();
	        List<OrderItem> ois =orderItemMapper.selectByExample(example);
	        if (ois.size()>0) {
	        	return true;
			}
		return false;
	}
	@Override
	@Cacheable(key="'OrderItemS-EXcs-'+#p0")
	public Boolean isExistCSInfo(int csid) {
		 OrderItemExample example =new OrderItemExample(); 
		example.createCriteria().andCsidEqualTo(csid).andOidIsNotNull();
	        List<OrderItem> ois =orderItemMapper.selectByExample(example);
	        if (ois.size()>0) {
	        	return true;
			}
		return false;
	}
 
}