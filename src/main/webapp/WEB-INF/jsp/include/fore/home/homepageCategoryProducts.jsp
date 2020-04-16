<!-- 显示各个分类的产品 进行了2次遍历 -->
<!-- 1. 遍历所有的分类，取出每个分类对象 -->
<!-- 2. 遍历分类对象的products集合，取出每个产品，然后显示该产品的标题，图片，价格等信息 -->

<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}"/>
</c:if>

<div class="coats">
<c:forEach items="${cs}" var="c" varStatus="stc">
	<c:if test="${stc.count<=categorycount}">	
			<h3 class="c-head">${c.categoryName}</h3>
			<small><a href="forecategory?cid=${c.categoryId}">Show More</a></small>
			<div class="coat-row">
			<c:forEach items="${c.products}" var="p" varStatus="st">
					<c:if test="${st.count<=4}">
						<div class="coat-column">
							<a href="foreproduct?pid=${p.productId}">
							<div class="img-box">
								<img src="img/productSingle/${p.firstProductImage.productImageId}.jpg" class="img-responsive" alt="">
							</div>	
								<div class="prod-desc">
								<h4>
								<span class="productItemDesc">[热销]
								${fn:substring(p.productName, 0, 20)}
								</span>
								</h4>
								<small>￥<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/></small>
								</div>
							</a>
							
						</div>
					</c:if>
			</c:forEach>
					<div class="clearfix"></div>
			</div>
	</c:if>
</c:forEach>
</div>
		<div class="look">
			<h3>Check our lookbook</h3>
</div>
