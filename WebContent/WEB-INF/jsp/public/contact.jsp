<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
$(document).ready(function (){
	$.validator.addMethod('customphone', function (value, element) {
	    return this.optional(element) || /^(\+84|0)\d{9,10}$/.test(value);
	}, "<p class='vali-error' style='color: red'>Vui lòng nhập số điện thoại hợp lệ</p>");
	$('#contact-form').validate({
		rules:{
			name:{
				required: true,
				minlength: 4,
				maxlength: 15,
			},
			mail:{
				required: true,
				email: true,
			},
			phone:'customphone',
			title:{
				required: true,
			},
			message:{
				required: true,
			},
		},
		messages:{
			name:{
				required: "<p class='vali-error' style='color: red'>Vui lòng nhập tên</p>",
				minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
				maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
			},
			mail:{
				required: "<p class='vali-error' style='color: red'>Vui lòng nhập email</p>",
				email: "<p class='vali-error' style='color: red'> lòng nhập email hợp lệ</p>",
			},
			title:{
				required: "<p class='vali-error' style='color: red'>Vui lòng tiêu đề</p>",
				minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
				maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 100 ký tự</p>"
			},
			message:{
				required: "<p class='vali-error' style='color: red'>Vui lòng nhập nội dung</p>",
			},
		}
	});
});
</script>
<main id="contact-us" class="inner-bottom-md">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<section class="section leave-a-message">
					<h2 class="bordered">Liên hệ</h2>
					<p>Nếu có thắc mắc hoặc góp ý, vui lòng liên hệ với chúng tôi theo thông tin dưới đây</p>
					<c:if test="${not empty msg }">
					<p style="color: green; font-weight: both;">${msg }</p>
					</c:if>
					<form id="contact-form" class= "contact-form cf-style-1 inner-top-xs" action="${pageContext.request.contextPath }/lien-he" method="post" >
                        <div class="row field-row">
                            <div class="col-xs-12 col-sm-6">
                                <label>Your Name*</label>
                                <input name="name" class="le-input" >
                            </div>
                            <div class="col-xs-12 col-sm-6">
                                <label>Your Email*</label>
                                <input name="mail" class="le-input" >
                            </div>
                        </div><!-- /.field-row -->
                        <div class="field-row">
                            <label>Phone</label>
                            <input name="phone" type="text" class="le-input">
                        </div><!-- /.field-row -->
                        <div class="field-row">
                            <label>Title</label>
                            <input name="title" type="text" class="le-input">
                        </div><!-- /.field-row -->

                        <div class="field-row">
                            <label>Your Message</label>
                            <textarea name="message" rows="8" class="le-input"></textarea>
                        </div><!-- /.field-row -->

                        <div class="buttons-holder">
                            <button type="submit" class="le-button huge">Send Message</button>
                        </div><!-- /.buttons-holder -->
                    </form><!-- /.contact-form -->
				</section><!-- /.leave-a-message -->
			</div><!-- /.col -->

			<div class="col-md-4">
				<section class="our-store section inner-left-xs">
					<h2 class="bordered">Cửa hàng của chúng tôi</h2>
					<address>
						Đường Ninh Tốn  <br/>
						Số nhà 51 <br/>
						Vinaenter
					</address>
					<h3>Giờ làm việc</h3>
					<ul class="list-unstyled operation-hours">
						<li class="clearfix">
							<span class="day">Thứ hai:</span>
							<span class="pull-right hours">12-6 PM</span>
						</li>
						<li class="clearfix">
							<span class="day">Thứ ba:</span>
							<span class="pull-right hours">12-6 PM</span>
						</li>
						<li class="clearfix">
							<span class="day">Thứ tư:</span>
							<span class="pull-right hours">12-6 PM</span>
						</li>
						<li class="clearfix">
							<span class="day">Thứ năm:</span>
							<span class="pull-right hours">12-6 PM</span>
						</li>
						<li class="clearfix">
							<span class="day">Thứ sáu:</span>
							<span class="pull-right hours">12-6 PM</span>
						</li>
						<li class="clearfix">
							<span class="day">Thứ bảy:</span>
							<span class="pull-right hours">12-6 PM</span>
						</li>
						<li class="clearfix">
							<span class="day">Chủ nhật</span>
							<span class="pull-right hours">Closed</span>
						</li>
					</ul>
					<h3>Chú ý</h3>
					<p>Nếu bạn có bất cứ thắc mắc gì về SmartShop vui lòng liên hệ qua mail: <a href="mailto:contact@yourstore.com">nguyenvanhoang@gmail.com</a></p>
				</section><!-- /.our-store -->
			</div><!-- /.col -->

		</div><!-- /.row -->
	</div><!-- /.container -->
</main>
