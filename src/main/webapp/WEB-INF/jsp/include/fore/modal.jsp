<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

<div class="modal " id="loginModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog loginDivInProductPageModalDiv">
		<div class="modal-content">
			<div class="loginDivInProductPage">
				<div class="loginErrorMessageDiv">
					<div >
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
						<span class="errorMessage text-danger" ></span>
					</div>
				</div>

				<div class="login_acount_text">账户登录</div>
				<div class="loginInput " >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-user"></span>
							</span>
					<input id="name" name="uerName" placeholder="请输入账号" type="text">
				</div>

				<div class="loginInput " >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-lock"></span>
							</span>
					<input id="password" name="password"  type="password" placeholder="请输入密码" type="text">
				</div>
				<div>
					<a href="#nowhere">忘记登录密码</a>
					<a href="registerPage" class="pull-right">免费注册</a>
				</div>
				<div class="text">
				<input  id="submitButton" class="loginSubmitButton"type="submit" value="Login" />
			</div>
<!-- 				<div style="margin-top:20px"> -->
<!-- 					<button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button> -->
<!-- 				</div> -->
			</div>
		</div>
	</div>
</div>

<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog deleteConfirmModalDiv">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title">确认删除订单吗？</h4>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
				<button class="btn btn-default deleteConfirmButton" id="submit" type="button">确认</button>
			</div>
		</div>
	</div>
</div>
<div class="modal" id="deleteAddressConfirmModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog deleteConfirmModalDiv">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title">确认删除该地址吗？</h4>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
				<button class="btn btn-default deleteAddressConfirmButton" id="submit" type="button">确认</button>
			</div>
		</div>
	</div>
</div>
<div class="modal" id="cancelConfirmModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog deleteConfirmModalDiv">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title">确认取消订单吗？</h4>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
				<button class="btn btn-default cancelConfirmButton" id="submit" type="button">确认</button>
			</div>
		</div>
	</div>
</div>
<div class="modal" id="refundConfirmModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog deleteConfirmModalDiv">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title">确认申请退款吗？</h4>
			</div>
			<div class="modal-footer">
				<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
				<button class="btn btn-default refundConfirmButton" id="submit" type="button">确认</button>
			</div>
		</div>
	</div>
</div>
</div>