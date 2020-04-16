<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>产品管理</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">新增产品</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="workingArea">

	<div class="panel panel-info ">
		<div class="panel-heading">新增产品</div>
		<div class="panel-body">
			<form method="post" id="addForm" action="admin_product_add">
				<table class="addTable">
					<tr>
						<td>产品名称</td>
						<td><input id="name" name="productName" type="text"
								   class="form-control"></td>
					</tr>
					<tr>
					<td>产品分类</td>
					<td>
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
					</td>
					</tr>
					<tr>
			             <td>服装类型</td>
		                 <td>
						 <select class="form-control col-xs-12 selectType">
					           <option type="0">男装</option>
					           <option type="1">女装</option>
					           <option type="2">童装</option>
					           <option type="3">男女通用</option>
					     </select>
						</td>
                    </tr>
					<tr>
						<td>产品小标题</td>
						<td><input id="subTitle" name="subTitle" type="text"
								   class="form-control"></td>
					</tr>
					<tr>
						<td>原价格</td>
						<td><input id="originalPrice" value="99.98" name="originalPrice" type="text"
								   class="form-control"></td>
					</tr>
					<tr>
						<td>优惠价格</td>
						<td><input id="promotePrice"  value="19.98" name="promotePrice" type="text"
								   class="form-control"></td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td>库存</td> -->
<!-- 						<td><input id="stock"  value="99" name="stock" type="text" -->
<!-- 								   class="form-control"></td> -->
<!-- 					</tr> -->
					<tr class="submitTR">
						<td colspan="2" align="center">
							<input type="hidden" id="cidInput" name="cid" value="">
							<input type="hidden" id="typeInput" name="type" value="0">
							<button type="submit" class="btn btn-success">提 交</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</div>

<script>
    $(function() {
    	
    	<c:if test="${msg=='success'}">
      	 $(".alert").html("操作成功").addClass("alert-success").show().delay(1500).fadeOut();
           </c:if>
           var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
      	 var isexist=true;
      		$("#name").blur(function(){
      			var name=$("#name").val()
      			if(name.length!=0){
      				$.post(
      		    			"admin_check_Product",
      		    			{"name":name},
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
        $("#addForm").submit(function() {
        	var name=$("#name").val();
        	var cid = $(".selectC").find("option:selected").attr("cid");
        	var originalPrice=$("#originalPrice").val();
        	var promotePrice =$("#promotePrice").val();
           	if(name.length==0){
           		$(".alert").html("名称不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
           	}
           	else if(cid==0){
           		$(".alert").html("请选择产品分类").addClass("alert-danger").show().delay(1500).fadeOut();
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
           		if(!isexist){
           			$("#cidInput").attr("value",cid);
       				return true;
       			}
           	}
               return false;
        });
        
        
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
    	});
        
        $(".selectType").change(function(){
    		var type = $(this).find("option:selected").attr("type");
    		$("input#typeInput").attr("value",type);
    	});
        
        
    });
</script>

<%@include file="../include/admin/adminFooter.jsp"%>