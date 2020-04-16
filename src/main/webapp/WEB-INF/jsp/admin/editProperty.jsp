<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
 
<title>编辑属性</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">编辑属性</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>

<div class="workingArea">
    <ol class="breadcrumb">
       <li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${tc.topCategoryId}">${tc.topCategoryName}-分类列表</a></li>
      <li><a href="admin_property_list?cid=${p.category.categoryId}">${p.category.categoryName}-属性列表</a></li>
      <li class="active">编辑属性</li>
    </ol>
 
    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑属性</div>
        <div class="panel-body">
            <form method="post" id="editForm" action="admin_property_update">
                <table class="editTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input id="name" name="propertyName" value="${p.propertyName}"
                            type="text" class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                        <input type="hidden" name="propertyId" value="${p.propertyId}">
                        <input type="hidden" name="cid" value="${p.category.categoryId}">
                        <button type="submit" class="btn btn-success">提 交</button>
                          <a class="text-info cancelEdit" href="admin_property_list?cid=${p.category.categoryId}">取消编辑</a></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

 <script>
    $(function(){
    	document.getElementById("name").focus();
 		var isexist=false;
    	$("#name").blur(function(){
    		var name=$("#name").val();
    		var cid =${p.category.categoryId};
    		if(name.length!=0){
    			$.post(
    	    			"admin_check_property",
    	    			{"name":name,"cid":cid},
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
        $("#editForm").submit(function(){
        	var name=$("#name").val();
        	if(name.length==0){
        		$(".alert").html("名称不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
        	}
        	else{
        		if(isexist){
        			$(".alert").html("该属性已存在").addClass("alert-danger").show().delay(1500).fadeOut();
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