<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>分类：${c.categoryName}</title>	
<div class="container homeContent">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;category</li>
			</ul>
		</div>
<div id="category">
	<div class="categoryPageDiv">
		<%@include file="sortBar.jsp"%>
		<%@include file="productsByCategory.jsp"%>
	</div>
	</div>

</div>
</div>