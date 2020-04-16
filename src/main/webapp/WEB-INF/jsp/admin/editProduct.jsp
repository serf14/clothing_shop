<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>


<title>编辑产品</title>
		<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">编辑产品</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>

<div class="workingArea">
	<ol class="breadcrumb">
	<li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
	<li><a href="admin_product_list?cid=${p.category.categoryId}">${p.category.categoryName}-产品列表</a></li>
	<li class="active">编辑产品：${p.productName}</li>
	</ol>

	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑产品</div>
		<div class="panel-body">
			<form method="post" id="editForm" action="admin_product_update">
				<table class="editTable">
					<tr>
						<td>产品名称</td>
						<td><input id="name" name="productName" value="${p.productName}"
								   type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>产品小标题</td>
						<td><input id="subTitle" name="subTitle" type="text"
								   value="${p.subTitle}"
								   class="form-control"></td>
					</tr>
					<tr>
						<td>原价格</td>
						<td><input id="originalPrice" value="${p.originalPrice}" name="originalPrice" type="text"
								   class="form-control"></td>
					</tr>
					<tr>
						<td>优惠价格</td>
						<td><input id="promotePrice"  value="${p.promotePrice}" name="promotePrice" type="text"
								   class="form-control"></td>
					</tr>

					<tr class="submitTR">
						<td colspan="2" align="center">
							<input type="hidden" name="productId" value="${p.productId}">
							<input type="hidden" name="status" value="${p.status}">
							<input type="hidden" name="cid" value="${p.category.categoryId}">
							<button type="submit" class="btn btn-success">提 交</button>
							<a class="text-info cancelEdit" href="admin_product_list?cid=${p.category.categoryId}">取消编辑</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>

<script>
$(function() {
  	 var isexist=false;
  	var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
  		$("#name").blur(function(){
  			var name=$("#name").val()
  			var pid=${p.productId};
  			if(name.length!=0){
  				$.post(
  		    			"admin_check_Product",
  		    			{"name":name,"pid":pid},
  		    			function(result){
  		    				if(result=="exist"){
  		    					isexist=true;
  		    				}
  		    				if(result=="notExist"){
  		    					isexist=false;
  		    				}
  		    			}
  		    		);
  			}
  			
  		});
    $("#editForm").submit(function() {
    	var name=$("#name").val();
    	var originalPrice=$("#originalPrice").val();
    	var promotePrice =$("#promotePrice").val();
       	if(name.length==0){
       		$(".alert").html("名称不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
       	}
       	else if(originalPrice.length==0){
           		$(".alert").html("原价格不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
       	}
       	else if(!reg.test(originalPrice)){
       		$(".alert").html("价格请输入大于0的整数或2位小数").addClass("alert-danger").show().delay(1500).fadeOut();
       	}
       	else{
       		if(promotePrice.length!=0)
       		{
       			if(!reg.test(promotePrice)){
       				$(".alert").html("价格请输入大于0的整数或2位小数").addClass("alert-danger").show().delay(1500).fadeOut();
       				return false;
       			}
       			else if(originalPrice<=promotePrice){
       				$(".alert").html("原价格需大于优惠价格").addClass("alert-danger").show().delay(1500).fadeOut();
           			return false;
       			}
       			
       		}
       		if(isexist){
       			$(".alert").html("该产品名称已存在").addClass("alert-danger").show().delay(1500).fadeOut();
   				return false;
   				
   			}
   			else{
   				return true;
   			}
       	}
           return false;
    });
});
</script>
<%@include file="../include/admin/adminFooter.jsp"%>