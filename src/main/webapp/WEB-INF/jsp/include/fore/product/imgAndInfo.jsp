<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>

	    <div class="imgInimgAndInfo">
	    <div class="bigImageDiv">
         <img src="img/productSingle/${p.firstProductImage.productImageId}.jpg" class="bigImg">
        <div class="magnifier"></div>

        </div>
           <div class="moreBig">
          <img src="img/productSingle/${p.firstProductImage.productImageId}.jpg" class="morebigImg">
        </div>
        <div class="smallImageDiv">
         <c:forEach items="${colors}" var="color">
         <div class="imgByColor" color="${color}">
             <c:forEach items="${p.productSingleImages}" var="pi">
             <c:if test="${pi.type==color}">
                 <img src="img/productSingle_small/${pi.productImageId}.jpg" bigImageURL="img/productSingle/${pi.productImageId}.jpg" class="smallImage">
            </c:if>
            </c:forEach>
        </div>
        </c:forEach>
        </div>
        <div class="img4load hidden" ></div>
    </div>
    
    <div class="productInfodiv">
		<div class="coats sing-c">
			<h3 class="c-head">${p.productName}</h3>
			<p class="article"> ${p.subTitle} </p>
			 原价￥<span class="originalPrice">
                 <fmt:formatNumber type="number" value="${p.originalPrice}" minFractionDigits="2"/>
               </span>
            	折扣价￥<span class="promotionPrice">
            <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
            </span>
			<div class="size">
				<small>Color</small>
				<ul class="size-list">
				 <c:forEach items="${colors}" var="color">
		        <li  class="colorli" title="${color}">
			        <div class="colorBlock" title="${color}">
			        <a >${color}</a>
			        </div>
			    </li>
		        </c:forEach>
				</ul>
			</div>
			
			<div class="size">
				<small>Size</small>
				<ul class="size-list">
				<c:forEach items="${sizes}" var="size">
		        <li>
			        <div class="sizeBlock" title="${size}">
			        <a >${size}</a>
			        </div>
			    </li>
		        </c:forEach>
				</ul>
			</div>
			<div class="selectName">
        <span class="sizetitle">已选：</span>
        <div class="selectColor"><input class="nowColor" type="text"></div>
        <div class="selectSize"><input class="nowSize" type="text"></div>
        </div>
        <div class="productNumber">
            <span>数量:</span>
            <span>
                <span class="productNumberSettingSpan">
                <input class="productNumberSetting" type="text" style="width:1.8em" value="0">
                </span>
                <span class="arrow">
                    <a href="#nowhere" class="increaseNumber">
                    <span class="updown">
                            <img src="img/site/increase.png">
                    </span>
                    </a>
                     
                    <span class="updownMiddle"> </span>
                    <a href="#nowhere"  class="decreaseNumber">
                    <span class="updown">
                            <img src="img/site/decrease.png">
                    </span>
                    </a>
                     
                </span>
                     
            件</span>
            <span id="stock"></span>
        </div>
			 <div class="buyDiv">
			 <c:if test="${p.status==0}">
			 <a class="text-danger">该产品已下架，无法进行购买</a>
			 </c:if>
			  <c:if test="${p.status==1}">
			  <a class="buyLink" href="forebuyone?pid=${p.productId}"><button class="buyButton">立即购买</button></a>
            <a href="#nowhere" class="addCartLink"><button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button></a>
			 </c:if>
           </div>
        </div>  
	</div>
	<div class="clear"></div>
	

<script>
 
$(function(){
    var stock = ${p.stock};
    $("#stock").text("库存"+stock+"件");
//     if($(".productNumberSetting").val()==0){
//     	$(".buyButton").css({"background-color":"#888888","border-color":"#777777"});
//     }
    $(".productNumberSetting").keyup(function(){
    	
        var num= $(".productNumberSetting").val();
        num = parseInt(num);
        if(isNaN(num))
            num= 1;
        if(num<=0)
            num = 0;
        if(num>stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
     
    $(".increaseNumber").click(function(){
    	
        var num= $(".productNumberSetting").val();
        num++;
        if(num>stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
    $(".decreaseNumber").click(function(){
        var num= $(".productNumberSetting").val();
        --num;
        if(num<=0)
            num=0;
        $(".productNumberSetting").val(num);
    });
   var cartnum = $("#cartnum").text();
    $(".addCartButton").removeAttr("disabled");
    $(".addCartLink").click(function(){
        var page = "forecheckLogin";
        $.get(
                page,
                function(result){
                    if("success"==result){
                    	if(stock=="0"){
                    		$("#stock").text("该产品款式无库存");
                    		$("#stock").addClass("text-danger");
                    	}
                        	
                        else{
                        var pid = ${p.productId};
                        var color = $(".nowColor").attr("value");
                        var size = $(".nowSize").attr("value");
                        var num= $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";
                        if(num=="0"){
                        	$("#stock").text("请选择商品购买数量");
                    		$("#stock").addClass("text-danger");
                        }
                        	
                        else
                        $.post(
                        		"getcsid",
                                {"color":color,"size":size,"pid":pid},
                                function(result){
                                	if(result=="该产品款式无库存")
                                		{
                                		$("#stock").text(result);
                                		$("#stock").addClass("text-danger");
                                		}
                                		
                                	else
                                		 $.get(
                                                 addCartpage,
                                                 {"pid":pid,"num":num,"csid":result},
                                                 function(result){
                                                     if("success"==result){
                                                    	 $("#stock").text("加入购物车成功！");
                                                    	 cartnum = cartnum*1+num*1;
                                                    	 $("#cartnum").text(cartnum);
                                                    	
                                                     }
                                                     else{
                                                    	 $("#stock").text("该商品库存不足以满足您购物车中加购的数量");
                                                    	 $("#stock").addClass("text-danger");
                                                     }
                                                 }
                                         ); 
                                }
                        );     
                       
                      }
                    }
                    else{
                        $("#loginModal").modal('show');                     
                    }
                }
        );      
        return false;
    });
    $(".buyLink").click(function(){
        var page = "forecheckLogin";
        if(stock=="0"){
        	$("#stock").addClass("text-danger");
        	$("#stock").text("该产品款式无库存");
        }
        else
        $.get(
                page,
                function(result){
                    if("success"==result){
                        var num = $(".productNumberSetting").val();
                        var color = $(".nowColor").attr("value");
                        var size = $(".nowSize").attr("value");
                        var pid = ${p.productId};
                        if(num=="0"){
                        	$("#stock").text("请选择商品购买数量");
                            $("#stock").addClass("text-danger");
                        }
                        	
                        else
                        $.post(
                        		"getcsid",
                                {"color":color,"size":size,"pid":pid},
                                function(result){
                                	if(result=="该产品款式无库存"){
                                		$("#stock").addClass("text-danger");
                                		$("#stock").text(result);
                                	}
                                		
                                	else
                                	location.href= $(".buyLink").attr("href")+"&csid="+result+"&num="+num;
                                	
                                }
                        );     
                    }
                    else{
                        $("#loginModal").modal('show');                     
                    }
                }
        );      
        return false;
    });
     
    $("input.loginSubmitButton").click(function(){
   	 var name = $("#name").val();
     var password = $("#password").val();
      
     if(0==name.length&&0==password.length){
         $("span.errorMessage").html("账号密码不能为空");
         $("div.loginErrorMessageDiv").show();           
         return false;
     }
     else  if(0==name.length&&0!=password.length){
         $("span.errorMessage").html("请输入账号");
         $("div.loginErrorMessageDiv").show();           
         return false;
     }
     else  if(0!=name.length&&0==password.length){
         $("span.errorMessage").html("请输入密码");
         $("div.loginErrorMessageDiv").show();           
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
                     $("span.errorMessage").html("账号不存在");
                     $("div.loginErrorMessageDiv").show();                       
                 }
                 else if("passwordError"==result){
                     $("span.errorMessage").html("密码错误");
                     $("div.loginErrorMessageDiv").show();                       
                 }
             }
     );          
      
     return true;
});
     
    $("img.smallImage").mouseenter(function(){
        var bigImageURL = $(this).attr("bigImageURL");
        $("img.bigImg").attr("src",bigImageURL);
        $("img.morebigImg").attr("src",bigImageURL);
        
    });
     
    //默认选中第一个颜色和尺码
    $(".colorBlock:first").attr("id","onClickColor");
    $(".sizeBlock:first").attr("id","onClickSize")
    $(".nowColor").attr("value", $(".colorBlock:first").attr("title"));
    $(".nowSize").attr("value",$(".sizeBlock:first").attr("title"));
    $("div.imgByColor").hide();
    $("div.imgByColor:first").show();
    
    $(".colorBlock").click(function(){
    	$("#stock").removeClass("text-danger");
    	$(".colorBlock").removeAttr("id","onClickColor")
    	$(".sizeBlock").removeAttr("id","onClickSize")
    	$(".nowSize").attr("value",$(".sizeBlock:first").attr("title"));
    	$(".sizeBlock:first").attr("id","onClickSize")
		 $(this).attr("id","onClickColor");
    	$(".nowColor").attr("value",$(this).attr("title"));
    	var page = "getstock";
    	var color =$(".nowColor").attr("value");
    	var size =$(".nowSize").attr("value");
    	var pid = ${p.productId};
    	  $.post(
                  page,
                  {"color":color,"size":size,"pid":pid},
                  function(result){
                          $("#stock").text("库存"+result+"件");
                          $("#stock").attr("value",result);
                          stock = result;
                  }
          );  
    	  var color  = $(".nowColor").attr("value");
    	  var bigImageURL = $("div.imgByColor[color="+color+"] img").attr("bigImageURL");
          $("img.bigImg").attr("src",bigImageURL);
          $("img.morebigImg").attr("src",bigImageURL);
    	  $("div.imgByColor").hide();
    	  $("div.imgByColor[color="+color+"]").show();
    	  
    	  
	 });
    
    $(".sizeBlock").click(function(){
    	$("#stock").removeClass("text-danger");
    	$(".sizeBlock").removeAttr("id","onClickSize")
		 $(this).attr("id","onClickSize");
    	$(".nowSize").attr("value",$(this).attr("title"));
    	var page = "getstock";
    	var color =$(".nowColor").attr("value");
    	var size =$(".nowSize").attr("value");
    	var pid = ${p.productId};
  	  $.post(
                page,
                {"color":color,"size":size,"pid":pid},
                function(result){
                	$("#stock").text("库存"+result+"件");
                	$("#stock").attr("value",result);
                	stock = result;
                }
        );     
	 });
    
    /*
    放大镜实现原理：
    1. “缩略图”窗口与“原图”窗口中放置的是同一个图片，但“缩略图”窗口中的图片被缩小为400px，
    而“原图”窗口中的图片保持原始大小，溢出部分设为隐藏
    2. 先确定缩放比例，我们假定原图大小为1000px，缩略图大小为400px，缩放比例为2.5
    3. 首先实现“放大镜”框跟随鼠标移动的功能（我们让鼠标处于“放大镜”框的中心）
    4. 其次实现“原图”窗口中的图片随“放大镜”框的移动而相应移动
    5. 鼠标向右移动，“原图”窗口中的图片向左移动，它们的方向是相反的！这是实现原理中的关键环节
    6. “放大镜”框的大小不是随意设定的，它与放大倍数有关，如果要放大2.5倍，
    则“原图”窗口的大小也应该是“放大镜”框的大小的2.5倍
    */

    
    
    // 当鼠标进入“缩略图”窗口时，显示“原图”窗口和“放大镜”框
    $('div.bigImageDiv').mouseover(function (e) {
        // 获取“缩略图”窗口在整个文档中的偏移位置
        var offsetX = $('div.bigImageDiv').position().left;
        var offsetY = $('div.bigImageDiv').position().top;
        
        var pawidth=$("div.imgInimgAndInfo").width();
        var paheight=$("div.imgInimgAndInfo").height();
       
    	var width=$(this).width();
    	var height=$(this).height();
    	 offsetX = (pawidth-width)/2;
        $('.moreBig').css('width', width);
        $('.moreBig').css('height', height);
        
        $('img.morebigImg').css('width', width*2.5);
        if(window.innerWidth<768){
         $('.moreBig').css('top',height);
         $('.moreBig').css('left',offsetX);
        }
        else{
        	$('.moreBig').css('top',0);
        	 $('.moreBig').css('left', offsetX+width+10);
        }
//         $('.moreBig').css('top',0);
        $('.moreBig').css('display', 'block');
        $('.magnifier').css('width', width/2.5);
        $('.magnifier').css('height', height/2.5);
        $('.magnifier').css('display', 'block');
//         $('.bigandmorebig').css('width', width);
        
        
        
    });
    // 当鼠标在“缩略图”窗口中移动时
    $('.bigImageDiv').mousemove(function (e) {
        // 一、首先实现“放大镜”框跟随鼠标移动的功能（我们让鼠标处于“放大镜”框的中心）
	
        // 获取鼠标当前位置
        var pageX = e.pageX;
        var pageY = e.pageY;
        // 获取“缩略图”窗口在整个文档中的偏移位置
        var offsetX = $('.bigImageDiv').offset().left;
        var offsetY = $('.bigImageDiv').offset().top;
        // 计算鼠标在缩略图中的相对位置
        var relativeX = pageX - offsetX;
        var relativeY = pageY - offsetY;
        // 考虑到鼠标处于“放大镜”框的中心，我们要根据鼠标位置计算“放大镜”框的位置
        var magOffsetX = $('.magnifier').width() / 2;
        var magOffsetY = $('.magnifier').height() / 2;
        $('.magnifier').css({ left: relativeX - magOffsetX + 'px',
            top: relativeY - magOffsetY + 'px' });
        // 获取“放大镜”框的新位置，后面会用到
        var magX = $('.magnifier').position().left;
        var magY = $('.magnifier').position().top;

        // 二、处理越界情况

        // 确定边界
        var maxMagX = $('.bigImageDiv').width() - $('.magnifier').width()
        var maxMagY = $('.bigImageDiv').height() - $('.magnifier').height()
        // 左边界
        if (magX <= 0) { magX=0; $('.magnifier').css('left', '0px'); }
        // 右边界
        if (magX >= maxMagX) { magX = maxMagX;$('.magnifier').css('left', maxMagX + 'px'); }
        // 上边界
        if (magY <= 0) { magY = 0;$('.magnifier').css('top', '0px'); }
        // 下边界
        if (magY >= maxMagY) {magY = maxMagY; $('.magnifier').css('top', maxMagY + 'px'); }

        // 三、其次实现“原图”窗口中的图片随“放大镜”框的移动而相应移动

        // 按照之前确定的缩放比例移动“原图”窗口中的图片
        // 注意：图片的移动方向与鼠标的移动方向是相反的！
        var moreBigX = magX * 2.5;
        var moreBigY = magY * 2.5;
        $('.moreBig img').css({ left: -moreBigX + 'px', top: -moreBigY + 'px' });
    });
    // 当鼠标离开“缩略图”窗口时，隐藏“原图”窗口和“放大镜”框
    $('.bigImageDiv').mouseout(function () {
//     	$('.bigandmorebig').css('width', "100%");
        $('.moreBig').css('display', 'none');
        $('.magnifier').css('display', 'none');
    });
});
	
</script>
  	   	
