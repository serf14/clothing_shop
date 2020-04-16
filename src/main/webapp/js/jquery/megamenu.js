$.fn.megamenu=function(e){function r(){
	$(".megamenu").find("li, a").unbind();
	if(window.innerWidth<=768){
		getcate();o();s();
		if(n==0)
		{$(".megamenu > li:not(.showhide)").hide(0)}
	}
	else{
		getcate();
		u();
		i();
		}
		}
	function i(){
		$(".megamenu li").bind("mouseup",function(){
			$(this).children(".dropdown, .megapanel").stop().fadeIn(t.interval)}).bind("mouseleave",
			function(){
				$(this).children(".dropdown, .megapanel").stop().fadeOut(t.interval)})}
				
	function s(){
		$(".megamenu > li > a").bind("click",function(e){
			if($(this).siblings(".dropdown, .megapanel").css("display")=="none"){
				$(this).siblings(".dropdown, .megapanel").slideDown(t.interval);
				$(this).siblings(".dropdown").find("ul").slideDown(t.interval);
				n=1
				}
				else{$(this).siblings(".dropdown, .megapanel").slideUp(t.interval)}
				})}
				
	function o(){
		$(".megamenu > li.showhide").show(0);
		$(".megamenu > li.showhide").bind("click",function(){
			if($(".megamenu > li").is(":hidden"))
			{
				$(".megamenu > li").slideDown(300)}
				else{$(".megamenu > li:not(.showhide)").slideUp(300);
				$(".megamenu > li.showhide").show(0)}
				})}
	function u(){
		$(".megamenu > li").show(0);
	$(".megamenu > li.showhide").hide(0)
	}
	var t={interval:250};
	var n=0;
	//在
	$(".megamenu").prepend("<li class='shop showhide'><a>SHOP</a><span class='icon'></span></li>");
	r();
	$(window).resize(function(){r()})}

var firstman=true;
var firstwoman=true;
var firstchild=true;
function getcate(){
	$(".megamenu > li.item >a#0,a#1,a#2").bind("mouseenter",function(){
//		alert("12");
		var id = $(this).attr("id");
		if((firstman&&id==0)
			||(firstwoman&&id==1)
			||(firstchild&&id==2)){
		$.post(
				"GetTopAndCate?id="+id,
						function(result){
					if(result!=null){
						jsonData = JSON.stringify(result);
						jQuery.each(JSON.parse(jsonData), function(i,items){  
							var y = i;
							$("li.item"+id+" div.megapanel").append("<div class='tcAndc'><ul class='tcAndc c"+y+"'></ul></div>")
							
							hashmap = JSON.stringify(items);
							var first=0;
							jQuery.each(JSON.parse(hashmap), function(m,item){
									if(first==0){
										$("li.item"+id+" div.megapanel"+" div.tcAndc"+" ul.c"+y).append("<li class='topcate'>"+item+"</li>");	
										first++;
									}
									else
		   						 $("li.item"+id+" div.megapanel"+" div.tcAndc"+" ul.c"+y).append("<li class='cate'><a href='forecategory?cid="+m+"&type="+id+"'>"+item+"</a></li>");
							});
						});
					}
				});
				
				if(id==0){
					firstman=false;
				}
				if(id==1){
					firstwoman=false;
				}
				if(id==2){
					firstchild=false;
				}
		
		}
		
	})
}

