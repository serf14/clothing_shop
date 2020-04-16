<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>


<title>普通用户管理</title>


<div class="workingArea">
	
  			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">普通用户管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
	<br>
	<br>

	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
			<tr>
				<th>ID</th>
				<th>用户名称</th>
				<th>注册时间</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${us}" var="u">
				<tr>
					<td>${u.userId}</td>
					<td>${u.userName}</td>
					<td>${u.createDate}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>


</div>

<%@include file="../include/admin/adminFooter.jsp"%>
