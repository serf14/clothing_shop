<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
 
<title>编辑分类</title>
<div class="row">
              <div class="col-lg-12">
				<h1 class="page-header">编辑分类</h1>
              </div>
              <!-- /.col-lg-12 -->
</div>

<div class="workingArea">
 
    <ol class="breadcrumb">
        <li><a href="admin_list_TopCategory">一级分类</a></li>
        <li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
        <li class="active">编辑分类：<span class="text-primary">${c.categoryName}</span></li>
        
    </ol>
 
    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑分类</div>
        <div class="panel-body">
            <form method="post" id="editForm" action="admin_update_Category"  enctype="multipart/form-data">
                <table class="editTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input  id="name" name="categoryName" value="${c.categoryName}" type="text" class="form-control"></td>
                    </tr>
                      <tr>
                        <td>展示级别</td>
                        <td>
                        <select id="level" class="form-control">
                        </select>
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" id="cid" name="categoryId" value="${c.categoryId}">
                            <input type="hidden" name="tcid" value="${c.tcid}">
                            <input type="hidden" id="showlevel" name="showLevel" value="${c.showLevel}">
                            <button type="submit" class="btn btn-success">提 交</button>
                            <a class="text-info cancelEdit" href="admin_list_Category?tcid=${c.tcid}">取消编辑</a>
                        </td>
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
    		var id = $("#cid").val();
    		if(name.length!=0){
    			$.post(
    	    			"admin_check_Category",
    	    			{"name":name,"id":id},
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
        			$(".alert").html("该分类已存在").addClass("alert-danger").show().delay(1500).fadeOut();
    				return false;
    			}
    			else{
    				return true;
    			}
        	}
            return false;
        });
        
        var  total=${total};
        var level=$("#showlevel").val();
        	for(var i=0;i<total;i++){
        		$("#level").append("<option level='"+i+"'>"+i+"</option>");
        	}
        	$("#level").find("option[level="+level+"]").attr("selected",true);
        	
        	
        	$("#level").change(function(){
        		var showlevel= $(this).find("option:selected").attr("level");
        		$("#showlevel").attr("value",showlevel);
        	});
    });
 
</script>
<%@include file="../include/admin/adminFooter.jsp"%>