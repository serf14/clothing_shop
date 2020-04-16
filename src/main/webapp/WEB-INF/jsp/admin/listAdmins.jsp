<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>管理员账号管理</title>

			<div class="row">
                <div class="col-lg-12">
				<h1 class="page-header">管理员账号管理</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="workingArea">
	

	<br>
	<br>
<!-- 	<div class="alertdiv" > -->
<!-- 	<div class="alert" style="display:none"></div> -->
<!-- 	</div> -->
	
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
			<tr>
				<th>ID</th>
				<th>管理员账号</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${as}" var="a">
				<tr>
					<td>${a.id}</td>
					<td>${a.account}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>
    <div class="panel panel-warning addDiv">
        <div class="panel-heading">创建管理员账号</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="admin_add_Administrator" >
                <table class="addTable">
                    <tr>
                        <td>账号</td>
                        <td><input id="account" name="account" type="text"
                            class="form-control"></td>
                    </tr>
                    <tr>
                        <td>密码</td>
                        <td><input id="password" name="password" type="text"
                            class="form-control"></td>
                    </tr>
                     
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="submit" class="btn btn-success">提 交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

</div>

<script>
$(function(){
	 <c:if test="${msg=='success'}">
	 $(".alert").html("操作成功").addClass("alert-success").show().delay(1500).fadeOut();
     </c:if>
     var isexist =false;
     var namereg=/^[0-9]{8,15}$/;  //账号由8-15位数字组成
	 var passwordreg=/^[a-zA-Z0-9]{6,20}$/;  //密码由6-20位数字和字母混合组成
	 $("#account").blur(function(){
		 var account =$("#account").val();
		 if(namereg.test(account)!=false){
			 $.post(
						"admin_checkAccount",
						{"account":account},
						function(result){
						if(result=="exist")
						{
							isexist =true;
							
						}
						if(result=="notExist"){
							isexist =false;
						}
				});
		 }
	 });
	$("#addForm").submit(function(){
		var account =$("#account").val();
		var password =$("#password").val();
		if(account.length==0){
			$(".alert").html("账号不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
			
		}
		else if(password.length==0){
			$(".alert").html("密码不能为空").addClass("alert-danger").show().delay(1500).fadeOut();
		}
		if(password.length!=0&&account.length!=0)
		{
			if(namereg.test(account)==false){
			$(".alert").html("账号需由8-15位数字组成").addClass("alert-danger").show().delay(1500).fadeOut();
			}
			else if(passwordreg.test(password)==false){
			$(".alert").html("密码需由6-20位数字或字母组成").addClass("alert-danger").show().delay(1500).fadeOut();
			}
			else if(namereg.test(account)!=false&&passwordreg.test(password)!=false){
// 				$.post(
// 						"admin_checkAccount",
// 						{"account":account},
// 						function(result){
// 						if(result=="exist")
// 						{
// 							$(".alert").html("该账号已被注册").addClass("alert-danger").show().delay(1500).fadeOut();
							
// 						}
// 						if(result=="notExist"){
// 							location.href="admin_add_Administrator?account="+account+"&&password="+password;
							
// 						}
// 				});
					if(isexist){
						$(".alert").html("该账号已被注册").addClass("alert-danger").show().delay(1500).fadeOut();
						return false;
					}
					else{
						return true;
					}
						
			}
			
		}
		return false;
	});
	
	
});
</script>

<%@include file="../include/admin/adminFooter.jsp"%>
