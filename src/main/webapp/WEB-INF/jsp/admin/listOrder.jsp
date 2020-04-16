<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>订单管理</title>


<div class="workingArea">
				<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">订单管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
	<div class="row">
	<input type="hidden" id="timeNum" value='${timeNum}'>
     <select class="form-control myselect selectDate" >
           <option time="0">显示所有日期</option>
           <option time="01">本月</option>
           <option time="02">上月</option>
           <option time="03">最近7天</option>
           <option time="04">最近30天</option>
     </select>
     <input type="hidden" id="status" value='${status}'>
     <select class="form-control myselect selectStatus">
           <option status="all">显示所有状态</option>
           <option status="waitPay">未付款</option>
           <option status="cancelOrder">已取消</option>
           <option status="waitDelivery">待发货</option>
           <option status="waitConfirm">待收货</option>
           <option status="finish">已完成</option>
           <option status="waitReview">待评价</option>
           <option status="waitRefund">待退款</option>
           <option status="completeRefund">已退款</option>
     </select>
    
     </div>
     <div class="row timepicker">
      <div class="col-sm-12">
      <p class="p-inline">起始时间：</p>
    <input class="Wdate" id=StartTime  value="${startTime}" type="text"  onclick="var EndTime=$dp.$('EndTime');WdatePicker({onpicked:function(){EndTime.click();},maxDate:'#F{$dp.$D(\'EndTime\')}'})">
		<p class="p-inline">结束时间：</p>
    <input class="Wdate"  id=EndTime  value="${endTime}" type="text"  onclick="WdatePicker({minDate:'#F{$dp.$D(\'StartTime\')}'})">
	<a class="btn btn-primary btn-xs" id="submitTime">查询</a>
	</div>
     </div>
	<div class="listDataTableDiv">
	 <div class="table-responsive">
		<table id="dataTables-example" class="table table-striped table-bordered table-hover table-condensed">
			<thead>
			<tr>
				<th>ID</th>
				<th>状态</th>
				<th>金额</th>
				<th width="100px">商品数量</th>
				<th width="100px">买家名称</th>
				<th>创建时间</th>
				<th>支付时间</th>
				<th>发货时间</th>
				<th>确认收货时间</th>
				<th width="120px">操作</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${os}" var="o">
				<tr>
					<td>${o.orderId}</td>
					<td>${o.statusDesc}</td>
					<td>￥<fmt:formatNumber type="number" value="${o.orderPrice}" minFractionDigits="2"/></td>
					<td align="center">${o.totalNumber}</td>
					<td align="center">${o.user.userName}</td>

					<td><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td><fmt:formatDate value="${o.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td><fmt:formatDate value="${o.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td><fmt:formatDate value="${o.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

					<td>
						<button oid=${o.orderId} class="orderPageCheckOrderItems btn btn-primary btn-xs">查看详情</button>

						<c:if test="${o.status=='waitDelivery'}">
							<a href="admin_order_delivery?orderId=${o.orderId}&start=${page.start}">
								<button class="btn btn-primary btn-xs">发货</button>
							</a>
						</c:if>
						<c:if test="${o.status=='waitRefund'}">
							<a href="admin_order_refund?orderId=${o.orderId}&start=${page.start}">
								<button class="btn btn-primary btn-xs">退款</button>
							</a>
						</c:if>
					</td>
				</tr>
				<tr class="orderPageOrderItemTR"  oid=${o.orderId}>
					<td colspan="10" align="center">

						<div  class="orderPageOrderItem">
							<table width="800px" align="center" class="orderPageOrderItemTable">
								<c:forEach items="${o.orderItems}" var="oi">
									<tr>
										<td align="left">
											<img width="40px" height="40px" src="img/productSingle/${oi.product.firstProductImage.productImageId}.jpg">
										</td>

										<td>
											<a href="foreproduct?pid=${oi.product.productId}">
												<span>${oi.product.productName}&nbsp;${oi.product.colorAndSize.colorValue}&nbsp;${oi.product.colorAndSize.sizeValue}</span>
											</a>
										</td>
										<td align="right">

											<span class="text-muted">数量：${oi.number}</span>
										</td>
										<td align="right">

											<span class="text-muted">单价：￥${oi.product.promotePrice}</span>
										</td>

									</tr>
								</c:forEach>

							</table>
						</div>

					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>



</div>

<script>
    $(function(){
    	
    	var oneday=new Date();
		
    	function formatDate(date) { 
    		var myyear = date.getFullYear(); 
    		var mymonth = date.getMonth()+1; 
    		var myweekday = date.getDate(); 

    		if(mymonth < 10){ 
    		mymonth = "0" + mymonth; 
    		} 
    		if(myweekday < 10){ 
    		myweekday = "0" + myweekday; 
    		} 
    		return (myyear+"-"+mymonth + "-" + myweekday); 
    		} 
    	
    	function gettime(time){
    		var year =  oneday.getFullYear();
			var month = oneday.getMonth();       //获取当前月份(0-11,0代表1月)
			var day = oneday.getDate(); 
			var start=oneday;
			var end = oneday;
			
			var status = $(".selectStatus").find("option:selected").attr("status");
			if(time=="0"){
    			location.href="admin_order_list?status="+status+"&timeNum="+time;
    		}
			if(time=="01"){
				 start =  new Date(year,month,1); 
				 end = new Date(); 
				 end = formatDate(end);
				 start =  formatDate(start);
    			location.href="admin_order_list?status="+status+"&startTime="+start+"&endTime="+end+"&timeNum="+time;
    		}
			else if(time=="02"){
				 start =  new Date(year,month-1,1); 
				 end = new Date(year,month,1); 
				end.setDate(end.getDate()-1);
				 end = formatDate(end);
				 start =  formatDate(start);
    			location.href="admin_order_list?status="+status+"&startTime="+start+"&endTime="+end+"&timeNum="+time;
    		}
			else if(time=="03"){
				start.setDate(start.getDate()-6);
				end = new Date(); 
				 end = formatDate(end);
				 start =  formatDate(start);
    			location.href="admin_order_list?status="+status+"&startTime="+start+"&endTime="+end+"&timeNum="+time;
    		}
			else if(time=="04"){
				start.setDate(start.getDate()-29);
				end = new Date(); 
				 end = formatDate(end);
				 start =  formatDate(start);
    			location.href="admin_order_list?status="+status+"&startTime="+start+"&endTime="+end+"&timeNum="+time;
			}
			
    	}
    	
    	
    	var status=$("#status").val();
    	var timeNum =$("#timeNum").val();
    	$(".selectStatus").find("option[status="+status+"]").attr("selected",true);
    	$(".selectDate").find("option[time="+timeNum+"]").attr("selected",true);
        $("button.orderPageCheckOrderItems").click(function(){
            var oid = $(this).attr("oid");
            $("tr.orderPageOrderItemTR[oid="+oid+"]").toggle();
        });
        
		$(".selectStatus").change(function(){
			var time = $(".selectDate").find("option:selected").attr("time");
    		gettime(time);
    	});
		
		$(".selectDate").change(function(){
			
    		var time = $(this).find("option:selected").attr("time");
    		gettime(time);
    	});
		$("#submitTime").click(function (){
			var st= $("#StartTime").val();
			var et= $("#EndTime").val();
			var status = $(".selectStatus").find("option:selected").attr("status");
			if(st!=null&&et!=null){
				location.href="admin_order_list?status="+status+"&startTime="+st+"&endTime="+et+"&timeNum="+"0";	
			}
		});
        
    });

</script>

<%@include file="../include/admin/adminFooter.jsp"%>
