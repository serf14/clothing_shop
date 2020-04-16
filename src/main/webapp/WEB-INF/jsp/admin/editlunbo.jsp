<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>广告栏更换</title>
<div class="workingArea">
				<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">广告栏更换</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>


<div class="panel panel-warning updatelunbo">
						<div class="panel-heading">更换<b class="text-primary"> 广告栏 </b>图片</div>
						<div class="panel-body">
							<form method="post" class="addFormSingle" action="admin_update_lunbo" enctype="multipart/form-data">
								<table class="addTable">
									<tr>
										<td><p class="text-info">请选择要更换的图片 尺寸比例1.7:1 为佳</p></td>
									</tr>
									<tr>
										<td>
											<input id="lunboimg" type="file" name="image" />
										</td>
									</tr>
									
									<tr class="submitTR">
										<td align="center">
<!-- 											<input type="hidden" name="type" value="type_single" /> -->
											<input type="hidden" name="id" value="${id}" />
											<button type="submit" class="btn btn-success">提 交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<div class="showlunbpodiv">
					<div class="lunboImgDiv"><img src="img/lunbo/${id}.jpg" alt="Estelle">
					</div>

</div>


<script>
$(function(){
$("button.lunbo").click(function(){
    var id = $(this).attr("lunbo");
    $("tr.imglunbo[lunbo="+id+"]").toggle();
});


$(".addFormSingle").submit(function(){
    if(checkEmpty("lunboimg","图片文件")){
        $("#lunboimg").value("");
        return true;
    }
    return false;
});
});
</script>

<%@include file="../include/admin/adminFooter.jsp"%>
