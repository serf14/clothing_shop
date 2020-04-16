<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>确认收货</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;confirmPay</li>
			</ul>
		</div>	
<div class="confirmPayPageDiv">
	<div class="confirmPayImageDiv">
		<img src="img/site/comformPayFlow.png">
	</div>
	<div class="confirmPayOrderInfoDiv">
		<div class="confirmPayOrderInfoText">我已收到货，同意支付宝付款</div>
	</div>
	<div class="confirmPayOrderItemDiv">
		<div class="confirmPayOrderItemText">订单信息</div>
		<table class="confirmPayOrderItemTable">
			<thead class="theadhidden">
				<th colspan="2">宝贝</th>		
				<th width="120px">单价</th>		
				<th width="120px">数量</th>		
				<th width="120px">商品总价 </th>		
				<th width="120px">运费</th>		
			</thead>
			<c:forEach items="${o.orderItems}" var="oi">
				<tr>
					<td><img width="50px" src="img/productSingle_middle/${oi.product.firstProductImage.productImageId}.jpg"></td>
					<td class="confirmPayOrderItemProductLink">
						<a href="#nowhere">${oi.product.productName}&nbsp;${oi.product.colorAndSize.colorValue}&nbsp;${oi.product.colorAndSize.sizeValue}</a>
					</td>
					<td>￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></td>
					<td>x${oi.number}</td>
					<td><span class="conformPayProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></span></td>
					<td><span>快递  0.00 </span></td>
				</tr>
			</c:forEach>
		</table>
		
		<div class="confirmPayOrderItemText pull-right">
			实付款： <span class="confirmPayOrderItemSumPrice">￥<fmt:formatNumber type="number" value="${o.orderPrice}" minFractionDigits="2"/></span>
		</div>
		
		
	</div>
	<div class="confirmPayOrderDetailDiv">
		
		<table class="confirmPayOrderDetailTable">
			<tr>
				<td>订单编号：</td>
				<td>${o.orderCode} </td>
			</tr>
			<tr>
				<td>收货信息： </td>
				<td>${o.address}，${o.receiver}， ${o.mobile}，${o.post} </td>
			</tr>
			<tr>
				<td>成交时间：</td>
				<td><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</table>
		
	</div>
	<div class="confirmPayButtonDiv">
		<div class="confirmPayWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
		<a href="foreorderConfirmed?oid=${o.orderId}"><button class="confirmPayButton">确认支付</button></a>
	</div>
</div>
	</div>
</div>