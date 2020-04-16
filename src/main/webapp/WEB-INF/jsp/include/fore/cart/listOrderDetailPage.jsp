<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>订单详情</title>	
<div class="container homeContent">
<div class="content ">

<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;OrderDetail</li>
			</ul>
		</div>

<div class="buyPageDiv">
  <form id="buyForm" action="forecreateOrder" method="post">
  <h2>地址信息</h2>
		<div class="oneAddressDiv ">
			<div class="AddressContent">
			<p class="name">收件人：${o.receiver}</p>
			<h5 class="detailedArea">收货地址：${o.address}</h5>
			<h5 class="postCode">邮政编码：${o.post }</h5>
			<h5 class="phone">联系电话：${o.mobile }</h5>
			<h5>实付款：<span class="">
			￥<fmt:formatNumber type="number" value="${o.orderPrice}" minFractionDigits="2"/></span>
			</h5>
			</div>
	</div>
	<div class="productList">
		<div class="productListTip"><h2>订单信息</h2></div>
		
		
		<table class="productListTable">
			<thead class="">
				<tr class=" lefttr">
					<th colspan="2" class=" productListTableFirstColumn">
						<a class="marketLink" href="#nowhere">商品</a>
					</th>
					<th>单价</th>
					<th >数量</th>
					<th >小计</th>
				</tr>
				<tr class="rowborder">
					<td  colspan="2" ></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</thead>
			<tbody class="productListTableTbody">
				<c:forEach items="${o.orderItems}" var="oi" varStatus="st" >
					<tr class="orderItemTR">
						<td class="orderItemFirstTD"><img class="orderItemImg" src="img/productSingle_middle/${oi.product.firstProductImage.productImageId}.jpg"></td>
						<td class="orderItemProductInfo">
						<a  href="foreproduct?pid=${oi.product.productId}" class="orderItemProductLink">
							${oi.product.productName}&nbsp;${oi.product.colorAndSize.colorValue}&nbsp;${oi.product.colorAndSize.sizeValue}
						</a>
						</td>
						<td>
						
						<span class="orderItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></span>
						</td>
						<td>
						<span class="orderItemProductNumber">x${oi.number}</span>
						</td>
						<td><span class="orderItemUnitSum">
						￥<fmt:formatNumber type="number" value="${oi.number*oi.product.promotePrice}" minFractionDigits="2"/>
						</span></td>
						
						


						
					</tr>
				</c:forEach>				
				
			</tbody>
			
		</table>
			<div class="pull-left">
				<span class="leaveMessageText">留言:</span>
				<span class="leaveMessageTextareaSpan">
					${o.userMessage }
				</span>
			</div>
		

				
	
	</div>
	<div  class="pull-right">
	<label class="orderItemDeliveryLabel">
				<input type="radio" value="" checked="checked">
				普通配送
	</label>
	<select class="orderItemDeliverySelect" class="form-control">
		<option>快递 免邮费</option>
	</select>
	</div>

  </form>		
</div>
</div>
</div>