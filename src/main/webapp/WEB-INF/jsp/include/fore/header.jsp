<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap -->
<link href="css/fore/css/bootstrap.css" rel='stylesheet' type='text/css' media="all" />
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<!-- 产品框，导航栏 -->
<link href="css/fore/css/style-nav.css" rel='stylesheet' type='text/css' media="all" />
<link rel="stylesheet" href="css/fore/css/sticky-navigation.css" />
<!-- 轮播部分 -->
<link href="css/fore/style-slider.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/fore/slider.css" rel="stylesheet">
<!-- 字体 -->
<link href="sb-admin-v2/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- 各个页面 -->
<link href="css/fore/style.css" rel="stylesheet">



<!-- 保证页面刷新后内容在最顶端 -->
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<!-- jquery bootstrap-->
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 下拉菜单栏 -->
<script type="text/javascript" src="js/jquery/megamenu.js"></script>

<!-- 验证码 -->
<script src="js/jquery/gVerify.js"></script>		

<!-- 轮播小图 -->
<script type="text/javascript" src="js/jquery/jquery.flexisel.js"></script>


<script type="text/javascript" src="js/jquery/modernizr.custom.28468.js"></script>
<!-- 图片轮播 -->
<script type="text/javascript" src="js/jquery/jquery.cslider.js"></script>
<!-- 回到顶部 -->
<script type="text/javascript" src="js/jquery/move-top.js"></script>
<script type="text/javascript" src="js/jquery/easing.js"></script>
<script>
        function formatMoney(num){
            num = num.toString().replace(/\$|\,/g,'');
            if(isNaN(num))
                num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num*100+0.50000000001);
            cents = num%100;
            num = Math.floor(num/100).toString();
            if(cents<10)
                cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
                num = num.substring(0,num.length-(4*i+3))+','+
                    num.substring(num.length-(4*i+3));
            return (((sign)?'':'-') + num + '.' + cents);
        }
        function checkEmpty(id, name){
            var value = $("#"+id).val();
            if(value.length==0){

                $("#"+id)[0].focus();
                return false;
            }
            return true;
        }


$(function(){


            $("a.productDetailTopReviewLink").click(function(){
                $("div.productReviewDiv").show();
                $("div.productDetailDiv").hide();
            });
            $("a.productReviewTopPartSelectedLink").click(function(){
                $("div.productReviewDiv").hide();
                $("div.productDetailDiv").show();
            });

            $("span.leaveMessageTextareaSpan").hide();
            $("img.leaveMessageImg").click(function(){

                $(this).hide();
                $("span.leaveMessageTextareaSpan").show();
                $("div.orderItemSumDiv").css("height","100px");
            });

            $("div#footer a[href$=#nowhere]").click(function(){
                alert("模仿天猫的连接，并没有跳转到实际的页面");
            });


            $("a.wangwanglink").click(function(){
                alert("模仿旺旺的图标，并不会打开旺旺");
            });
            $("a.notImplementLink").click(function(){
                alert("这个功能没做，蛤蛤~");
            });

// -------------------------------------------------------------------------------

        	// grab the initial top offset of the navigation 
        	var sticky_navigation_offset_top = $('#sticky_navigation').offset().top;
        	
        	// our function that decides weather the navigation bar should have "fixed" css position or not.
        	var sticky_navigation = function(){
        		var scroll_top = $(window).scrollTop(); // our current vertical position from the top
        		var width =$(window).width();
        		// if we've scrolled more than the navigation, change its position to fixed to stick to top, otherwise change it back to relative
        		if (scroll_top > sticky_navigation_offset_top&&width>768) { 
        			$('#sticky_navigation').css({ 'position': 'fixed', 'top':0, 'left':0 });
        		} else {
        			$('#sticky_navigation').css({ 'position': 'relative' }); 
        		}   
        	};
        	
        	// run our function on load
        	sticky_navigation();
        	
        	// and run it again every time you scroll
        	$(window).scroll(function() {
        		 sticky_navigation();
        	});
        	

            
 });

</script>
<script type="text/javascript">
			$(function() {
				$('#da-slider').cslider({
					autoplay : true,
					bgincrement : 450
				});
			});
</script>
<script type="text/javascript">
			$(function() {
				$('#da-slider1').cslider({
					autoplay : true,
					bgincrement : 450
				});
			});
</script>
<script type="text/javascript">
					$(window).load(function() {
						$("#flexiselDemo3").flexisel({
							visibleItems: 5,
							animationSpeed: 1000,
							autoPlay: true,
							autoPlaySpeed: 3000,    		
							pauseOnHover: true,
							enableResponsiveBreakpoints: true,
					    	responsiveBreakpoints: { 
					    		portrait: { 
					    			changePoint:480,
					    			visibleItems: 1
					    		}, 
					    		landscape: { 
					    			changePoint:640,
					    			visibleItems: 2
					    		},
					    		tablet: { 
					    			changePoint:768,
					    			visibleItems: 3
					    		}
					    	}
					    });
					    
					});
</script>
</head>

<body>

