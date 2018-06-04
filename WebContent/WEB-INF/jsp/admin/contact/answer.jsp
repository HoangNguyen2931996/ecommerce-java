<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!-- <script type="text/javascript">
	$(document).ready(function (){
		$('#add_cat').validate({
			rules:{
				name_cat:{
					required: true,
					minlength: 4,
					maxlength: 15,
				},
			},
			messages:{
				name_cat:{
					required: "<p class='vali-error'>Vui lòng nhập tên danh mục</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
			}
		});
	});
</script> -->
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Phản hồi</h5>
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
							<form id="add_cat" action="${pageContext.request.contextPath }/admin/contact/answer/${objContact.id_contact }" method="post">
							<c:if test="${not empty msg }">
								<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-info-outline mr-10"></i>${msg }</h6>
								<hr class="light-grey-hr"/>
							</c:if>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Contact Name: </label>
											<input name="name_cat" type="text" id="firstName" class="form-control" value="${objContact.name }">
										</div>
									</div>
									<!--/span-->
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">To: </label>
											<input name="name_cat" type="text" id="firstName" class="form-control" value="${objContact.mail }">
										</div>
									</div>
									<!--/span-->
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Title: </label>
											<input name="title" type="text" id="firstName" class="form-control">
										</div>
									</div>
									<!--/span-->
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Content</label>
											<textarea name="content" class="form-control" rows="4"></textarea>
										</div>
									</div>
									<!--/span-->
								</div>
								<!--/row-->
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Send</span></button>
									<a class="btn btn-warning pull-left" href="${pageContext.request.contextPath }/admin/contact">Go back</a>
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
<script type="text/javascript">
	$(document).ready(function() {
		  $(".select2").select2();
		});
</script>