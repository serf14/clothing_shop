<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>付款成功</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;PAY</li>
			</ul>
		</div>		
<div class="payedDiv">
	<div class="payedTextDiv">
		<span>恭喜，您已成功付款！</span> 
		
	</div>
	<div class="payedAddressInfo">
		<ul>
			
			<li>收件人：${o.receiver}</li>
			<li>联系电话：${o.mobile }</li>
			<li>邮政编码：${o.post }</li>
			<li>收货地址：${o.address} </li>
			<li>实付款：<span class="">
			￥<fmt:formatNumber type="number" value="${o.orderPrice}" minFractionDigits="2"/>
			</li>
			<li>预计明日12:00前送达	</li>
		</ul>
				
		<div class="paedCheckLinkDiv">
			<a class="payedCheckLink" href="forebought">查看已买到的商品</a>
			<a class="payedCheckLink" href="forebought">查看交易详情 </a>
		</div>
			
	</div>
	
	<div class="payedSeperateLine">
	</div>
	
	<div class="warningDiv">
		<img src="img/site/warning.png">
		<b>安全提醒：</b>下单后，用QQ给您发送链接办理退款的都是骗子！本店不存在系统升级，订单异常等问题，谨防假冒客服电话诈骗！
	</div>
	</div>

	

</div>
	

</div>