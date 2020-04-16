<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>分类管理</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">分类管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
 <input type="hidden" id="deleteWaring" value="${deleteWaring}">
<div class="workingArea">
<ol class="breadcrumb">
		<li><a href="admin_list_TopCategory">一级分类</a></li>
		<li class="active">${tc.topCategoryName}-分类列表</li>
	</ol>
	<input type="hidden" id="tcid" value='${tc.topCategoryId}'>
	 <select class="form-control myselect selectStatus">
           <option tcid="0">显示所有分类</option>
           <c:forEach items="${tcs}" var="tc">
           <option tcid="${tc.topCategoryId }">${tc.topCategoryName}</option>
           </c:forEach>
     </select>
<!-- 	<div class="searchDiv "> -->
<!--      <div class="input-group col-xs-12 "> -->
<!--       <input type="text" class="form-control searchInput" placeholder="Search for..."> -->
<!--       <span class="input-group-btn"> -->
<!--         <button class="btn btn-default mysearchButton" type="button"> -->
<!--                        搜索 -->
<!--         </button> -->
<!--       </span> -->
<!--     </div> -->
<!--     </div> -->
     
    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>分类名称</th>
                    <th>展示操作</th>
                    <th>展示级别</th>
                    <th>属性管理</th>
                    <th>产品管理</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${cs}" var="c">
                 
                <tr>
                    <td>${c.categoryId}</td>
                    <td>${c.categoryName}</td>
                    <td>
					<c:if test="${c.isShowHome==0}">
					<a href="admin_update_Category?categoryId=${c.categoryId }&isShowHome=1&tcid=${c.tcid }">
								<button class="btn btn-primary btn-xs">展示</button>
							</a>
					</c:if>	
					<c:if test="${c.isShowHome==1}">
					<a href="admin_update_Category?categoryId=${c.categoryId }&isShowHome=0&tcid=${c.tcid }">
								<button class="btn btn-danger btn-xs">撤销</button>
							</a>
					</c:if>	
					</td>
                    <td>${c.showLevel}
                    
                    </td>     
                    <td><a href="admin_property_list?cid=${c.categoryId}"><span class="glyphicon glyphicon-th-list"></span></a></td>                   
                    <td><a href="admin_product_list?cid=${c.categoryId}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>                  
                    <td><a href="admin_edit_Category?id=${c.categoryId}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a deleteLink="true" href="admin_delete_Category?id=${c.categoryId}"><span class="   glyphicon glyphicon-trash"></span></a></td>
     
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
     
    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp" %>
    </div>
     
    <div class="panel panel-warning addDiv">
      <div class="panel-heading">新增分类</div>
      <div class="panel-body">
            <form method="post" id="addForm" action="admin_add_Category" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input  id="name" name="categoryName" type="text" class="form-control"></td>
                    </tr>
                    <tr>
                    	<td>选择一级分类</td>
                    	<td>
                    	<select class="form-control col-xs-12 selectTC">
           				<c:forEach items="${tcs}" var="tc">
           				<option tcid="${tc.topCategoryId }">${tc.topCategoryName}</option>
           				</c:forEach>
    					</select></td>
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
                            <input id="tcid" type="hidden" name="tcid" value="${tc.topCategoryId}">
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
		    			"admin_check_Category",
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
    $(".mysearchButton").click(function(){
    	var input =encodeURI(encodeURI($("input.searchInput").val())) ;
    	var tcid = ${tc.topCategoryId};
    	if(input.length!=0){
    		location.href="admin_list_SearchCategory?tcid="+tcid+"&&name="+input;
    	}
    	
    });
    var tcid=$("#tcid").val();
	$(".selectStatus").find("option[tcid="+tcid+"]").attr("selected",true);
    
    $(".selectStatus").change(function(){
		var tcid = $(this).find("option:selected").attr("tcid");
		location.href="admin_list_Category?tcid="+tcid;
	});
    
    $(".selectType").change(function(){
		var type = $(this).find("option:selected").attr("type");
		$("input#typeInput").attr("value",type);
	});
    $("input#tcid").attr("value",$(".selectTC").find("option:selected").attr("tcid"));
    $(".selectTC").change(function(){
		var tcid = $(this).find("option:selected").attr("tcid");
		$("input#tcid").attr("value",tcid);
	});
    
});
 
</script>
 
<%@include file="../include/admin/adminFooter.jsp"%>