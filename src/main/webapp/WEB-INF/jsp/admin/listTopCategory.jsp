<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>一级分类管理</title>
 
            <div class="row">
                <div class="col-lg-12">
                   <h1 class="page-header">一级分类管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
 <input type="hidden" id="deleteWaring" value="${deleteWaring}">
                    <div class="workingArea">
				    <div class="listDataTableDiv">
				        <table class="table table-striped table-bordered table-hover  table-condensed">
				            <thead>
				                <tr>
				                    <th>ID</th>
				                    <th>一级分类名称</th>
				                    <th>分类管理</th>
				                    <th>编辑</th>
				                    <th>删除</th>
				                </tr>
				            </thead>
				            <tbody>
				                <c:forEach items="${tcs}" var="tc">
				                 
				                <tr>
				                    <td>${tc.topCategoryId}</td>
				                    <td>${tc.topCategoryName}</td>
				                    <td><a href="admin_list_Category?tcid=${tc.topCategoryId}"><span class="glyphicon glyphicon-th-list"></span></a></td>                   
				                    <td><a href="admin_edit_TopCategory?tcid=${tc.topCategoryId}"><span class="glyphicon glyphicon-edit"></span></a></td>
				                    <td><a deleteLink="true" href="admin_delete_TopCategory?tcid=${tc.topCategoryId}"><span class="   glyphicon glyphicon-trash"></span></a></td>
				     
				                </tr>
				                </c:forEach>
				            </tbody>
				        </table>
				    </div>
    
				    <div class="pageDiv">
				        <%@include file="../include/admin/adminPage.jsp" %>
				    </div>
     
				    <div class="panel panel-warning addDiv">
				      <div class="panel-heading">新增一级分类</div>
				      <div class="panel-body">
				            <form method="post" id="addForm" action="admin_add_TopCategory" enctype="multipart/form-data">
				                <table class="addTable">
				                    <tr>
				                        <td>一级分类名称</td>
				                        <td><input  id="name" name="topCategoryName" type="text" class="form-control"></td>
				                    </tr>
				                     <tr>
				                        <td>服装类型</td>
				                        <td>
										 <select class="form-control col-xs-12 selectType">
									           <option type="0">男装</option>
									           <option type="1">女装</option>
									           <option type="2">童装</option>
									           <option type="3">男装女装</option>
									           <option type="4">男装童装</option>
									           <option type="5">女装童装</option>
									           <option type="6">男装女装童装</option>
									     </select>
										</td>
				                    </tr>
				                    <tr class="submitTR">
				                        <td colspan="2" align="center">
				                        <input type="hidden" id="typeInput" name="type" value="">
				                        <button type="submit" class="btn btn-success">提 交</button>
				                        </td>
				                    </tr>
				                </table>
				            </form>
				      </div>
				    </div>
				</div>
 
                
 
<script>
$(function(){
	 <c:if test="${msg=='success'}">
	 $(".alert").html("操作成功").addClass("alert-success").show().delay(1500).fadeOut();
     </c:if>
     
	
     var deleteWaring=$("#deleteWaring").val();
     if(deleteWaring!=""){
    	 $(".alert").html(deleteWaring).addClass("alert-danger").show().delay(1500).fadeOut();
     }
     var isexist=false;
	$("#name").blur(function(){
		var name=$("#name").val()
		if(name.length!=0){
			$.post(
	    			"admin_check_TopCategory",
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
	
    $("#addForm").submit(function(){
    	var name=$("#name").val()
    	if(name.length==0){
    		$(".alert").html("名称不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
    	}
    	else{
//     		$.post(
//     			"admin_check_TopCategory",
//     			{"name":name},
//     			function(result){
//     				if(result=="exist"){
//     					$(".alert").html("该一级分类已存在").addClass("alert-danger").show().delay(1500).fadeOut();
//     				}
//     				if(result=="notExist"){
//     					return true;
//     				}
//     			}
//     		);
			if(isexist){
				$(".alert").html("该一级分类已存在").addClass("alert-danger").show().delay(1500).fadeOut();
				return false;
				
			}
			else{
				return true;
			}
    	}
        return false;
    });
    
    $(".selectType").change(function(){
		var type = $(this).find("option:selected").attr("type");
		$("input#typeInput").attr("value",type);
	});
});
 
</script>
 
<%@include file="../include/admin/adminFooter.jsp"%>