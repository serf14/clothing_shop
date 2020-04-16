<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

	
<script>

$(document).ready(function(){$(".megamenu").megamenu();});
</script>
<div class="header">
	<div class="container">
	<div id="demo_top_wrapper">
	<div id="sticky_navigation_wrapper">
		<div id="sticky_navigation">
			<div class="demo_container navigation-bar">
				<div class="navigation">
					<div class="logo"><a href="forehome">SHOP</a></div>
					
					
					<div class="navig">
						<ul class="megamenu">
							<li class="item item0"><a id="0">男装</a>
							<div class="manCategory megapanel">
							<c:forEach items="${tcandcs0}" var="tcandc" varStatus="st">
								<div class="tcAndc">
									<ul class="tcAndc">
										<c:forEach items="${tcandc}" var="c" varStatus="s">
											<c:if test="${s.first}">
											<li class="topcate">${c.value}</li>
											</c:if>
											<c:if test="${!s.first}">
											<li class="cate"><a href="forecategory?cid=${c.key}&type=0">${c.value}</a></li>
											</c:if>
										</c:forEach>
									</ul>
								</div>
							</c:forEach>
							</div>
							</li>
							
							<li class="item item1"><a id="1">女装</a>
							<div class="manCategory megapanel">
							<c:forEach items="${tcandcs1}" var="tcandc" varStatus="st">
							<div class="tcAndc">
							<ul class="tcAndc">
							<c:forEach items="${tcandc}" var="c" varStatus="s">
							<c:if test="${s.first}">
							<li class="topcate">${c.value}</li>
							</c:if>
							<c:if test="${!s.first}">
							<li class="cate"><a href="forecategory?cid=${c.key}&type=1">${c.value}</a></li>
							</c:if>
							</c:forEach>
							</ul>
							</div>
							</c:forEach>
							</div>
							</li>
							<li class="item item2"><a id="2">童装</a>
							<div class="manCategory megapanel">
							<c:forEach items="${tcandcs2}" var="tcandc" varStatus="st">
							<div class="tcAndc">
							<ul class="tcAndc">
							<c:forEach items="${tcandc}" var="c" varStatus="s">
							<c:if test="${s.first}">
							<li class="topcate">${c.value}</li>
							</c:if>
							<c:if test="${!s.first}">
							<li class="cate"><a href="forecategory?cid=${c.key}&type=2">${c.value}</a></li>
							</c:if>
							</c:forEach>
							</ul>
							</div>
							</c:forEach>
							</div>
							</li>
						</ul>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="navigation-right">
					<ul class="user">
					<c:if test="${!empty user}">
						<li>
						
						<a href="foreUserInfo"><i class="fa fa-user fa-fw"></i>个人中心  </a>
							<a href="forelogout">
							<i class="fa fa-sign-out fa-fw"></i>登出</a>
						</li>
					</c:if>
					<c:if test="${empty user}">
						<li>
							<a href="loginPage">登录</a>
						</li>
					</c:if>
						
						<li>
							<a href="forebought"><i class="fa fa-tasks fa-fw"></i>订单</a>
						</li>
						<li>
							
							<a href="forecart">
							<i class="glyphicon glyphicon-shopping-cart"></i>
							购物车<strong id="cartnum">${cartTotalItemNumber}</strong>件</a>
						</li>
						<li>
<!-- 						<i class="fa fa-search"></i> -->
							<button class="search"></button>
								<div class="serch">
								<span>
								<form action="foresearch" method="post">
									<input name="keyword" type="text" value="${param.keyword}" placeholder="热门搜索：时尚夏季T恤" required="">
									<input type="submit" value="" />
								</form>
								</span>
								</div>
						</li>
					</ul>
				</div>
				<div class="clearfix"></div>
			
		
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
					<script>


						$( "span.icon" ).click(function() {
						  $( "li.item" ).slideToggle( "slow", function() {
						    // Animation complete.
						  });
						});
						$(window).resize(function() {
							if(window.innerWidth>768){
								
								$( "li.item" ).css("display","inline-block");
							}
							else{
								$( "li.item" ).hide();
							}
							
							});
						
					</script>
					
				<script>
					$( "button.search" ).click(function() {
					  $( ".serch" ).slideToggle( "slow", function() {
					    // Animation complete.
					  });
					});
				</script>

<script type="text/javascript">
		$(document).ready(function() {
			var defaults = {
				containerID: 'toTop', // fading element id
				containerHoverID: 'toTopHover', // fading element hover id
				scrollSpeed: 100,
				easingType: 'linear'
			};
			$().UItoTop({ easingType: 'easeOutQuart' });
		});
	</script>
	<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll, .navbar li a").click(function(event){
					$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
				});
			});
	</script>
	<a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

