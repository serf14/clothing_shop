package com.wzx.service.serviceimpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.wzx.mapper.ProductMapper;
import com.wzx.pojo.Category;
import com.wzx.pojo.ColorAndSize;
import com.wzx.pojo.Product;
import com.wzx.pojo.ProductExample;
import com.wzx.pojo.ProductImage;
import com.wzx.service.CategoryService;
import com.wzx.service.ColorAndSizeService;
import com.wzx.service.OrderItemService;
import com.wzx.service.ProductImageService;
import com.wzx.service.ProductService;
import com.wzx.service.ReviewService;
import com.wzx.util.SpringContextUtil;

@Service
@CacheConfig(cacheNames="ProductS")
public class ProductServiceImpl implements ProductService {
		@Autowired
	    ProductMapper productMapper;
	    @Autowired
	    CategoryService categoryService;
	    @Autowired
	    ProductImageService productImageService;
	    @Autowired
	    OrderItemService orderItemService;
	    @Autowired
	    ReviewService reviewService;
	    @Autowired
	    ColorAndSizeService colorAndSizeService;
	@Override
	 @CacheEvict(allEntries=true)
	public void add(Product p) {
		productMapper.insert(p);
		
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void delete(int id) {
		productMapper.deleteByPrimaryKey(id);
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void update(Product p) {
		productMapper.updateByPrimaryKeySelective(p);
	}

	@Override
	@Cacheable(key="'ProductS-one-'+#p0")
	public Product get(int id) {
		 Product p = productMapper.selectByPrimaryKey(id);
		 setFirstProductImage(p);
	        setCategory(p);
	        return p;
	}
//	给product里设置category对象
	public void setCategory(List<Product> ps){
        for (Product p : ps)
            setCategory(p);
    }
    public void setCategory(Product p){
        int cid = p.getCid();
//        Category c = categoryService.get(cid);
        Category c = new Category();
        c.setCategoryId(cid);
        p.setCategory(c);
    }
	@Override
//	@Cacheable(key="'ProductS-listC-'+#p0")//后台使用
	public List<Product> list(int cid) {
		 ProductExample example = new ProductExample();
	        example.createCriteria().andCidEqualTo(cid);
	        example.setOrderByClause("productId desc");
	        List<Product> result = productMapper.selectByExample(example);
	        setCategory(result);
	        setFirstProductImage(result);
	        return result;
	}
	
	@Override
	@Cacheable(key="'ProductS-listST-'+#cid")//前台使用
	public List<Product> listByStatus(int cid,int status) {
		 ProductExample example = new ProductExample();
	        example.createCriteria().andCidEqualTo(cid).andStatusEqualTo(status);
	        example.setOrderByClause("productId desc");
	        List<Product> result = productMapper.selectByExample(example);
	        setCategory(result);
	        setFirstProductImage(result);
	        return result;
	}
	@Override
	@Cacheable(key="'ProductS-listSTAT-'+#cid+'type'+#type")//前台使用
	public List<Product> listByStatusAndType(int cid,int status,int type) {
		 ProductExample example = new ProductExample();
	        example.createCriteria().andCidEqualTo(cid).andStatusEqualTo(status).andTypeEqualTo(type);
	        example.setOrderByClause("productId desc");
	        List<Product> result = productMapper.selectByExample(example);
	        setCategory(result);
	        setFirstProductImage(result);
	        return result;
	}
	@Override
	public List<Product> listSearch(int cid, String name) {
		ProductExample example = new ProductExample();
        example.createCriteria().andCidEqualTo(cid).andStatusEqualTo(1).andProductNameLike("%"+name+"%");
        example.setOrderByClause("productId desc");
        List<Product> result = productMapper.selectByExample(example);
        setCategory(result);
        setFirstProductImage(result);
        return result;
	}
	@Override
	public void setFirstProductImage(Product p) {
		  List<ProductImage> pis = productImageService.listExclude(p.getProductId(), ProductImageService.type_detail);
	        if (!pis.isEmpty()) {
	            ProductImage pi = pis.get(0);
	            p.setFirstProductImage(pi);
	        }
	    }
	
    public void setFirstProductImage(List<Product> ps) {
    	
    	System.err.println("设置产品图片");
	        for (Product p : ps) {
	            setFirstProductImage(p);
	        }		
	}


//为多个分类填充产品集合（遍历每一个分类）将每一个分类进行fill(Category c)操作，目的是添加产品集合进去
    @Override
    public void fill(List<Category> cs) {
        for (Category c : cs) {
            fill(c);
        }
    }

    //为每一个分类填充该分类下的所有产品集合（根据产品表的cid字段进行查询），再将产品集合注入分类集合里
    @Override
    public void fill(Category c) {
    	System.err.println("给分类填充产品");
//    	缓存机制是通过切面编程 aop来实现的。 从fill方法里直接调用 listByCategory 方法，
//    	aop 是拦截不到的，也就不会走缓存了。 所以要通过这种 绕一绕 的方式故意诱发 aop, 这样才会想我们期望的那样走redis缓存。
    	ProductService productService = SpringContextUtil.getBean(ProductService.class);
        List<Product> ps = productService.listByStatus(c.getCategoryId(),1);
        c.setProducts(ps);
        
    }
    public void fillByType(Category c,int type) {
    	System.err.println("给分类填充产品");
//    	缓存机制是通过切面编程 aop来实现的。 从fill方法里直接调用 listByCategory 方法，
//    	aop 是拦截不到的，也就不会走缓存了。 所以要通过这种 绕一绕 的方式故意诱发 aop, 这样才会想我们期望的那样走redis缓存。
    	ProductService productService = SpringContextUtil.getBean(ProductService.class);
        List<Product> ps = productService.listByStatusAndType(c.getCategoryId(),1,type);
        c.setProducts(ps);
    }

    //为所有分类填充产品集合后，即到此所有分类下就有所属的产品集合，按照8个为一行，拆成多行，以利于后续页面上进行显示
    @Override
    public void fillByRow(List<Category> cs) {
        //每行显示的产品个数
        int productNumberEachRow = 8;
        //对每一个分类进行遍历
        for (Category c : cs) {
            //取出当前分类下的所有产品，单独存入products集合中
            List<Product> products =  c.getProducts();
            //新建一个productsByRow集合，第一次为null
            List<List<Product>> productsByRow =  new ArrayList<>();
            for (int i = 0; i < products.size(); i+=productNumberEachRow) {
                //每次循环都是8个 8个地装入，第一次size=0+8，第二次size=8+8以此类推
                int size = i+productNumberEachRow;
                //判断size大小，若size大于该分类集合下所有产品总数量，则size=product.size()即产品数，否则size=i+8(0+8第一次循环,第二次循环8+8以此类推)
                size= size>products.size()?products.size():size;
                //sublist代表把prodcts里的第i个和第 size-1 个之间产品装入productsOfEachRow集合中。（第一次0至7，第二次8至15依此类推）
                List<Product> productsOfEachRow =products.subList(i, size);
                //把productsOfEachRow封装好的产品集合 ，添加进先前定义好的 productsByRow集合中（此时productsByRow是为每8个为一个小产品集合的大集合），这样productsByRow里面就是按行隔离了
                productsByRow.add(productsOfEachRow);
            }
            //把按行隔离的 productsByRow集合 传回 该 Category 对象中
            c.setProductsByRow(productsByRow);
        }
    }
    @Override
    public void setSaleAndReviewNumber(Product p) {
        int saleCount = orderItemService.getSaleCount(p.getProductId());
        p.setSaleCount(saleCount);
 
        int reviewCount = reviewService.getCount(p.getProductId());
        p.setReviewCount(reviewCount);
    }
 
    @Override
    public void setSaleAndReviewNumber(List<Product> ps) {
        for (Product p : ps) {
            setSaleAndReviewNumber(p);
        }
    }
    @Override
    public List<Product> search(String keyword) {
        ProductExample example = new ProductExample();
        example.createCriteria().andProductNameLike("%" + keyword + "%");
        example.setOrderByClause("productId desc");
        List<Product> result = productMapper.selectByExample(example);
        setFirstProductImage(result);
        setCategory(result);
        return result;
    }

	@Override
	public int getStock(int id) {
		int result=0;
		List<ColorAndSize> cSizes=colorAndSizeService.list(id);
		for (ColorAndSize cs:cSizes) {
			result +=cs.getStock();
		}
		return result;
	}

	@Override
//	@Cacheable(key="'ProductS-EX-'+#p0")
	public boolean isExist(String name) {
		ProductExample example = new ProductExample();
        example.createCriteria().andProductNameEqualTo(name);
        List<Product> result = productMapper.selectByExample(example);
        if (result.size()==0) {
        	return false;
		}
        return true;
	}

	@Override
//	@Cacheable(key="'ProductS-EX-'+#p0")
	public boolean isExistExclude(String name, int pid) {
		ProductExample example = new ProductExample();
        example.createCriteria().andProductNameEqualTo(name);
        List<Product> result = productMapper.selectByExample(example);
        if (result.size()==0) {
        	return false;
		}
        else if(result.get(0).getProductId()==pid)
        	return true;
        
        return true;
	}

	@Override
//	@Cacheable(key="'ProductS-all'")后台使用
	public List<Product> listAll() {
		 ProductExample example = new ProductExample();
	        example.setOrderByClause("productId desc");
	        List<Product> result = productMapper.selectByExample(example);
	        setCategory(result);
	        setFirstProductImage(result);
	        return result;
	}

	@Override
	 @CacheEvict(allEntries=true)
	public void upordown(Product p) {
		productMapper.upordown(p);
	}

	@Override
	public List<Product> listallshow() {
		 ProductExample example = new ProductExample();
		 example.createCriteria().andStatusEqualTo(1);
	        List<Product> result = productMapper.selectByExample(example);
		return result;
	}
	

	

}
