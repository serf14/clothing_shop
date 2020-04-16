<!--  进行了三层遍历 -->
<!-- 1. 先取出每个分类 -->
<!-- 2. 然后取出每个分类的productsByRow集合 -->
<!-- 3. 根据productsByRow集合，取出每个产品，把产品的subTitle信息里的第一个单词取出来显示。 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
// 这个是用于随机挑选一个产品作为推荐产品，来进行高亮显示。 
// 严格的说，应该是后台设置那个产品是推荐产品，不过这里偷懒了，直接在前端按照20%的概率，随机挑选了一个产品。
$(function(){
	$("div.productsAsideCategorys div.row a").each(function(){
		var v = Math.round(Math.random() *6);
		if(v == 1)
			$(this).css("color","#87CEFA");
	});
});

</script>
