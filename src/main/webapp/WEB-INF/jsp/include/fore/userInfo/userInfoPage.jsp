<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>个人中心</title>
<div class="container homeContent">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;userInfo</li>
			</ul>
		</div>
	<div class="userInfoDivtitle">
	<h2>我的账户</h2>
	</div>
	
	<div class="userInfoDiv">
	<a href="foreEditInfo"><h3>个人资料</h3></a>
	<h5 >您可以查看和修改您的个人资料(用户名，电话，邮箱...)以方便今后的购物</h5>
	
	<a href="forebought"><h3>订单详情</h3></a>
	<h5>您可以查看和操作您的交易订单</h5>
	
	<a href="foreEditAddress"><h3>收货地址</h3></a>
	<h5>您可以查看和操作您的收货地址(收件名，电话，详细地址...)以方便今后的购物</h5>
	
	<a href="foreEditPassword"><h3>修改密码</h3></a>
	<h5>您可以修改您的登录密码，以保证账号安全性</h5>
	</div>
	
</div>
</div>