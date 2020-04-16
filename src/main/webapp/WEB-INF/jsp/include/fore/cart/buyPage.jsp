<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>创建订单</title>	

<div class="container homeContent">
<div class="content ">

<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;cartbuy</li>
			</ul>
		</div>

<div class="buyPageDiv">
  <form id="buyForm" action="forecreateOrder" method="post">
  
	<div class="address">
	选择地址：<label class="errorMessage text-danger"></label>
	<select class="adselect form-control">
	<c:if test="${empty address }">
	<option adid="0">
		无地址
		</option>
	</c:if>
	<c:forEach items="${address}" var="ad">
		<option adid="${ad.id}">
		${ad.detailedArea}
		</option>
	</c:forEach>
	</select>
	
	<c:if test="${empty address }">
	<a href="foreNewAddress">还没有设置收货地址，去添加一个吧</a>
	</c:if>
	<c:if test="${!empty address}">
	<c:forEach items="${address}" var="ad">
		<div class="oneAddressDiv adselectItem" adid="${ad.id}">
			<div class="AddressContent">
			<p class="name">${ad.name}</p>
			<h5 class="simpleArea">${ad.simpleArea}</h5>
			<h5 class="detailedArea">${ad.detailedArea}</h5>
			<h5 class="postCode">${ad.postCode}</h5>
			<h5 class="phone">${ad.phone}</h5>
			</div>
	</div>
	</c:forEach>
	</c:if>
	</div>
	
	<div class="productList">
		<div class="productListTip">确认订单信息</div>
		
		
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
				<c:forEach items="${ois}" var="oi" varStatus="st" >
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
		<div class="orderItemSumDiv">
			<div class="pull-left">
				<span class="leaveMessageText">留言:</span>
				<span>
					<img class="leaveMessageImg" src="img/site/leaveMessage.png">
				</span>
				<span class="leaveMessageTextareaSpan">
					<textarea name="userMessage" class="leaveMessageTextarea"></textarea>
				</span>
			</div>
		
			<span class="pull-right">店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/>
		
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
	<div class="orderItemTotalSumDiv">
		<div class="pull-right"> 
			<span>实付款：</span>
			<span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
		</div>
	</div>
	
	<div class="submitOrderDiv">
			<input type="hidden" name="address" id="addressinput">
			<input type="hidden" name="post" id="postinput">
			<input type="hidden" name="receiver" id="receiverinput">
			<input type="hidden" name="mobile" id="mobileinput">
			<input type="hidden" name="orderPrice" id="orderPriceinput"  value="${total}">
			<button type="submit" class="submitOrderButton">提交订单</button>
	</div>
  </form>		
</div>
</div>
</div>

<script>
$(function(){
	
	$(".adselect").focus(function(){
		$("label.errorMessage").html("");
	});
	$("#buyForm").submit(function(){
		var isright=true;
		var name = $("div.adselectItem[adid="+adid+"] p.name").text();
		var phone = $("div.adselectItem[adid="+adid+"] h5.phone").text();
		var simpleArea = $("div.adselectItem[adid="+adid+"] h5.simpleArea").text();
		var postCode = $("div.adselectItem[adid="+adid+"] h5.postCode").text();
		var detailedArea = $("div.adselectItem[adid="+adid+"] h5.detailedArea").text();
		$("#addressinput").attr("value",simpleArea+" "+detailedArea);
		$("#postinput").attr("value",postCode);
		$("#mobileinput").attr("value",phone);
		$("#receiverinput").attr("value",name);
		
		if("0"==$(".adselect").find("option:selected").attr("adid")){
            $("label.errorMessage").html("请选择收货地址");
            isright= false;
        }
		if(isright){
			return true;
		}
			return false;
	});
	
	var adid = $(".adselect").find("option:selected").attr("adid");
	$("div.adselectItem[adid="+adid+"]").show();
	 $(".adselect").change(function(){
			var adid = $(this).find("option:selected").attr("adid");
			$("div.adselectItem").hide();
			$("div.adselectItem[adid="+adid+"]").show();
			$(".adIsSet").attr("value",adid);
		});
	
	
})
</script>
