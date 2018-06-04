<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript">
	$(document).ready(function (){
		$('#edit_brand').validate({
			rules:{
				name_brand:{
					required: true,
					minlength: 4,
					maxlength: 15,
				},
			},
			messages:{
				name_brand:{
					required: "<p class='vali-error'>Vui lòng nhập tên nhà sản xuất</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
			}
		});
	});
</script>
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Thêm hãng sản xuất</h5>
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
							<form id="edit_brand" action="${pageContext.request.contextPath }/admin/brand/edit/${objBrand.id_brand }" method="post" enctype="multipart/form-data">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Hãng sản xuất</label>
											<input name="name_brand" type="text" id="firstName" class="form-control" placeholder="Tên hãng" value="${objBrand.name_brand }">
											<form:errors path="objBrand.name_brand" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
									<!--/span-->
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10 text-left">Mô tả</label>
											<textarea name="des_brand" class="form-control" rows="5" placeholder="Mô tả ngắn về hãng sản xuất">${objBrand.des_brand }</textarea>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Ảnh cũ</label>
											<img class="form-control" style="width: 170px; height: 100px" alt="" src="${pageContext.request.contextPath }/files/${objBrand.picture_brand }">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Upload ảnh mới</label>
											<input class="form-control" type="file" id="input-file-now" name="picture"/>
										</div>
									</div>
								</div>
								<!--/row-->
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Edit</span></button>
									<a class="btn btn-warning pull-left" href="${pageContext.request.contextPath }/admin/brand">Go back</a>
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