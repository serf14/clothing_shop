package com.wzx.service.serviceimpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.wzx.mapper.OrderMapper;
import com.wzx.pojo.Order;
import com.wzx.pojo.OrderExample;
import com.wzx.pojo.OrderItem;
import com.wzx.pojo.User;
import com.wzx.service.OrderItemService;
import com.wzx.service.OrderService;
import com.wzx.service.UserService;
import com.wzx.util.TimeUtil;

import com.wzx.service.ReviewService;
 
@Service
@CacheConfig(cacheNames="OrderS")
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderMapper orderMapper;
 
    @Autowired
    UserService userService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;
    @Override
    @CacheEvict(allEntries=true)
    public void add(Order c) {
        orderMapper.insert(c);
    }
 
    @Override
    @CacheEvict(allEntries=true)
    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }
 
    @Override
    @CacheEvict(allEntries=true)
    public void update(Order c) {
        orderMapper.updateByPrimaryKeySelective(c);
    }
 
    @Override
    @Cacheable(key="'OrderS-one-'+#p0")//前台使用
    public Order get(int id) {
    	Order order=orderMapper.selectByPrimaryKey(id);
        return order;
    }
    @Override
//    @Cacheable(key="'OrderS-all'")//后台使用
    public List<Order> list(){
        OrderExample example =new OrderExample();
        example.setOrderByClause("orderId desc");
        List<Order> result =orderMapper.selectByExample(example);
        setUser(result);
        return result;
    }
    @Override
    @Cacheable(key="'OrderS-listU-'+#p0")//前台使用
    public List<Order> list(int uid, String[] excludedStatus) {
        OrderExample example =new OrderExample();
        example.createCriteria().andUidEqualTo(uid).andStatusNotEqualTo(excludedStatus[0]).andStatusNotEqualTo(excludedStatus[1]);
        example.setOrderByClause("orderId desc");
        List<Order> list = orderMapper.selectByExample(example);
        return list;
    }
    public void setUser(List<Order> os){
        for (Order o : os)
            setUser(o);
    }
    
    public void setUser(Order o){
        int uid = o.getUid();
        User u = userService.get(uid);
        o.setUser(u);
    }
    @Override
    @Transactional(propagation= Propagation.REQUIRED,rollbackForClassName="Exception")
    @CacheEvict(allEntries=true)
    public float add(Order o, List<OrderItem> ois) {
        float total = 0;
        add(o);
//        用来模拟当增加订单后出现异常，观察事务管理是否预期发生。（需要把false修改为true才能观察到）
//        if(false)
//            throw new RuntimeException();
 
        for (OrderItem oi: ois) {
            oi.setOid(o.getOrderId());
            orderItemService.update(oi);
            total+=oi.getProduct().getPromotePrice()*oi.getNumber();
        }
        return total;
    }

	@Override
	@Cacheable(key="'OrderS-isDO-'+#p0")//前台使用
	public Boolean isDoAllReview(int oid) {
		int oiNum = orderItemService.listByOid(oid).size();
		int reviewNum = reviewService.getCountByOid(oid);
		System.out.println(oiNum);
		System.out.println(reviewNum);
		if (oiNum==reviewNum) {
			return true;
		}
		return false;
	}
/**
 * 填充未评价的订单项
 */
	@Override
	public Order notReviewOrder(Order o) {
		Order order =new Order();
		order.setOrderId(o.getOrderId());

		for (OrderItem oi: o.getOrderItems()) {
			if (!reviewService.isReview(oi)) {
				order.getOrderItems().add(oi);
			}
		}
		return order;
	}

	@Override
//	@Cacheable(key="'OrderS-listST-'+#p0")
	public List<Order> listByStatus(String status) {
		
	    OrderExample example =new OrderExample();
	    if (status.equals(finish)) {
			List<String> values = new ArrayList<>();
			values.add(deleteFinish);
			values.add(finish);
			example.createCriteria().andStatusIn(values);
		}
	    else if(status.equals(cancelOrder)) {
			List<String> values = new ArrayList<>();
			values.add(deleteCancel);
			values.add(cancelOrder);
			example.createCriteria().andStatusIn(values);
		}
	    else if(status.equals(completeRefund)) {
			List<String> values = new ArrayList<>();
			values.add(deleteRefund);
			values.add(completeRefund);
			example.createCriteria().andStatusIn(values);
		}
	    else
	    example.createCriteria().andStatusEqualTo(status);
        example.setOrderByClause("orderId desc");
        return orderMapper.selectByExample(example);
	}

	@Override
	public int getTodayOrderNum() {
		 OrderExample example =new OrderExample();
	     example.createCriteria().andCreateDateBetween(TimeUtil.getStartTime(), TimeUtil.getEndTime());
	     List<Order> os = orderMapper.selectByExample(example);
		return os.size();
	}

	@Override
	public double getAllOrderPay(List<Order> os) {
		 
	     double pay = 0;
	     for(Order o:os) {
	    	 if (o.getStatus()!=OrderService.waitPay
	    			 &&o.getStatus()!=OrderService.waitRefund
	    			 &&o.getStatus()!=OrderService.cancelOrder
	    			 &&o.getStatus()!=OrderService.completeRefund) {
	    		 pay+=o.getOrderPrice();
			}
	     }
		return pay;
	}

	@Override
	public List<Order> listByTime(Date start, Date end) {
		OrderExample example =new OrderExample();
	     example.createCriteria().andCreateDateBetween(start, end);
	     return orderMapper.selectByExample(example);
	}

	@Override
	public List<Order> listByTimeAndStatus(Date start, Date end, String status) {
		OrderExample example =new OrderExample();
	    if (status.equals(finish)) {
			List<String> values = new ArrayList<>();
			values.add(deleteFinish);
			values.add(finish);
			example.createCriteria().andCreateDateBetween(start, end).andStatusIn(values);
		}
	    else if(status.equals(cancelOrder)) {
			List<String> values = new ArrayList<>();
			values.add(deleteCancel);
			values.add(cancelOrder);
			example.createCriteria().andCreateDateBetween(start, end).andStatusIn(values);
		}
	    else if(status.equals(completeRefund)) {
			List<String> values = new ArrayList<>();
			values.add(deleteRefund);
			values.add(completeRefund);
			example.createCriteria().andCreateDateBetween(start, end).andStatusIn(values);
		}
	    else
	    example.createCriteria().andCreateDateBetween(start, end).andStatusEqualTo(status);
	    
        example.setOrderByClause("orderId desc");
        return orderMapper.selectByExample(example);
	}

	@Override
	public List<Order>  getPriceByTime(Date start, Date end) {
		return orderMapper.selectPriceByDate(start,end);
	}

}