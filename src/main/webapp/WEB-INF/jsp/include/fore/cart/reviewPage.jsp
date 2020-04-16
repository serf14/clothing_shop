<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<title>评价</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;review</li>
			</ul>
		</div>	
<div class="reviewDiv">
<c:if test="${!empty finish}">
<div class="orderFinishDiv">
	<div class="orderFinishTextDiv">
		<span >恭喜您，已评价完该订单所有商品！</span>
	</div>
</div>
</c:if>
<c:forEach items="${o.orderItems}" var="oi">
		
		<div class="oneReview">
		<div class="reviewProductInfoImg"><img src="img/productSingle_middle/${oi.product.firstProductImage.productImageId}.jpg">
		<p class="text-info">${oi.product.productName}&nbsp;${oi.product.colorAndSize.colorValue}&nbsp;${oi.product.colorAndSize.sizeValue}</p>
		</div>
	
		<div class="makeReviewDiv">
		<form method="post" action="foredoreview">
			<table class="makeReviewTable">
				<tr>
					<td><textarea name="content" placeholder="其他买家，需要你的建议哦！"></textarea></td>
				<td>
				<div class="makeReviewButtonDiv">
				<input type="hidden" name="oid" value="${o.orderId}">
				<input type="hidden" name="pid" value="${oi.product.productId}">
				<input type="hidden" name="csid" value="${oi.product.colorAndSize.csid}">
				<button type="submit">提交评价</button>
			</div>
				</td>
				</tr>
				
			</table>
			
		</form>
		</div>	
		</div>
  </c:forEach>
</div>
</div>
</div>

