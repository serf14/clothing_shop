<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>产品管理</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">产品管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
 <input type="hidden" id="deleteWaring" value="${deleteWaring}">
  <input type="hidden" id="deleteWaringByOrder" value="${deleteWaringByOrder}">
<div class="workingArea">

	<ol class="breadcrumb">
	<li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
    <li class="active">${c.categoryName}-产品列表</li>
	</ol>

<!-- 	<div class="searchDiv"> -->
<!--      <div class="input-group col-xs-12 "> -->
<%--      <input type="hidden" id="cid" value='${c.categoryId}'> --%>
<!--       <input type="text" class="form-control searchInput" placeholder="Search for..."> -->
<!--       <span class="input-group-btn"> -->
<!--         <button class="btn btn-default mysearchButton" type="button"> -->
<!--                        搜索 -->
<!--         </button> -->
<!--       </span> -->
<!--     </div> -->
<!--     </div> -->
		<input type="hidden" id="tcid" value='${tc.topCategoryId}'>
		一级分类：
	 <select class="form-control selectTC myselect">
           <option tcid="0">未选择</option>
           <c:forEach items="${tcs}" var="tc">
           <option tcid="${tc.topCategoryId }">${tc.topCategoryName}</option>
           </c:forEach>
     </select>
     <input type="hidden" id="cid" value='${c.categoryId}'>
      分类：
      <select class="form-control selectC myselect">
           <option cid="0">-  -</option>
           <c:forEach items="${cs}" var="c">
           <option cid="${c.categoryId }">${c.categoryName}</option>
           </c:forEach>
     </select>
	<div class="listDataTableDiv">
		<table
				class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
			<tr >
				<th>ID</th>
				<th>图片</th>
				<th>产品名称</th>
				<th>产品小标题</th>
				<th width="53px">类型</th>
				<th width="53px">原价格</th>
				<th width="80px">优惠价格</th>
				<th width="80px">库存数量</th>
				<th width="80px">图片管理</th>
				<th width="100px">颜色尺码管理</th>
				<th width="80px">设置属性</th>
				<th width="42px">编辑</th>
				<th width="42px">删除</th>
				<th width="42px">操作</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${ps}" var="p">
				<tr>
					<td>${p.productId}</td>
					<td>

						<c:if test="${!empty p.firstProductImage}">
							<img width="40px" src="img/productSingle/${p.firstProductImage.productImageId}.jpg">
						</c:if>

					</td>
					<td>${p.productName}</td>
					<td>${p.subTitle}</td>
					<td>
					<c:if test="${p.type==0}">
					男装
					</c:if>	
					<c:if test="${p.type==1}">
					女装
					</c:if>	
					<c:if test="${p.type==2}">
					童装
					</c:if>	
					<c:if test="${p.type==3}">
					男女通用
					</c:if>	
					</td>
					<td>${p.originalPrice}</td>
					<td>${p.promotePrice}</td>
					<td>${p.stock}</td>
					<td><a href="admin_productImage_list?pid=${p.productId}"><span
							class="glyphicon glyphicon-picture"></span></a></td>
					<td><a href="admin_colorAndSize_list?pid=${p.productId}"><span
							class="glyphicon glyphicon-picture"></span></a></td>
					<td><a href="admin_propertyValue_edit?pid=${p.productId}"><span
							class="glyphicon glyphicon-th-list"></span></a></td>

					<td><a href="admin_product_edit?id=${p.productId}"><span
							class="glyphicon glyphicon-edit"></span></a></td>
					<td><a deleteLink="true"
						   href="admin_product_delete?id=${p.productId}"><span
							class="     glyphicon glyphicon-trash"></span></a></td>
					<td>
					<c:if test="${p.status==0}">
					<a href="admin_product_up?id=${p.productId}&cid=${c.categoryId }">
								<button class="btn btn-primary btn-xs">上架</button>
							</a>
					</c:if>	
					<c:if test="${p.status==1}">
					<a href="admin_product_down?id=${p.productId}&cid=${c.categoryId }">
								<button class="btn btn-danger btn-xs">下架</button>
							</a>
					</c:if>	
					</td>
				
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp"%>
	</div>


</div>

<script>
    $(function() {
    	
    	<c:if test="${msg=='success'}">
      	 $(".alert").html("操作成功").addClass("alert-success").show().delay(1500).fadeOut();
           </c:if>
           var deleteWaring=$("#deleteWaring").val();
           var deleteWaringByOrder=$("#deleteWaringByOrder").val();
           
           if(deleteWaring!=""){
          	 $(".alert").html(deleteWaring).addClass("alert-danger").show().delay(1500).fadeOut();
           }
           if(deleteWaringByOrder!=""){
            	 $(".alert").html(deleteWaringByOrder).addClass("alert-danger").show().delay(1500).fadeOut();
             }
        var tcid=$("#tcid").val();
    	$(".selectTC").find("option[tcid="+tcid+"]").attr("selected",true);
        $(".selectTC").change(function(){
    		var tcid = $(this).find("option:selected").attr("tcid");
    		$(".selectC").empty();
    		$.post(
        			"admin_list_CategoryByTcid",
        			{"tcid":tcid},
        			function(result){
        				if(result!=null){
        					 $(".selectC").append("<option cid= '"+0+"'>"+"-  -"+"</option>");
        					jsonData = JSON.stringify(result);
        					jQuery.each(JSON.parse(jsonData), function(i,item){  
        						 $(".selectC").append("<option cid= '"+item.categoryId+"'>"+item.categoryName+"</option>");
        					});
        					$(".selectC").find("option:first").attr("selected",true);
        				}
        			});
        });
        
        
        var cid=$("#cid").val();
    	$(".selectC").find("option[cid="+cid+"]").attr("selected",true);
        $(".selectC").change(function(){
    		var cid = $(this).find("option:selected").attr("cid");
    		location.href="admin_product_list?cid="+cid;
    	});
        
        
    });
</script>

<%@include file="../include/admin/adminFooter.jsp"%>