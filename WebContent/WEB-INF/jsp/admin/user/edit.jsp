<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript">
	$.validator.addMethod('customphone', function (value, element) {
	    return this.optional(element) || /^(\+84|0)\d{9,10}$/.test(value);
	}, "<p class='vali-error'>Vui lòng nhập số điện thoại hợp lệ</p>");
	$(document).ready(function (){
		$('#edit_user').validate({
			rules:{
				username:{
					required: true,
					minlength: 4,
					maxlength: 15,
				},
				fullname:{
					required: true,
					minlength: 4,
					maxlength: 25,
				},
				re_password:{
					equalTo: '#password',
				},
				email:{
					required: true,
					email: true,
				},
				phone:'customphone',
				address:{
					required: true,
					minlength: 4,
					maxlength: 100,
				},
			},
			messages:{
				username:{
					required: "<p class='vali-error'>Vui lòng nhập tên đăng nhập</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
				fullname:{
					required: "<p class='vali-error'>Vui lòng nhập tên đầy đủ</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 25 ký tự</p>"
				},
				re_password:{
					equalTo: "<p class='vali-error'>Vui lòng xác nhận đúng mật khẩu</p>",
				},
				email:{
					required: "<p class='vali-error'>Vui lòng nhập email</p>",
					email: "<p class='vali-error'>Vui lòng nhập email hợp lệ</p>",
				},
				phone:{
					required: "<p class='vali-error'>Vui lòng nhập số điện thoại</p>",
				},
				address:{
					required: "<p class='vali-error'>Vui lòng nhập địa chỉ</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 100 ký tự</p>"
				},
			}
		});
	});
</script>
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Sửa người dùng</h5>
		</div>
		<!-- /Breadcrumb -->
	</div>
	<!-- /Title -->
	
	<!-- Row -->
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default card-view">
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="form-wrap">
							<form id="edit_user" action="${pageContext.request.contextPath }/admin/user/edit/${objUser.id_user}" method="post" enctype="multipart/form-data">
							<c:if test="${not empty message }">
								<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-info-outline mr-10"></i>${message }</h6>
								<hr class="light-grey-hr"/>
							</c:if>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Username</label>
											<br />
											<label class="control-label mb-10 " style="color: red; font-weight: bold; font-size: 20px;">${objUser.username }</label>
										</div>
									</div>
								
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Fullname</label>
											<input name="fullname" type="text"  class="form-control" placeholder="Tên đầy đủ" value="${objUser.fullname }">
											<form:errors path="objUser.fullname" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Password</label>
											<input id="password" name="password" type="password"  class="form-control" placeholder="Mật khẩu">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Confirm Password</label>
											<input name="re_password" type="password"  class="form-control" placeholder="Xác nhận mật khẩu">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Email</label>
											<input name="email" type="text"  class="form-control" placeholder="Email" value="${objUser.email }">
											<form:errors path="objUser.email" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Phone</label>
											<input name="phone" type="text"  class="form-control" placeholder="Số điện thoại" value="${objUser.phone }">
											<form:errors path="objUser.phone" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
								</div>
								<!-- Row -->
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Address</label>
											<input name="address" type="text"  class="form-control" placeholder="Địa chỉ" value="${objUser.address }">
											<form:errors path="objUser.address" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Role</label>
											<select name="role" class="form-control" data-placeholder="Choose a brand" tabindex="1">
											<c:choose>
												<c:when test="${('Admin' == sobjUser.role)}">
													<option <c:if test="${objUser.role == 'Admin' }">selected="selected"</c:if> value="Admin">Admin</option>
													<option <c:if test="${objUser.role == 'Mod' }">selected="selected"</c:if> value="Mod">Mod</option>
													<option <c:if test="${objUser.role == 'Member' }">selected="selected"</c:if> value="Member">Member</option>
												</c:when>
												<c:when test="${'Mod' eq sobjUser.role }">
													<option <c:if test="${objUser.role == 'Mod' }">selected="selected"</c:if> value="Mod">Mod</option>
													<option <c:if test="${objUser.role == 'Member' }">selected="selected"</c:if> value="Member">Member</option>
												</c:when>
											</c:choose>
											</select>
										</div>
									</div>									
									<!--/span-->
								</div>
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Edit</span></button>
									<a href="${pageContext.request.contextPath }/admin/user" type="button" class="btn btn-warning pull-left">Go back</a>
									<div class="clearfix"></div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /Row -->
</div>
