<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

<title>收货地址</title>
<div class="container">
<div class="content">
<div class="pag-nav">
			<ul class="p-list">
				<li><a href="forehome">Home/</a></li> 
				<li class="act">&nbsp;ListAddress</li>
			</ul>
		</div>
<div class="coats">
			<h2>收货地址</h2>
			<h5></h5>
		</div>
		
		
		<c:forEach items="${address}" var="ad">
		<div class="oneAddressDiv" adid="${ad.id}">
			<div class="AddressContent">
			<p>${ad.name}</p>
			<h5>${ad.simpleArea}</h5>
			<h5>${ad.detailedArea}</h5>
			<h5>${ad.postCode}</h5>
			<h5>${ad.phone}</h5>
			</div>
			<div class="butDiv">
			<a href="foreUpdateAddress?id=${ad.id}" adid="${ad.id}" class="btn editAddressBut">修改</a>
			<a href="#nowhere" adid="${ad.id}" class="btn deleAddressBut">删除</a>
			</div>
		</div>
		</c:forEach>
		
		<div class="addAddressButDiv">
		<a href="foreNewAddress" class=" addAddressBut">添加新地址</a>
		</div>
</div>
</div>

		 
<script>

$(function(){
	
	var deleteOrderItem = false;
	var deleteOrderItemid = 0;
	$("a.deleAddressBut").click(function(){
		deleteOrderItem = false;
		deleteOrderItemid = $(this).attr("adid");
		$("#deleteAddressConfirmModal").modal('show');	   
	});
	$("button.deleteAddressConfirmButton").click(function(){
		deleteOrderItem = true;
		$("#deleteAddressConfirmModal").modal('hide');
	});
	
	$('#deleteAddressConfirmModal').on('hidden.bs.modal', function (e) {
		if(deleteOrderItem){
			var deletepage = "foreDeleteAddress";
			$.post(
					deletepage,
				    {"id":deleteOrderItemid},
				    function(result){
						if("success"==result){
							$("div.oneAddressDiv[adid="+deleteOrderItemid+"]").remove();
						}
						else{
							location.href="loginPage";
						}
				    }
				);
			
		}
	});
	
	
})

</script>
