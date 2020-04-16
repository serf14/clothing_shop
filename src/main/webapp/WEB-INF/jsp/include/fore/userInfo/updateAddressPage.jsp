<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<title>修改收货地址</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li>
				<li class="act">&nbsp;updateAddress</li>
			</ul>
		</div>
		
		<h2>修改收货地址</h2>
		<div class="register">
	  	  <form> 
				 <div class="register-top-grid ">
				<h3>PERSONAL INFORMATION</h3>
				 <div class="nameInput">
					 <span>收件人<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="nameInput" type="text"  value="${ad.name}" placeholder="请输入收件人名称" > 
				 </div>
				 <div class="phoneInput">
					 <span>电话号码<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="phoneInput" type="text" value="${ad.phone}" > 
				 </div>
				
				 <div class="porandcity">
				 <div class="proSInput">
					 <span>省<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <select id="proS" class="form-control" onchange="loadCity()">
					<option value="0">请选择</option>
					</select>
				 </div>
				 <div class="citySInput">
					 <span>市<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					<select id="cityS" class="form-control"onchange="loadCounty()">
					<option value="0">请选择</option>
					</select>
				 </div></div>
				 <div class="countryandtown">
				  <div class="countrySInput">
					 <span>县<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					<select id="countryS" class="form-control"onchange="loadTown()">
					<option value="0">请选择</option>
					</select>
				 </div>
				  <div class="townSInput">
					 <span>镇<label>.</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					<select id="townS" class="form-control">
						<option value="0">请选择</option>
					</select>
				 </div></div>
				 <div class="detailAddressInput">
					 <span>详细地址<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input id="detailAddressInput" type="text"  value="${ad.detailedArea}"> 
				 </div>
				   <div class="postCodeInput">
					 <span>邮政编码<label>*</label>
					 <label class="errorMessage text-danger"></label>
					 </span>
					 <input  id="postCodeInput" type="text"  value="${ad.postCode}"> 
				 </div>
				 
				 
				 
				 <div class="clearfix"> </div>
				 </div>
			</form>
			<div class="clearfix"> </div>
			<div class="register-but">
					<input type="hidden" id="adid" value="${ad.id}">
				   <input id="registerButtonTD" type="submit" value="更新">
				   <div class="clearfix"> </div>
			</div>
	   </div>

		
		
		
		
		
		
	</div>	
</div>	

		<script src="js/data/proCityCountry.js"></script>
		<script async src="js/data/town.js"></script>
		<script type="text/javascript">
			var proS=document.getElementById("proS"),cityS=document.getElementById("cityS"),countryS=document.getElementById("countryS"),townS=document.getElementById("townS")
			function loadProvince(){
				var tempFragment = document.createDocumentFragment();
				for(var i=0;i<proData_.length;i++){
					var option=document.createElement("option");
					option.setAttribute("value",proData_[i].pk);
					option.innerHTML=proData_[i].pv;
					tempFragment.appendChild(option);
				}
				//使用dom碎片，减少对dom的重复操作
				proS.appendChild(tempFragment);
			}
			function loadCity(){
				if(proS.value==0){
					return;
				}else{
					cityS.innerHTML="<option value='0'>请选择</option>";
					countryS.innerHTML="<option value='0'>请选择</option>";
					townS.innerHTML="<option value='0'>请选择</option>";
					var hasFound=false;
					var tempFragment = document.createDocumentFragment();
					for(var i=0;i<cityData_.length;i++){
						if(proS.value==cityData_[i].pk){
							hasFound=true;
							var option=document.createElement("option");
							option.setAttribute("value",cityData_[i].ck);
							option.innerHTML=cityData_[i].cv;
							tempFragment.appendChild(option);
							
						}else{
							//需要查找的数据都是放一块的，如果匹配过，又出现不匹配，那么之后数据肯定都是不匹配的。可以pass掉，减少循环次数
							if(hasFound){
								break;
							}
						}
					}
					cityS.appendChild(tempFragment);
				}
				
			}
			function loadCounty(){
				if(cityS.value==0){
					return;
				}else{
					countryS.innerHTML="<option value='0'>请选择</option>";
					townS.innerHTML="<option value='0'>请选择</option>";
					var hasFound=false;
					var tempFragment = document.createDocumentFragment();
					for(var i=0;i<countryData_.length;i++){
						if(cityS.value==countryData_[i].ck){
							hasFound=true;
							var option=document.createElement("option");
							option.setAttribute("value",countryData_[i].cyk);
							option.innerHTML=countryData_[i].cyv;
							tempFragment.appendChild(option);
							
						}else{
							if(hasFound){
								break;
							}
						}
					}
					countryS.appendChild(tempFragment);
				}
			}

			function loadTown(){
				if(countryS.value==0){
					return;
				}else{
					townS.innerHTML="<option value='0'>请选择</option>";
					var hasFound=false;
					var tempFragment = document.createDocumentFragment();
					for(var i=0;i<townData_.length;i++){
						if(countryS.value==townData_[i].cyk){
							hasFound=true;
							var option=document.createElement("option");
							option.setAttribute("value",townData_[i].tk);
							option.innerHTML=townData_[i].tv;
							tempFragment.appendChild(option);
							
						}else{
							if(hasFound){
								break;
							}
						}
					}
					townS.appendChild(tempFragment);
				}
			}
			loadProvince();

		</script>
		
		
<script>
$(function(){
	var isRight=true;
	var postReg= /^[1-9]\d{5}$/;//邮政编码格式
	var reg=/^1[3456789]\d{9}$/;//电话号码格式
	$("#nameInput").focus(function(){
        $(".nameInput label.errorMessage").html("");
	});
    $("#nameInput").blur(function(){
    	if(2>$("#nameInput").val().length||15<$("#nameInput").val().length){
            $(".nameInput label.errorMessage").html("收件人名称长度应为2-15个字符");
        }
    });
    $("#phoneInput").focus(function(){
        $(".phoneInput label.errorMessage").html("");
	});
	$("#phoneInput").blur(function(){
    	 if(reg.test($("#phoneInput").val())==false)
   		 {
   			$(".phoneInput label.errorMessage").html("请输入正确的手机号码");
   		 }
    });
    $("#detailAddressInput").focus(function(){
        $(".detailAddressInput label.errorMessage").html("");
	});
    $("#detailAddressInput").blur(function(){
    	if(5>$("#detailAddressInput").val().length||120<$("#detailAddressInput").val().length){
    		$(".detailAddressInput label.errorMessage").html("详细地址长度应为5-120个字符");
        }
    });
    $("#postCodeInput").focus(function(){
        $(".postCodeInput label.errorMessage").html("");
        
	});
    $("#postCodeInput").blur(function(){
    	if(postReg.test($("#postCodeInput").val())==false){
            $(".postCodeInput label.errorMessage").html("邮政编码格式不正确");
        }
    });

    
    
    
    $("#proS").focus(function(){
        $(".proSInput label.errorMessage").html("");
	});
    $("#cityS").focus(function(){
        $(".citySInput label.errorMessage").html("");
	});
    $("#countryS").focus(function(){
        $(".countrySInput label.errorMessage").html("");
	});
    
    $("#proS").blur(function(){
    	if($("#proS").find("option:selected").val()=="0")
        $(".proSInput label.errorMessage").html("必选");
	});
    $("#cityS").blur(function(){
    	if($("#cityS").find("option:selected").val()=="0")
        $(".citySInput label.errorMessage").html("必选");
	});
    $("#countryS").blur(function(){
    	if($("#countryS").find("option:selected").val()=="0")
        $(".countrySInput label.errorMessage").html("必选");
	});
    $("input#registerButtonTD").click(function(){
    	var proS=$("#proS").find("option:selected").text();
    	var cityS=$("#cityS").find("option:selected").text();
    	var countryS=$("#countryS").find("option:selected").text();
    	var townS=$("#townS").find("option:selected").text();
    	var townSvalue=$("#townS").find("option:selected").val();
    	var adid = $("#adid").val();
    	var simpleArea;
    	if(townSvalue=="0"){
    		simpleArea=proS+cityS+countryS;
    	}
    	else{
    		simpleArea=proS+cityS+countryS+townS;
    	}
    	isRight = true;
    	if(2>$("#nameInput").val().length||15<$("#nameInput").val().length){
            $(".nameInput label.errorMessage").html("收件人名称长度应为2-15个字符");
            isRight = false;
        }
    	 if(reg.test($("#phoneInput").val())==false)
   		 {
   			$(".phoneInput label.errorMessage").html("请输入正确的手机号码");
   			isRight = false;
   		 }
    	 if(5>$("#detailAddressInput").val().length||
     			120<$("#detailAddressInput").val().length){
             $(".detailAddressInput label.errorMessage").html("详细地址长度应为2-150个字符");
             isRight = false;
         }
    	 if(postReg.test($("#postCodeInput").val())==false){
             $(".postCodeInput label.errorMessage").html("邮政编码格式不正确");
             isRight = false;
         }
    	 if($("#proS").find("option:selected").val()=="0"){
    		 $(".proSInput label.errorMessage").html("必选");
    		 isRight = false;
    	 }
    	 if($("#cityS").find("option:selected").val()=="0"){
    		 $(".citySInput label.errorMessage").html("必选");
    		 isRight = false;
    	 }
    	 if($("#countryS").find("option:selected").val()=="0"){
    		 $(".countrySInput label.errorMessage").html("必选");
    		 isRight = false;
    	 }
        if(isRight==true){
        	$.post(
        	 "foreUpdateOneAddress",
        	 {"id":adid,"name":$("#nameInput").val(),"phone":$("#phoneInput").val(),
        	"postCode":$("#postCodeInput").val(),"simpleArea":simpleArea,
        	"detailedArea":$("#detailAddressInput").val() },
        	 function(result){
        		 if(result=="success")
        			 location.href="foreEditAddress";
        		 else
        			 $(".nameInput label.errorMessage").html("修改地址失败"); 
        	 }
        	);
        }
       

    });
    
})

</script>	
	
			