<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>产品图片管理</title>
			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">产品图片管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="workingArea">
	<ol class="breadcrumb">
<li><a href="admin_list_TopCategory">一级分类</a></li>
	<li><a href="admin_list_Category?tcid=${c.tcid}">${tc.topCategoryName}-分类列表</a></li>
	<li><a href="admin_product_list?cid=${c.categoryId}">${c.categoryName}-产品列表</a></li>
	<li class="active">${p.productName}-图片管理</li>
	</ol>

	<table class="addPictureTable" align="center">
		<tr>
			<td class="addPictureTableTD">
				<div>
					<div class="panel panel-warning addPictureDiv">
						<div class="panel-heading">新增产品<b class="text-primary"> 颜色尺码 </b>图片</div>
						<div class="panel-body">
							<form method="post" class="addFormSingle" action="admin_productImage_add" enctype="multipart/form-data">
								<table class="addTable">
									<tr>
										<td><p class="text-info">请选择要上传的图片 尺寸400X400 为佳</p></td>
									</tr>
									<tr>
										<td>
											<input id="filepathSingle" type="file" name="image" />
										</td>
									</tr>
									<tr>
										<td>
											<span class="text-info">请选择颜色款式</span>
											<select class=" colorSelect form-control" name="type">
											   <c:forEach items="${colors}" var="color">
											   <option>${color}</option>
											   </c:forEach>
											</select>
										</td>
									</tr>
									
									<tr class="submitTR">
										<td align="center">
<!-- 											<input type="hidden" name="type" value="type_single" /> -->
											<input type="hidden" name="pid" value="${p.productId}" />
											<button type="submit" class="btn btn-success">提 交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover  table-condensed">
						<thead>
						<tr >
							<th>ID</th>
							<th>颜色款式</th>
							<th>颜色款式缩略图</th>
							<th>删除</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${pisSingle}" var="pi">
							<tr>
								<td>${pi.productImageId}</td>
								<td>${pi.type}</td>
								<td>
									<a title="点击查看原图" href="img/productSingle/${pi.productImageId}.jpg"><img height="50px" src="img/productSingle/${pi.productImageId}.jpg"></a>
								</td>
								<td><a deleteLink="true"
									   href="admin_productImage_delete?id=${pi.productImageId}"><span
										class=" 	glyphicon glyphicon-trash"></span></a>
								</td>

							</tr>
						</c:forEach>
						</tbody>
					</table>

				</div>
			</td>
			<td class="addPictureTableTD">
				<div>

					<div class="panel panel-warning addPictureDiv">
						<div class="panel-heading">新增产品<b class="text-primary"> 详情 </b>图片</div>
						<div class="panel-body">
							<form method="post" class="addFormDetail" action="admin_productImage_add" enctype="multipart/form-data">
								<table class="addTable">
									<tr>
										<td>请选择本地图片 宽度790  为佳</td>
									</tr>
									<tr>
										<td>
											<input id="filepathDetail"  type="file" name="image" />
										</td>
									</tr>
									<tr class="submitTR">
										<td align="center">
											<input type="hidden" name="type" value="type_detail" />
											<input type="hidden" name="pid" value="${p.productId}" />
											<button type="submit" class="btn btn-success">提 交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover  table-condensed">
						<thead>
						<tr class="">
							<th>ID</th>
							<th>产品详情缩略图</th>
							<th>删除</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${pisDetail}" var="pi">
							<tr>
								<td>${pi.productImageId}</td>
								<td>
									<a title="点击查看原图" href="img/productDetail/${pi.productImageId}.jpg"><img height="50px" src="img/productDetail/${pi.productImageId}.jpg"></a>
								</td>
								<td><a deleteLink="true"
									   href="admin_productImage_delete?id=${pi.productImageId}"><span
										class=" 	glyphicon glyphicon-trash"></span></a></td>

							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</td>
		</tr>
	</table>





</div>

<script>
    $(function(){
        $(".addFormSingle").submit(function(){
            if(checkEmpty("filepathSingle","图片文件")){
                $("#filepathSingle").value("");
                return true;
            }
            return false;
        });
        $(".addFormDetail").submit(function(){
            if(checkEmpty("filepathDetail","图片文件"))
                return true;
            return false;
        });
    });

</script>

<%@include file="../include/admin/adminFooter.jsp"%>
