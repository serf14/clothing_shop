<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>


<title>编辑个人信息</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;editInfo</li>
			</ul>
		</div>
		<div class="coats">
			<h3 class="c-head">Edit Here</h3>
			<p>Lorem ipsum dolor sit amet enim. Etiam ullamcorp uspendisse a pellentesque.</p>
		</div>
		<div class="register">
	  	  <form> 
				 <div class="register-top-grid ">
				<h3>PERSONAL INFORMATION</h3>
				 <div class="nickNameInput">
					 <span>昵称<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="nickName" type="text"  value="${u.nickName }"> 
				 </div>
				 
				  <div>
					 <span>地区<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input type="text"  value="中国大陆"> 
				 </div>
				 <div class="phoneInput">
					 <span>电话号码<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="phone"type="text" value="${u.phone}" > 
				 </div>
				 <div class="emailInput">
					 <span>邮箱<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="email" type="text"  value="${u.email }"> 
				 </div>
				 <div class="clearfix"> </div>
				   <a class="news-letter" href="#">
				   </a>
				 </div>
			</form>
			<div class="clearfix"> </div>
			<div class="register-but">
				   <input id="registerButtonTD" type="submit" value="Update">
				   <div class="clearfix"> </div>
			</div>
	   </div>
	</div>
</div>


<script>
var namereg=/^[0-9]{8,15}$/;  //账号由8-15位数字组成
var passwordreg=/^[a-zA-Z0-9]{6,20}$/;  //密码由6-20位数字和字母混合组成
var phonereg=/^1[3456789]\d{9}$/;//电话号码格式
var emailreg=/^([A-Za-z0-9_\-\.\u4e00-\u9fa5])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,8})$/;

    $(function(){
    	var isRight = false;
		$("#phone").focus(function(){
            $(".phoneInput label.errorMessage").html("");
	    });
		$("#email").focus(function(){
            $(".emailInput label.errorMessage").html("");
	    });
		$("#nickName").focus(function(){
            $(".nickNameInput label.errorMessage").html("");
	    });
	    $("#nickName").blur(function(){
        	if($("#nickName").val().length>20||$("#nickName").val().length<2){
        		 $(".nickNameInput label.errorMessage").html("昵称长度应在2-20个字符");
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
        $(".register-but").click(function(){
        	isRight = true;
        	var phone = $("#phone").val();
        	var nickName = $("#nickName").val();
        	var email = $("#email").val();
            if($("#nickName").val().length>20||$("#nickName").val().length<2){
          		 $(".nickNameInput label.errorMessage").html("昵称长度应在2-20个字符");
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
            if(isRight==true){
            	$.post(
            	 "foreUpdateUserInfo",
            	 {"nickName":nickName,"phone":phone,"email":email},
            	 function(result){
            		 if(result=="success")
            			 location.href="editPasswordSuccessPage";
            		 else
            			 $(".phoneInput label.errorMessage").html("更新信息失败"); 
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
