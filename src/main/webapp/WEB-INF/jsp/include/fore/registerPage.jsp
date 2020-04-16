<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>


<script>
var namereg=/^[0-9]{8,15}$/;  //账号由8-15位数字组成
var passwordreg=/^[a-zA-Z0-9]{6,20}$/;  //密码由6-20位数字和字母混合组成
var phonereg=/^1[3456789]\d{9}$/;//电话号码格式
var emailreg=/^([A-Za-z0-9_\-\.\u4e00-\u9fa5])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,8})$/;

$(function(){
    	//用于判断账号密码是否符合规范
    	var isRight = false;
		$("#name").focus(function(){
                $(".nameInput label.errorMessage").html("");
        });
		$("#nickName").focus(function(){
            $(".nickNameInput label.errorMessage").html("");
    	});
		$("#phone").focus(function(){
            $(".phoneInput label.errorMessage").html("");
    	});
		$("#email").focus(function(){
            $(".emailInput label.errorMessage").html("");
    	});
		$("#password").focus(function(){
            $(".passwordInput label.errorMessage").html("");
	    });
		$("#repeatpassword").focus(function(){
            $(".repeatpasswordInput label.errorMessage").html("");
	    });
        $("#name").blur(function(){
         if(namereg.test($("#name").val())==false){
        		$(".nameInput label.errorMessage").html("账号需由8-15位数字组成");
        	}
        });
        $("#nickName").blur(function(){
        	if($("#nickName").val().length>20){
        		 $(".nickNameInput label.errorMessage").html("昵称长度不能超过20个字符");
        	}
    	});
		$("#phone").blur(function(){
			if(phonereg.test($("#phone").val())==false){
				  $(".phoneInput label.errorMessage").html("请输入正确的电话号码");
			}
    	});
		$("#email").blur(function(){
			if(emailreg.test($("#email").val())==false){
				 $(".emailInput label.errorMessage").html("请输入正确的邮箱");
			}
    	});
        $("#password").blur(function(){
        if(passwordreg.test($("#password").val())==false){
        		$(".passwordInput label.errorMessage").html("密码需由6-20位数字或字母组成");
        	}
        });
        $("#repeatpassword").blur(function(){
       if($("#password").val() !=$("#repeatpassword").val()){
                $(".repeatpasswordInput label.errorMessage").html("两次输入密码不一致");
                isRight = false;
            }
        });
        $("input#registerButtonTD").click(function(){
        	isRight = true;
        	var phone = $("#phone").val();
        	var nickName = $("#nickName").val();
        	var email = $("#email").val();
        	if(nickName.length==0){
        		nickName=$("#name").val()
        	}
        	if(!verifyCode.validate($("#code").val())){
        		$(".codeInput label.errorMessage").html("验证码错误");
        		isRight=false;
        	}
            if(namereg.test($("#name").val())==false){
        		$(".nameInput label.errorMessage").html("账号需由8-15位数字组成");
        		isRight=false;
        	}
           
            if($("#nickName").val().length>20){
       		 $(".nickNameInput label.errorMessage").html("昵称长度不能超过20个字符");
       		isRight=false;
       		}
            if(phonereg.test($("#phone").val())==false){
				  $(".phoneInput label.errorMessage").html("请输入正确的电话号码");
				  isRight=false;
			}
            if(emailreg.test($("#email").val())==false){
				 $(".emailInput label.errorMessage").html("请输入正确的邮箱");
				 isRight=false;
			}
            if(passwordreg.test($("#password").val())==false){
        		$(".passwordInput label.errorMessage").html("密码需由6-20位数字或字母组成");
        		isRight=false;
        	}
          	if($("#password").val() !=$("#repeatpassword").val()){
                $(".repeatpasswordInput label.errorMessage").html("两次密码不一致");
                isRight = false;
            }
            if(isRight==true){
            	$.post(
            	 "foreregister",
            	 {"userName":$("#name").val(),"password":$("#password").val(),
            		"phone": phone, "nickName":nickName,"email":email},
            	 function(result){
            		 if(result=="success")
            			 location.href="registerSuccessPage";
            		 else
            			 $(".nameInput label.errorMessage").html("该账号已被注册"); 
            	 }
            	);
            }
           

        });
        var verifyCode = new GVerify("testcode");
        $("#reflashCode").click(function(){
        	verifyCode.refresh();
        });
    })
</script>
<title>注册</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;Register</li>
			</ul>
		</div>
		<div class="coats">
			<h3 class="c-head">Register Here</h3>
			<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorp uspendisse a pellentesque.</p>
		</div>
		<div class="register">
	  	  <form> 
			 <div class="register-top-grid ">
				<h3>PERSONAL INFORMATION</h3>
				 <div class="nameInput">
					 <span>账号<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="name"  name="userName"type="text" placeholder="请输入8-15位数字作为账号" > 
				 </div>
				 
				  <div class="nickNameInput">
					 <span>昵称<label>.</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="nickName"  name="nickName"type="text"> 
				 </div>
				 <div class="phoneInput">
					 <span>联系电话<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="phone"  name="phone"type="text"> 
				 </div>
				 <div class="emailInput">
					 <span>邮箱<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="email"  name="email"type="text"> 
				 </div>
				 
				 
				 <div class="clearfix"> </div>
				   <a class="news-letter" href="#">
				   </a>
				 </div>
			     <div class="register-bottom-grid">
					    <h3>LOGIN INFORMATION</h3>
						 <div class="passwordInput">
							<span>Password<label>*</label >
							<label class="errorMessage text-danger"></label>
							</span>
							<input id="password" type="password"   placeholder="请输入6-20位数字或字母组成密码" > 
						 </div>
						 <div class="repeatpasswordInput">
							<span>Confirm<label>*</label>
							<label class="errorMessage text-danger"></label>
							</span>
							<input id="repeatpassword" type="password"   placeholder="请再次输入你的密码" > 
						 </div>
				 </div>
				<div class="register-top-grid">
				 	 <div class="codeInput">
							<span>请输入验证码<label>*</label>
							<label class="errorMessage text-danger"></label>
							</span>
							<input id="code" type="text"   placeholder="请输入验证码" > 
						 </div>
						 <div>
							<span>验证码<label></label></span>
							<p id="testcode" ></p>
							<span id="reflashCode">看不清</span>
						 </div>
						 </div>
			</form>
			<div class="clearfix"> </div>
			<div class="register-but">
				   <input id="registerButtonTD" type="submit" value="submit">
				   <div class="clearfix"> </div>
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