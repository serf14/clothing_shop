一级分类<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>颜色尺码管理</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">颜色尺码管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
 <input type="hidden" id="deleteWaringByOrder" value="${deleteWaringByOrder}">
<div class="workingArea">
 
    <ol class="breadcrumb">
     	<li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
	<li><a href="admin_product_list?cid=${c.categoryId}">${c.categoryName}-产品列表</a></li>
	<li class="active">${p.productName}-颜色尺码列表</li>
    </ol>
 
    <div class="listDataTableDiv">
  
        <table
            class="table table-striped table-bordered   table-condensed">
            <thead>
                <tr>
                    <th>颜色样式</th>
					<td align="right">操作</td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${colors}" var="color">
                    <tr class="sizePageItemTH" color="${color}">
                        <td>${color}</td>
                        <td align="right">
                        <button color="${color}" class="orderPageCheckOrderItems btn btn-primary btn-xs">展开</button>
                        </td>
                    </tr>
                    <tr class="sizePageItemTR" color="${color}">
                   		 <td colspan="10" align="center">
                    	<div class="sizePageItem" color="${color}">
                    	<table width="800px" align="center" class="table table-striped table-bordered table-hover  table-condensed">
                    	<thead>
                    	<tr>
                    		<th>ID</th>
	                    	<th>尺码</th> 
		                    <th>库存</th>
		                    <th>编辑</th>
		                    <th>删除</th>
                    	</tr>
                    	</thead>
                    	<tbody>
                    	<c:forEach items="${cs}" var="cas">
                    	<c:if test="${cas.colorValue==color}">
                    	<tr>
                    	<td>${cas.csid}</td>
                        <td>${cas.sizeValue}</td>
                        <td>${cas.stock}</td>
                        <td><a href="admin_colorAndSize_edit?id=${cas.csid}"><span
                                class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true"
                            href="admin_colorAndSize_delete?id=${cas.csid}"><span
                                class="     glyphicon glyphicon-trash"></span></a></td>
                    	</tr>
                    	</c:if>
                    	</c:forEach>
                    	</tbody>
                    	</table>
                    	</div>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
 
 
    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增颜色尺码</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="admin_colorAndSize_add">
                <table class="addTable">
                    <tr>
                        <td>颜色名称</td>
                        <td><input id="color" name="colorValue" type="text"
                            class="form-control"></td>
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
                        <td>尺码名称</td>
                        <td><input id="size" name="sizeValue" type="text" readonly="readonly"
                            class="form-control"></td>
                    </tr>
                     <tr>
                        <td>库存</td>
                        <td><input id="stock" name="stock" type="text" value="20"
                            class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="pid" value="${p.productId}">
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
    	
    	var isexist=true;
    	var reg= /(^\+?[1-9][0-9]*$)/ ;
    	
    	  var deleteWaringByOrder=$("#deleteWaringByOrder").val();
    	     if(deleteWaringByOrder!=""){
    	    	 $(".alert").html(deleteWaringByOrder).addClass("alert-danger").show().delay(1500).fadeOut();
    	     }
    	
    	function checkcs(){
    		var color =$("#color").val();
    		var size =$("#size").attr("value") ;
    		var pid =${p.productId};
    		if(color.length!=0&&size.length!=0){
    			$.post(
  		    			"admin_check_colorAndSize",
  		    			{"color":color,"size":size,"pid":pid},
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
        $("#addForm").submit(function() {
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
        var click =false;
        $("button.orderPageCheckOrderItems").click(function(){
            var color = $(this).attr("color");
            $("tr.sizePageItemTR[color="+color+"]").toggle();
            click=true;
            
        });
        
        $("tr.sizePageItemTH").click(function(){
            var color = $(this).attr("color");
            if(click){
            	click=false;
            }
            else
            $("tr.sizePageItemTR[color="+color+"]").toggle();
        });
        
    });
</script>
 
<%@include file="../include/admin/adminFooter.jsp"%>