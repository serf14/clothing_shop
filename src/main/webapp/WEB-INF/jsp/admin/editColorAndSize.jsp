<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>


<title>编辑颜色尺码</title>
<div class="row">
          <div class="col-lg-12">
			<h1 class="page-header">编辑颜色尺码</h1>
          </div>
          <!-- /.col-lg-12 -->
</div>

<div class="workingArea">
	<ol class="breadcrumb">
	<li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
	<li><a href="admin_product_list?cid=${p.category.categoryId}">${p.category.categoryName}-产品列表</a></li>
	<li><a href="admin_colorAndSize_list?pid=${p.productId}">${p.productName}-颜色尺码列表</a></li>
	<li class="active">编辑颜色尺码</li>
	</ol>

	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑颜色尺码</div>
		<div class="panel-body">
			<form method="post" id="editForm" action="admin_colorAndSize_update">
				<table class="editTable">
					<tr>
						<td>颜色</td>
						<td><input id="color" name="colorValue" value="${cs.colorValue}"
								   type="text" class="form-control"></td>
					</tr>
					   <tr>
                     <td >尺码选择</td>
                     <td>
                     <div class="col-xs-6">
              			       字母类型：
                        <select class=" selectSize form-control" >
						<option>XXS</option>
						<option>XS</option>
						<option>S</option>
						<option>M</option>
						<option>L</option>
						<option>XL</option>
						<option>XXL</option>
						<option>3XL</option>
						<option>4XL</option>
						</select>
						</div>
						<div class="col-xs-6">
						数字类型：
                        <select class="selectSize form-control col-xs-6" >
						<c:forEach  begin="20" end="60" var="size">
						 <option>${size}</option>
					    </c:forEach>
						</select>
						</div>
					</td>
                    </tr>
					<tr>
						<td>尺码</td>
						<td><input id="size" name="sizeValue" type="text"
								   value="${cs.sizeValue}"
								   class="form-control"></td>
					</tr>
					<tr>
						<td>库存</td>
						<td><input id="stock" value="${cs.stock}" name="stock" type="text"
								   class="form-control"></td>
					</tr>
					

					<tr class="submitTR">
						<td colspan="2" align="center">
							<input type="hidden" name="pid" value="${p.productId}">
							<input type="hidden" name="csid" value="${cs.csid}">
							<button type="submit" class="btn btn-success">提 交</button>
							<a class="text-info cancelEdit" href="admin_colorAndSize_list?pid=${p.productId}">取消编辑</a>
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
    	var reg= /(^\+?[1-9][0-9]*$)/ ;
    	
    	function checkcs(){
    		var color =$("#color").val();
    		var size =$("#size").attr("value") ;
    		var pid =${p.productId};
    		var csid =${cs.csid};
    		if(color.length!=0&&size.length!=0){
    			$.post(
  		    			"admin_check_colorAndSize",
  		    			{"color":color,"size":size,"pid":pid,"csid":csid},
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
    	}
    	$("#color").blur(function(){
    		checkcs();
    	});
    	$(".selectSize").change(function(){
    		
    		var size = $(this).find("option:selected").text();
    		$("#size").attr("value",size);
        	checkcs();
        	
    	});
        $("#editForm").submit(function() {
        	var color =$("#color").val();
        	var size = $("#size").val();
        	var stock = $("#stock").val();
        	if(color.length==0){
        		$(".alert").html("颜色名称不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
        	}
        	else if(size.length==0){
        		$(".alert").html("尺码不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
        	}
        	else{
        		if(!reg.test(stock)&&stock!=0){
        			$(".alert").html("库存必须为正整数或0").addClass("alert-danger").show().delay(1500).fadeOut();
        			return false;
        		}
        		if(isexist){
        			$(".alert").html("该颜色尺码组合已存在").addClass("alert-danger").show().delay(1500).fadeOut();
        			return false;
        		}
        		else
        			return true;
        	}
            return false;
        });
    });
</script>
<%@include file="../include/admin/adminFooter.jsp"%>