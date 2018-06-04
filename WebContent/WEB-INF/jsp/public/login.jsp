<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript">
	$.validator.addMethod('customphone', function (value, element) {
	    return this.optional(element) || /^(\+84|0)\d{9,10}$/.test(value);
	}, "<p class='vali-error' style='color: red'>Vui lòng nhập số điện thoại hợp lệ</p>");
	$(document).ready(function (){
		$('#signup').validate({
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
				password:{
					required: true,
					minlength: 4,
					maxlength: 15,
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
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập tên đăng nhập</p>",
					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
				fullname:{
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập tên đầy đủ</p>",
					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 25 ký tự</p>"
				},
				password:{
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập mật khẩu</p>",
					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
				re_password:{
					equalTo: "<p class='vali-error' style='color: red'>Vui lòng xác nhận đúng mật khẩu</p>",
				},
				email:{
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập email</p>",
					email: "<p class='vali-error' style='color: red'> lòng nhập email hợp lệ</p>",
				},
				address:{
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập địa chỉ</p>",
					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 100 ký tự</p>"
				},
			}
		});
	});
	$(document).ready(function (){
		$('#login').validate({
			rules:{
				username:{
					required: true,
					minlength: 4,
					maxlength: 15,
				},
				password:{
					required: true,
					minlength: 4,
					maxlength: 15,
				},
				
			},
			messages:{
				username:{
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập tên đăng nhập</p>",
					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
				password:{
					required: "<p class='vali-error' style='color: red'>Vui lòng nhập mật khẩu</p>",
					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
			}
		});
	});
</script>
            <main id="authentication" class="inner-bottom-md">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <section class="section sign-in inner-right-xs">
                                <h2 class="bordered">Đăng nhập</h2>
                                <c:if test="${not empty param.error }">
                                <p style="color: red">Tên đăng nhập hoặc mật khẩu không hợp lệ</p>
                                </c:if>
                                <form id="login" action="${pageContext.request.contextPath }/login" method="post" role="form" class="login-form cf-style-1">
                                    <div class="field-row">
                                        <label>Username</label>
                                        <input type="text" class="le-input" name="username">
                                    </div>
                                    <!-- /.field-row -->
                                    <div class="field-row">
                                        <label>Password</label>
                                        <input type="password" class="le-input" name="password">
                                    </div>
                                    <!-- /.field-row -->
                                    <div class="buttons-holder">
                                        <button type="submit" class="le-button huge">Đăng nhập</button>
                                    </div>
                                    <!-- /.buttons-holder -->
                                </form>
                                <!-- /.cf-style-1 -->
                            </section>
                            <!-- /.sign-in -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <section class="section register inner-left-xs">
                                <h2 class="bordered">Đăng ký</h2>
                                <c:if test="${not empty message }">
                                <p style="color: green">${message }</p>
                                </c:if>
                                <form id="signup" action="${pageContext.request.contextPath }/signup" role="form" class="register-form cf-style-1" method="post">
                                    <div class="field-row">
                                        <label>Username</label>
                                        <input name="username" type="text" class="le-input">
                                        <form:errors path="objUser.username" cssStyle="color:red; display: block"></form:errors>
                                       <c:if test="${not empty msg }">
                                        <br />
                                        <label style="color:red">${msg }</label>
                                       </c:if>
                                    </div>
                                    <div class="field-row">
                                        <label>Fullname</label>
                                        <input name="fullname" type="text" class="le-input">
                                        <form:errors path="objUser.fullname" cssStyle="color:red; display: block"></form:errors>
                                    </div>
                                    <div class="field-row">
                                        <label>Password</label>
                                        <input id="password" name="password" type="password" type="text" class="le-input">
                                        <form:errors path="objUser.password" cssStyle="color:red; display: block"></form:errors>
                                    </div>
                                    <div class="field-row">
                                        <label>Confirm Password</label>
                                        <input name="re_password" type="password" class="le-input">
                                    </div>
                                    <div class="field-row">
                                        <label>Email</label>
                                        <input name="email" type="text" class="le-input">
                                        <form:errors path="objUser.email" cssStyle="color:red; display: block"></form:errors>
                                    </div>
                                    <div class="field-row">
                                        <label>Phone</label>
                                        <input name="phone" type="text" class="le-input">
                                        <form:errors path="objUser.phone" cssStyle="color:red; display: block"></form:errors>
                                    </div>
                                    <div class="field-row">
                                        <label>Address</label>
                                        <input name="address" type="text" class="le-input">
                                        <form:errors path="objUser.address" cssStyle="color:red; display: block"></form:errors>
                                    </div>
                                    <!-- /.field-row -->
                                    <div class="buttons-holder">
                                        <button type="submit" class="le-button huge">Đăng ký</button>
                                    </div>
                                    <!-- /.buttons-holder -->
                                </form>
                            </section>
                            <!-- /.register -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container -->
            </main>
            <!-- /.authentication -->
