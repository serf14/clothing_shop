package com.wzx.service.serviceimpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.beans.DocumentObjectBinder;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.util.NamedList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import com.wzx.mapper.ProductMapper;
import com.wzx.pojo.Product;
import com.wzx.pojo.ProductExample;
import com.wzx.service.SolrService;


@Service
public class SolrServiceImpl implements SolrService{

	    @Autowired
	    private SolrClient solrServer;
	@Override
	public void importProduct(List<Product> list) {
		System.err.println("导入数据");
        //把商品信息写入索引库
        for (Product item : list) {
            //创建一个SolrInputDocument对象
            SolrInputDocument document = new SolrInputDocument();
            document.setField("id", item.getProductId());
            document.setField("productName", item.getProductName());
            document.setField("subTitle", item.getSubTitle());
            document.setField("originalPrice", item.getOriginalPrice());
            document.setField("promotePrice", item.getPromotePrice());
            //写入索引库
            try {
				solrServer.add(document);
				
			} catch (SolrServerException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        //提交修改
        try {
			solrServer.commit();
		} catch (SolrServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	@Override
	public List<Product> searchBykey(String keywords) {
		 SolrQuery query = new SolrQuery();
		 query.setQuery("productName:"+keywords);
		 System.err.println(keywords);
		 //设置分页
//	        query.setStart(startOfPage);
//	        query.setRows(numberOfPage);
//	        设置高亮显示
	        query.setHighlight(true);
	        query.addHighlightField("productName");
	        // 高亮单词的前缀
	        query.setHighlightSimplePre("<span style=\"color:red\">");
	        // 高亮单词的后缀
	        query.setHighlightSimplePost("</span>");
	        query.setHighlightFragsize(100);
		 List<Product> resultlist=new ArrayList<Product>();
	        //根据查询条件查询索引库
	        QueryResponse queryResponse = null;
			try {
				System.err.println("执行查询");
				queryResponse = solrServer.query(query);
				  //取查询结果
				SolrDocumentList solrDocumentList = queryResponse.getResults();
				//高亮结果
				Map<String, Map<String, List<String>>> map = queryResponse.getHighlighting();
		        for(SolrDocument solrDocument:solrDocumentList) {
		        	 Product product=new Product();
		        	product.setProductId(Integer.valueOf(solrDocument.get("id").toString()));

			            String name = map.get(solrDocument.getFieldValue("id")).get("productName").get(0);	
			            if (name!=null) {
			            	product.setProductName(name);
						}
			            else {
			            	  name = (String) solrDocument.get("productName");
			            }
			            product.setProductName(name);
			            product.setSubTitle((String) solrDocument.get("subTitle"));
			            product.setOriginalPrice((Float) solrDocument.get("originalPrice"));
			            product.setPromotePrice((Float) solrDocument.get("promotePrice"));
			            //添加的商品列表
			            resultlist.add(product);
				}
		        
			} catch (SolrServerException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			 
			
			
	      
		return resultlist;
	}
	@Override
	public List<Product> searchBykeyPage(String keywords) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void remove(String id) {
		  try {
			  solrServer.deleteById(id);
			  solrServer.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	@Override
	public void add(Product item) {
		  SolrInputDocument document = new SolrInputDocument();
          document.setField("id", item.getProductId());
          document.setField("productName", item.getProductName());
          document.setField("subTitle", item.getSubTitle());
          document.setField("originalPrice", item.getOriginalPrice());
          document.setField("promotePrice", item.getPromotePrice());
          //写入索引库
          try {
				solrServer.add(document);
				
			} catch (SolrServerException | IOException e) {
				e.printStackTrace();
			}
          try {
  			solrServer.commit();
  		} catch (SolrServerException e) {
  			e.printStackTrace();
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
	}		
 
}
