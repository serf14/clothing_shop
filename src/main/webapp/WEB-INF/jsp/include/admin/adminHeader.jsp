<!-- 后台管理页面头部-->


<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %> 

<html>

<head>

 	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    
	<script src="js/jquery/2.0.0/jquery.min.js"></script>
	<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
	<!-- 	日历选择器js -->
	<link href="css/bootstrap/bootstrap-datetimepicker.min.css" rel="stylesheet">
	
    <!-- SB Admin Scripts - Include with every page -->
    <script src="sb-admin-v2/js/sb-admin.js"></script>
   


  <script src="sb-admin-v2/js/jquery-1.10.2.js"></script>
    <script src="sb-admin-v2/js/bootstrap.min.js"></script>
    <script src="sb-admin-v2/js/plugins/metisMenu/jquery.metisMenu.js"></script>

    <!-- Page-Level Plugin CSS - Dashboard -->
    <link href="css/sb-admin-v2/css/plugins/timeline/timeline.css" rel="stylesheet">

     <!-- Core CSS - Include with every page -->
    <link href="sb-admin-v2/css/bootstrap.min.css" rel="stylesheet">
    <link href="sb-admin-v2/font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Page-Level Plugin CSS - Morris -->
    <link href="sb-admin-v2/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">

    <!-- SB Admin CSS - Include with every page -->
    <link href="sb-admin-v2/css/sb-admin.css" rel="stylesheet">
    
    <link href="css/back/style.css" rel="stylesheet">
    
<script>
// 判断输入框内容
function checkEmpty(id, name){
	var value = $("#"+id).val();
	if(value.length==0){
		alert(name+ "不能为空");
		$("#"+id)[0].focus();
		return false;
	}
	return true;
}
// 判断数字内容
function checkNumber(id, name){
	var value = $("#"+id).val();
	if(value.length==0){
		alert(name+ "不能为空");
		$("#"+id)[0].focus();
		return false;
	}
	if(isNaN(value)){
		alert(name+ "必须是数字");
		$("#"+id)[0].focus();
		return false;
	}
	
	return true;
}
// 判断整数
function checkInt(id, name){
	var value = $("#"+id).val();
	if(value.length==0){
		alert(name+ "不能为空");
		$("#"+id)[0].focus();
		return false;
	}
	if(parseInt(value)!=value){
		alert(name+ "必须是整数");
		$("#"+id)[0].focus();
		return false;
	}
	
	return true;
}

// 删除链接提醒
$(function(){
	$("a").click(function(){
		var deleteLink = $(this).attr("deleteLink");
		console.log(deleteLink);
		if("true"==deleteLink){
			var confirmDelete = confirm("确认要删除");
			if(confirmDelete)
				return true;
			return false;
			
		}
	});
})
</script>	
</head>
<body>

