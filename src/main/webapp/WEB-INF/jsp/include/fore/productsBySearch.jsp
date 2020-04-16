<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<title>搜索结果</title>
<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}"/>
</c:if>
	
<div class="content">
<div class="coats">
			<div class="coat-row">
			<c:forEach items="${ps}" var="p" varStatus="st">
			<c:if test="${st.count<=categorycount}">	
						<div class="coat-column">
							<a href="foreproduct?pid=${p.productId}">
							<div class="img-box">
								<img src="img/productSingle/${p.firstProductImage.productImageId}.jpg" class="img-responsive" alt="">
							</div>	
								<div class="prod-desc">
								<h4>
								<span class="productItemDesc">[热销]
<%-- 								${fn:substring(p.productName, 0, 20)} --%>
								${p.productName }
								</span>
								</h4>
								<small>￥<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/></small>
								</div>
							</a>
					<div class=" ">
					<span class="monthDeal ">月成交 <span class="">${p.saleCount}笔</span></span>
					<span class="productReview">评价<span class="">${p.reviewCount}</span></span>
				</div>	
						</div>
					</c:if>
					
			</c:forEach>
				<div class="clearfix"></div>	
			</div>
				<c:if test="${empty ps}">
	<h2>没有满足条件的产品</h2>
		</c:if>
</div>
</div>


