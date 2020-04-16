<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>订单详情</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;cart</li>
			</ul>
		</div>	
<div class="boughtDiv">
	<div class="orderType">
		<div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
		<div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
		<div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
		<div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
		<div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
		<div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
	</div>
	<div style="clear:both"></div>
	<div class="orderListTitle">
		<table class="orderListTitleTable">
			<tr class="theadhidden">
				<td>商品详情</td>
				<td width="100px">单价</td>
				<td width="100px">数量</td>
				<td width="120px">实付款</td>
				<td width="100px">交易操作</td>
			</tr>
		</table>
	
	</div>
	
	<div class="orderListItem">
		<c:forEach items="${os}" var="o">
			<table class="orderListItemTable" orderStatus="${o.status}" oid="${o.orderId}">
				<tr class="orderListItemFirstTR">
					<td colspan="2">
					<b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b> 
					<span>订单号: ${o.orderCode} 
					</span>
					</td>
					<td colspan="2">
						<a  href="foreListOrderDetail?oid=${o.orderId}">
						详细信息
						</a>
						
					</td>
					<td colspan="2" class="orderItemDeleteTD">
					<c:if test="${o.status=='waitDelivery'||o.status=='waitConfirm'||o.status=='waitReview'}">
							<a class="refundLink" oid="${o.orderId}" href="#nowhere">申请退款</a>
					</c:if>
					<c:if test="${o.status=='waitPay'}">
							<a class="cancelLink" oid="${o.orderId}" href="#nowhere">取消订单</a>
					</c:if>
					<c:if test="${o.status=='finish'||o.status=='cancelOrder'||o.status=='completeRefund'}">
						<a class="deleteOrderLink" oid="${o.orderId}" href="#nowhere">
							<span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
						</a>						
					</c:if>
						
						
						
					</td>
				</tr>
				<c:forEach items="${o.orderItems}" var="oi" varStatus="st">
					<tr class="orderItemProductInfoPartTR" >
						<td class="orderItemProductInfoPartTD"><img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.productImageId}.jpg"></td>
						<td class="orderItemProductInfoPartTD">
							<div class="orderListItemProductLinkOutDiv">
								<a href="foreproduct?pid=${oi.product.productId}">${oi.product.productName}&nbsp;${oi.product.colorAndSize.colorValue}&nbsp;${oi.product.colorAndSize.sizeValue}</a>
							</div>
						</td>
						<td  class="orderItemProductInfoPartTD" width="100px">
						
							<div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></div>
							<div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></div>
		
		
						</td>
						<td valign="top"  class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
								<span class="orderListItemNumber">x${oi.number}</span>
							</td>
						<c:if test="${st.count==1}">
						 
							
							<td valign="top" rowspan="${fn:length(o.orderItems)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
								<div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.orderPrice}"/></div>
								<div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
							</td>
							<td valign="top" rowspan="${fn:length(o.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
								<c:if test="${o.status=='waitConfirm' }">
									<a href="foreconfirmPay?oid=${o.orderId}">
										<button class="orderListItemConfirm">确认收货</button>
									</a>
								</c:if>
								<c:if test="${o.status=='waitPay' }">
									<a href="forealipay?oid=${o.orderId}&total=${o.total}">
										<button class="orderListItemConfirm">付款</button>
									</a>								
								</c:if>
								<c:if test="${o.status=='cancelOrder' }">
									<span>订单已取消</span>
									
								</c:if>
								<c:if test="${o.status=='waitDelivery' }">
									<span>待发货</span>
									<p><a href="foreEditOrderAddress?oid=${o.orderId}">修改收货信息</a></p>
								</c:if>
								<c:if test="${o.status=='finish' }">
									<span>交易完成</span>
								</c:if>
								<c:if test="${o.status=='waitReview' }">
									<a href="forereview?oid=${o.orderId}">
										<button  class="orderListItemReview">评价</button>
									</a>
								</c:if>
								<c:if test="${o.status=='waitRefund' }">
									<span>退款中</span>
								</c:if>
								<c:if test="${o.status=='completeRefund' }">
									<span>退款完成</span>
								</c:if>
							</td>						
						</c:if>
					</tr>
				</c:forEach>		
				
			</table>
		</c:forEach>
		
	</div>
</div>
	
</div>
</div>

<script>
var deleteOrder = false;
var deleteOrderid = 0;
var cancelOrder = false;
var cancelOrderid = 0;
var refundOrder = false;
var refundOrderid = 0;


$(function(){
	$("a[orderStatus]").click(function(){
		var orderStatus = $(this).attr("orderStatus");
		var yin = $(this).attr("yin");
		if('all'==orderStatus){
			$("table[orderStatus]").show();	
		}
		else{
			$("table[orderStatus]").hide();
			$("table[orderStatus="+orderStatus+"]").show();			
		}
		
		$("div.orderType div").removeClass("selectedOrderType");
		$(this).parent("div").addClass("selectedOrderType");
	});
	$("a.refundLink").click(function(){
		$("#refundConfirmModal").modal("show");
		refundOrderid = $(this).attr("oid");
		refundOrder=false;
	});
	$("button.refundConfirmButton").click(function(){
		refundOrder = true;
		var page="foreRefund?oid="+refundOrderid;
		$("#refundConfirmModal").modal('hide');
		if(refundOrder)
			$.post(
					page,
					function(result){
						if(result=="success"){
							
							location.href="";
							alert("申请退款成功！");
						}
					}
					);
	});	
	
	$("a.cancelLink").click(function(){
		cancelOrder=false;
		cancelOrderid =$(this).attr("oid");
		$("#cancelConfirmModal").modal("show");
	});
	
	$("button.cancelConfirmButton").click(function(){
		cancelOrder = true;
		var page="foreCancel?oid="+cancelOrderid;
		$("#cancelConfirmModal").modal('hide');
		if(cancelOrder)
			$.post(
					page,
					function(result){
						if(result=="success"){
							
							location.href="";
							alert("取消订单成功！");
						}
					}
					);
	});	
	
	$("a.deleteOrderLink").click(function(){
		deleteOrderid = $(this).attr("oid");
		deleteOrder = false;
		$("#deleteConfirmModal").modal("show");
	});
	
	$("button.deleteConfirmButton").click(function(){
		deleteOrder = true;
		$("#deleteConfirmModal").modal('hide');
	});	
	
	$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
		if(deleteOrder){
			var page="foredeleteOrder";
			$.post(
				    page,
				    {"oid":deleteOrderid},
				    function(result){
						if("success"==result){
							$("table.orderListItemTable[oid="+deleteOrderid+"]").remove();
						}
						else{
							location.href="loginPage";
						}
				    }
				);
			
		}
	});		
	
	


});

</script>
