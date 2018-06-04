<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Thêm ảnh sản phẩm</h5>
		</div>
	</div>
	<!-- /Title -->
	
	<!-- Row -->
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default card-view">
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="form-wrap">
							<form action="${pageContext.request.contextPath }/admin/product/picture/add/${objProduct.id_product }" method="post" enctype="multipart/form-data">
							<c:if test="${not empty msg }">
								<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-info-outline mr-10"></i>${msg }</h6>
								<hr class="light-grey-hr"/>
							</c:if>
								<!-- Row -->
								
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Upload hình ảnh</label>
											<input type="file" id="input-file-now" name="picture" class="dropify"/>
										</div>
										<div class="form-group">
											<label class="control-label mb-10">Tên sản phẩm</label><br />
											<label class="control-label mb-10" style="font-weight: bold; font-size: 20px; color:red">${objProduct.name_product }</label>
										</div>
										
									</div>									
									<!--/span-->
								</div>
								
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Add</span></button>
									<a href="${pageContext.request.contextPath }/admin/product/picture/${objProduct.id_product}" type="button" class="btn btn-warning pull-left">Go back</a>
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
