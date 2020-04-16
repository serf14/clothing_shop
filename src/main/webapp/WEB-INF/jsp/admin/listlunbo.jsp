<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>广告栏管理</title>
<div class="workingArea">
				<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">广告栏管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>

<div class="listDataTableDiv">
	 <div class="table-responsive">
		<table id="dataTables-example" class="table table-striped table-bordered table-hover table-condensed">
			<thead>
			<tr>
				<th>广告位序号</th>
				<th>更换</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>01</td>
				<td>
				<a href="admin_edit_lunbo?id=1">
				<span class="glyphicon glyphicon-edit"></span>
				</a>
				</td>
				<td ><button lunbo="1" class="btn btn-primary btn-xs lunbo">查看</button></td>	
			</tr>
			<tr class="imglunbo" lunbo="1">
				<td colspan="3" align="center">
				<div class="lunboImgDiv"><img src="img/lunbo/1.jpg" alt="Estelle"></div>
				</td>
			</tr>
			<tr>
				<td >02</td>
				<td>
				<a href="admin_edit_lunbo?id=1">
				<span class="glyphicon glyphicon-edit"></span>
				</a>
				</td>
				<td ><button lunbo="2" class="btn btn-primary btn-xs lunbo">查看</button></td>
			</tr>
			<tr class="imglunbo" lunbo="2">
				<td colspan="3" align="center">
				<div class="lunboImgDiv"><img src="img/lunbo/2.jpg" alt="Estelle">
				</div></td>
			</tr>
			<tr>
				<td>03</td>
				<td>
				<a href="admin_edit_lunbo?id=1">
				<span class="glyphicon glyphicon-edit"></span>
				</a>
				</td>
				<td ><button lunbo="3" class="btn btn-primary btn-xs lunbo">查看</button></td>
			</tr>
			<tr class="imglunbo" lunbo="3">
				<td colspan="3" align="center">
				<div class="lunboImgDiv"><img src="img/lunbo/3.jpg" alt="Estelle">
				</div></td>
			</tr>
			<tr>
				<td>04</td>
				<td>
				<a href="admin_edit_lunbo?id=1">
				<span class="glyphicon glyphicon-edit"></span>
				</a>
				</td>
				<td ><button lunbo="4" class="btn btn-primary btn-xs lunbo">查看</button></td>
			</tr>
			<tr class="imglunbo" lunbo="4">
				<td colspan="3" align="center">
				<div class="lunboImgDiv"><img src="img/lunbo/4.jpg" alt="Estelle">
				</div></td>
			</tr>
			<tr>
				<td>05</td>
				<td>
				<a href="admin_edit_lunbo?id=1">
				<span class="glyphicon glyphicon-edit"></span>
				</a>
				</td>
				<td ><button  lunbo="5"class="btn btn-primary btn-xs lunbo">查看</button></td>
			</tr>
			<tr class="imglunbo" lunbo="5">
				<td colspan="3" align="center">
				<div class="lunboImgDiv"><img src="img/lunbo/5.jpg" alt="Estelle">
				</div></td>
			</tr>
			</tbody>
		</table>
	</div>
	</div>




</div>

<script>
$(function(){
$("button.lunbo").click(function(){
    var id = $(this).attr("lunbo");
    $("tr.imglunbo[lunbo="+id+"]").toggle();
});
});
</script>


<%@include file="../include/admin/adminFooter.jsp"%>