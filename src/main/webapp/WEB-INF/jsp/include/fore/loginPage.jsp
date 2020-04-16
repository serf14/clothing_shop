<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

<title>登录</title>
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
			<h3 class="c-head">Login</h3>
			<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorp uspendisse a pellentesque.</p>
		</div>
		<div class="contact-box login-box">
			<div class="form">
				<small>User Name</small>
				<div class="text">
					<input id="name" name="userName" placeholder="请输入账号" type="text">
				</div>
			</div>
			<div class="form">
				<small>Password</small>
				<div class="text">
					<input id="password" name="password" type="password" placeholder="请输入密码" type="text">
				</div>
			</div>
			<div class="text">
				<input  id="submitButton" type="submit" value="Login" />
			</div>
			<div class="text">
				<a href="ForgetPassword">Forgot Password</a>
			</div>
		</div>
		<div class="coats login-bot">
			<h3 class="c-head">For New People</h3>
			<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorp uspendisse a pellentesque.</p>
			<div class="reg">
				<a href="registerPage">免费注册</a>
			</div>
		</div>
		<div class="look">
			<h3>You May Also Like</h3>
		</div>
		<!-- Partners Starts Here --->
		<div class="partner">
				<ul id="flexiselDemo3">
				   <li><img src="img/images/ss1.jpg" class="img-responsive" alt=""/></li>
				   <li><img src="img/images/ss2.jpg" class="img-responsive" alt=""/></li>
				   <li><img src="img/images/ss3.jpg" class="img-responsive" alt=""/></li>
				   <li><img src="img/images/ss4.jpg" class="img-responsive" alt=""/></li>
				   <li><img src="img/images/ss5.png" class="img-responsive" alt=""/></li>
				</ul>
				
		</div>
	</div>
</div>

<script>
    $(function(){

  

        $("#submitButton").click(function(){
        	 var name = $("#name").val();
             var password = $("#password").val();
             
             if(0==name.length&&0==password.length){
                 $("p.errorMessage").html("账号密码不能为空");
                 $("div.loginErrorDiv").show();           
                 return false;
             }
             else  if(0==name.length&&0!=password.length){
                 $("p.errorMessage").html("请输入账号");
                 $("div.loginErrorDiv").show();           
                 return false;
             }
             else  if(0!=name.length&&0==password.length){
                 $("p.errorMessage").html("请输入密码");
                 $("div.loginErrorDiv").show();           
                 return false;
             }
              
             var page = "foreloginAjax";
             if(0!=name.length&&0!=password.length)
             $.post(
                     page,
                     {"userName":name,"password":password},
                     function(result){
                         if("success"==result){
                             location.href="forehome";
                         }
                         else if("nameError"==result){
                             $("p.errorMessage").html("账号不存在");
                             $("div.loginErrorDiv").show();                       
                         }
                         else if("passwordError"==result){
                             $("p.errorMessage").html("密码错误");
                             $("div.loginErrorDiv").show();                       
                         }
                     }
             );          
              
             return true;
        });

        $(".form input").keyup(function(){
            $("div.loginErrorDiv").hide();
        });



        var left = window.innerWidth/2+162;
        $("div.loginSmallDiv").css("left",left);
    })
</script>

