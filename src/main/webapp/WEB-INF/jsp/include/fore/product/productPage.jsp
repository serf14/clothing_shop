<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<title>${p.productName}</title>

<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;product</li>
			</ul>
		</div>	

<div class="productPageDiv">

	<%@include file="imgAndInfo.jsp" %>

	<%@include file="productReview.jsp" %>

	<%@include file="productDetail.jsp" %>
</div>
</div>
</div>