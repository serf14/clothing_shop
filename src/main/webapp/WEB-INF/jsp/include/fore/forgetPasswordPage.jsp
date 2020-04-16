<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>


<title>找回密码</title>
<div class="container">
<div class="content">
		<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;Login</li>
			</ul>
		</div>
		<div class="coats "  style="height:1em"> 
			<div class=" loginErrorDiv" >
				<p class="errorMessage"></p>
			</div>
		</div>
		<div class="coats">
			<h3 class="c-head">Find Password</h3>
		</div>
		<div class="contact-box login-box">
			<div class="form">
				<small>phone</small>
				<div class="text">
					<input id="phone" name="phone" placeholder="请输入账号绑定的号码" type="text">
				</div>
			</div>
			<div class="form">
				<small>Verification Code</small>
				<div class="text">
					<input id="code" name="code" type="text" placeholder="请输入验证码" type="text">
				</div>
			</div>
			<div class="form">
				<small><a href="#">验证码已发送 56s</a></small>
			</div>
			<div class="text">
				<input  id="submitButton" type="submit" value="submit" />
			</div>
		</div>
	</div>
</div>
