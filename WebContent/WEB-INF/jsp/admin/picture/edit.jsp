<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Sửa ảnh sản phẩm</h5>
		</div>
		<!-- Breadcrumb -->
		<div class="col-lg-9 col-sm-8 col-md-8 col-xs-12">
		  <ol class="breadcrumb">
			<li><a href="index.html">Dashboard</a></li>
			<li><a href="#"><span>e-commerce</span></a></li>
			<li class="active"><span>Thêm sản phẩm</span></li>
		  </ol>
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
							<form action="${pageContext.request.contextPath }/admin/picture/edit/${objPicture.id_picture }" method="post" enctype="multipart/form-data">
								<!-- Row -->
								
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Ảnh cũ</label>
											<img class="form-control" style="width: 170px; height: 100px" alt="" src="${pageContext.request.contextPath }/files/${objPicture.name_picture}">
										</div>
										<div class="form-group">
											<label class="control-label mb-10">Upload hình ảnh</label>
											<input type="file" id="input-file-now" name="picture" class="dropify"/>
										</div>
										<div class="form-group">
											<label class="control-label mb-10">Tên sản phẩm</label>
											<select name="id_product" class="form-control select2" data-placeholder="Choose a brand" tabindex="1">
											<c:forEach items="${alProduct }" var="objProduct">
												<option <c:if test="${objPicture.id_product == objProduct.id_product }">selected="selected"</c:if> value="${objProduct.id_product }">${objProduct.name_product }</option>
											</c:forEach>
											</select>
										</div>
										
									</div>									
									<!--/span-->
								</div>
								
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Edit</span></button>
									<a href="${pageContext.request.contextPath }/admin/picture" type="button" class="btn btn-warning pull-left">Go back</a>
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