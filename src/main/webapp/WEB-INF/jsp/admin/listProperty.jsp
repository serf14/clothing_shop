<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>属性管理</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">属性管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="workingArea">
 
    <ol class="breadcrumb">
    <li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
    <li class="active">${c.categoryName}-属性列表</li>
    </ol>
 
    <div class="listDataTableDiv">
        <table
            class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>属性名称</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${ps}" var="p">
 
                    <tr>
                        <td>${p.propertyId}</td>
                        <td>${p.propertyName}</td>
                        <td><a href="admin_property_edit?id=${p.propertyId}"><span
                                class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true"
                            href="admin_property_delete?id=${p.propertyId}"><span
                                class="     glyphicon glyphicon-trash"></span></a></td>
 
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
 
    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>
 
    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增属性</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="admin_property_add">
                <table class="addTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input id="name" name="propertyName" type="text"
                            class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="cid" value="${c.categoryId}">
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
   		$("#name").blur(function(){
   			var name=$("#name").val()
   			var cid = ${c.categoryId};
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
       $("#addForm").submit(function(){
       	var name=$("#name").val()
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