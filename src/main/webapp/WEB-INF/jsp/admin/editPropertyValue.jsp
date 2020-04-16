<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
 
<title>编辑产品属性值</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">编辑产品属性值</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="workingArea">
    <ol class="breadcrumb">
     <li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
	<li><a href="admin_product_list?cid=${c.categoryId}">${c.categoryName}-产品列表</a></li>
	<li class="active">${p.productName}-编辑属性值</li>
    </ol>
     <span class="text-info">提示：输入属性值后按回车键（Enter）提交</span>
    <div class="editPVDiv">
        <c:forEach items="${pvs}" var="pv">
            <div class="eachPV">
                <span class="pvName" >${pv.property.propertyName}</span>
                <input class="pvValue" pvName="${pv.property.propertyName}" pvid="${pv.propertyValueId}" type="text" value="${pv.value}">
            </div>
        </c:forEach>
    <div style="clear:both"></div> 
    </div>
     
</div> 
<script>
$(function() {
    $("input.pvValue").keyup(function(event){
        var value = $(this).val();
        var name = $(this).attr("pvName")
        var page = "admin_propertyValue_update";
        var pvid = $(this).attr("pvid");
		if(event.which==13||event.which==108)
        $.post(
                page,
                {"value":value,"propertyValueId":pvid},
                function(result){
                    if("success"==result){
                    	$(".alert").html("属性："+name+"设置成功").addClass("alert-success").show().delay(1500).fadeOut();
                    }
                    else
                    	$(".alert").html("属性："+name+"设置失败").addClass("alert-danger").show().delay(1500).fadeOut();
                }
            );     
    });
});
</script>
<%@include file="../include/admin/adminFooter.jsp"%>