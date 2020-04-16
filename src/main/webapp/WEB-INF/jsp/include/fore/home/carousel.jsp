<!-- 轮播部分，都是静态的页面，没有用到服务端数据 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

	<div class="slider da-slider" id="da-slider">

			<div class="da-slide slide-1">
				<img src="img/lunbo/1.jpg" alt="Estelle">
			</div>
			<div class="da-slide slide-2">
				<img src="img/lunbo/2.jpg" alt="Estelle">
			</div>
			<div class="da-slide slide-3">
				<img src="img/lunbo/3.jpg" alt="Estelle">
			</div>
			<div class="da-slide slide-4">
				<img src="img/lunbo/4.jpg" alt="Estelle">
			</div>
			<div class="da-slide slide-5">
				<img src="img/lunbo/5.jpg" alt="Estelle">
			</div>

	</div>
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
