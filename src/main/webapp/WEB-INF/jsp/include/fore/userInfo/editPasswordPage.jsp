<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

<title>修改密码</title>

<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;editPassword</li>
			</ul>
		</div>
		<div class="coats">
			<h3 class="c-head">Edit Here</h3>
			<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorp uspendisse a pellentesque.</p>
		</div>
		<div class="register">
	  	  <form> 
			     <div class="register-bottom-grid">
					    <h3>LOGIN INFORMATION</h3>
					     <div class="oldPasswordInput">
							<span>OldPassword<label>*</label >
							<label class="errorMessage text-danger"></label>
							</span>
							<input id="oldPassword" type="password"   placeholder="请输入你的原始密码" > 
						 </div>
						 <div class="passwordInput">
							<span>NewPassword<label>*</label >
							<label class="errorMessage text-danger"></label>
							</span>
							<input id="password" type="password"   placeholder="请输入你的新密码" > 
						 </div>
						 <div class="repeatpasswordInput">
							<span>Confirm<label>*</label>
							<label class="errorMessage text-danger"></label>
							</span>
							<input id="repeatpassword" type="password"   placeholder="请再次输入你的新密码" > 
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
	</div>
</div>

<script>
var namereg=/^[0-9]{8,15}$/;  //账号由8-15位数字组成
var passwordreg=/^[a-zA-Z0-9]{6,20}$/;  //密码由6-20位数字和字母混合组成
    $(function(){
    	//用于判断账号密码是否符合规范
    	var isRight = false;
		$("#name").focus(function(){
                $(".nameInput label.errorMessage").html("");
        });
		$("#password").focus(function(){
            $(".passwordInput label.errorMessage").html("");
	    });
		$("#repeatpassword").focus(function(){
            $(".repeatpasswordInput label.errorMessage").html("");
	    });
        $("#password").blur(function(){
        	if(0==$("#password").val().length){
                $(".passwordInput label.errorMessage").html("请输入新密码");
                isRight = false;
            }
        	else if(passwordreg.test($("#password").val())==false){
        		$(".passwordInput label.errorMessage").html("密码需由6-20位数字或字母组成");
        	}
        });
        $("#oldPassword").blur(function(){
        	if(0==$("#oldPassword").val().length){
                $(".oldPasswordInput label.errorMessage").html("请输入原始密码");
                isRight = false;
            }
        	else if(passwordreg.test($("#oldPassword").val())==false){
        		$(".oldPasswordInput label.errorMessage").html("密码需由6-20位数字或字母组成");
        	}
        });
        $("#repeatpassword").blur(function(){
        	if(0==$("#repeatpassword").val().length){
                $(".repeatpasswordInput label.errorMessage").html("请再次输入新密码");
                isRight = false;
            }
        	else if($("#password").val() !=$("#repeatpassword").val()){
                $(".repeatpasswordInput label.errorMessage").html("两次输入的新密码不一致");
                isRight = false;
            }
        });
        $(".register-but").click(function(){
        	isRight = true;
        	if(!verifyCode.validate($("#code").val())){
        		$(".codeInput label.errorMessage").html("验证码错误");
        		isRight=false;
        	}
        	if(0==$("#oldPassword").val().length){
             	 $(".oldPasswordInput label.errorMessage").html("请输入原始密码");
             	 isRight = false;
             }
        	 else if(passwordreg.test($("#oldPassword").val())==false){
         		$(".oldPasswordInput label.errorMessage").html("密码需由6-20位数字或字母组成");
         	}
        	
            if(0==$("#password").val().length){
            	 $(".passwordInput label.errorMessage").html("请输入新密码");
            	 isRight = false;
            }
            else if(passwordreg.test($("#password").val())==false){
        		$(".passwordInput label.errorMessage").html("密码需由6-20位数字或字母组成");
        	}
            
            
            if(0==$("#repeatpassword").val().length){
            	  $(".repeatpasswordInput label.errorMessage").html("请再次输入新密码");
            	  isRight = false;
            }
            else if($("#password").val() !=$("#repeatpassword").val()){
                $(".repeatpasswordInput label.errorMessage").html("两次输入的新密码不一致");
                isRight = false;
            }
            if(isRight==true){
            	$.post(
            	 "foreUpdatePassword",
            	 {"oldPassword":$("#oldPassword").val(),"password":$("#password").val()},
            	 function(result){
            		 if(result=="success")
            			 location.href="editPasswordSuccessPage";
            		 else
            			 $(".oldPasswordInput label.errorMessage").html("原始密码错误"); 
            	 }
            	);
            }
           

        });
        $(".registerButtonTD").submit(function(){
        	alert("12");
        });
        var verifyCode = new GVerify("testcode");
        $("#reflashCode").click(function(){
        	verifyCode.refresh();
        });
    })
</script>

