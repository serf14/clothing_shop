<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>  

<title>站内详情</title>

			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">站内详情</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
   
    <div class="row">
     <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	今日数据
                        </div>
                        <div class="panel-body">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-body well">
                        <h2>${waitNum}</h2>
                        <h5> <a href="admin_order_list?status=waitDelivery">已付款订单（待处理）</a></h5>
<!--                         <a class="btn btn-primary" href="admin_order_list?status=waitDelivery">查看</a> -->
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-3 -->
        		 <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-body well">
                         <h2>￥<fmt:formatNumber type="number" value="${todayPay}" minFractionDigits="2"/></h2>
                         <h5> 今日销售额</h5>
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-3 -->
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-body well">
						<h2>${orderNum}</h2>
						<h5> 今日订单数</h5>
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-3 -->
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-body well">
                        <h2>${TodayUserNum}</h2>
                        <h5> 今日注册量</h5>
                        </div>
                    </div>
                </div>
                   </div>
                    </div>
                </div>
      </div>
          
          
        
      <div class="row">
     
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	销售额-最近7天
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <div id="morris-lines-chart"></div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <div class="row">
     
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	销售额-最近4周
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <div id="morris-line2-chart"></div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
             <div class="row">
     
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	销售额-上个月
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <div id="morris-line3-chart"></div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
             <div class="row">
     
                <!-- /.col-lg-12 -->
            </div>
                        

<script type="text/javascript">
$(function(){
	
	var oneday=new Date();
	var monthDay = [];//7天
	var weekDay = [];//4周
	var lastMonthDay=[]//3旬
	for(var i=1;i<8;i++){
		var year =  oneday.getFullYear();
		var month = oneday.getMonth();       //获取当前月份(0-11,0代表1月)
		var day = oneday.getDate(); 
		monthDay.push(year+"-"+(month+1)+"-"+day);
		oneday.setDate(oneday.getDate()-1);
	}
	oneday=new Date();
	for(var i=1;i<5;i++){
		var year =  oneday.getFullYear();
		var month = oneday.getMonth();       //获取当前月份(0-11,0代表1月)
		var day = oneday.getDate(); 
		weekDay.push(year+"-"+(month+1)+"-"+day);
		oneday.setDate(oneday.getDate()-7);
	}
	oneday=new Date();
	oneday.setDate(0);
	for(var i=0;i<3;i++){
		var year =  oneday.getFullYear();
		var month = oneday.getMonth();       //获取当前月份(0-11,0代表1月)
		var day = oneday.getDate(); 
		lastMonthDay.push(year+"-"+(month+1)+"-"+day);
		oneday.setDate(oneday.getDate()-10);
	}
	var list =${weekEachPay};
	
	 var cha = Morris.Line({
	        element: 'morris-lines-chart',
	        data: [
	        	{
	            y: monthDay[6],
	            a: list[6].toFixed(2)
	           
	        }, {
	            y: monthDay[5],
	            a: list[5].toFixed(2)
	          
	        }, {
	            y: monthDay[4],
	            a: list[4].toFixed(2)
	          
	        }, {
	            y: monthDay[3],
	            a: list[3].toFixed(2)
	           
	        }, {
	            y: monthDay[2],
	            a: list[2].toFixed(2)
	        }, {
	            y: monthDay[1],
	            a: list[1].toFixed(2)
	        }, 
				{
	            y: monthDay[0],
	            a: list[0].toFixed(2)
	        },],
	        xkey: 'y',
	        ykeys: ['a'],
	        labels: ['销售额'],
	        hideHover: 'auto',
	        gridTextSize:'10px',
	        units:'元',
	        parseTime: false,
	        resize: true
	    });
	 var fourweekPay =${fourweekPay};
	 Morris.Bar({
	        element: 'morris-line2-chart',
	        data:[
	        	{
		            y: weekDay[3],
		            a: fourweekPay[3].toFixed(2)
		           
		        }, {
		            y: weekDay[2],
		            a: fourweekPay[2].toFixed(2)
		          
		        }, {
		            y: weekDay[1],
		            a: fourweekPay[1].toFixed(2)
		          
		        }, {
		            y: weekDay[0],
		            a: fourweekPay[0].toFixed(2)
		           
		        }
			],
	        xkey: 'y',
	        ykeys: ['a'],
	        labels: ['销售额'],
	        hideHover: 'auto',
	        gridTextSize:'10px',
	        units:'元',
	        parseTime: false,
	        resize: true
	    });
	 
	 var lastmonthPay=${lastmonthPay};
	 Morris.Bar({
	        element: 'morris-line3-chart',
	        data:[
	        	{
		            y: lastMonthDay[2],
		            a: lastmonthPay[2].toFixed(2)
		           
		        }, {
		            y: lastMonthDay[1],
		            a: lastmonthPay[1].toFixed(2)
		          
		        }, {
		            y: lastMonthDay[0],
		            a: lastmonthPay[0].toFixed(2)
		        }
			],
	        xkey: 'y',
	        ykeys: ['a'],
	        labels: ['销售额'],
	        hideHover: 'auto',
	        gridTextSize:'10px',
	        units:'元',
	        parseTime: false,
	        resize: true
	    });
	
});
</script>
           
<%@include file="../include/admin/adminFooter.jsp"%>