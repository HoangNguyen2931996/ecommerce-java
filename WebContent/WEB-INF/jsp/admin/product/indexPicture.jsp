<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container-fluid">
	
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Ảnh sản phẩm</h5>
		</div>
		<!-- Breadcrumb -->
		
		<!-- /Breadcrumb -->
	</div>
	<!-- /Title -->
	<div class="row">
		<!-- Bordered Table -->
		<div class="col-sm-12">
			<div class="panel panel-default card-view">						
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<c:if test="${not empty msg }">
							<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-info-outline mr-10"></i>${msg }</h6>
							<hr class="light-grey-hr"/>
						</c:if>
						<p class="text-muted">
							<a class="btn btn-success btn-anim" href="${pageContext.request.contextPath }/admin/product/picture/add/${idProduct }">
								<span>Add</span>
							</a>
						</p>
						<div class="table-wrap mt-40">
							<div class="table-responsive">
							  <table class="table table-hover table-bordered mb-0">
								<thead>
								  <tr>
									<th>ID</th>
									<th>Hình ảnh</th>
									<th>Tên sản phẩm</th>
									<th class="text-nowrap">Action</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach items="${alPicture }" var="objPicture">
									<c:set var="urlEdit" value="${pageContext.request.contextPath }/admin/product/picture/edit/${objPicture.id_picture }"></c:set>
									<c:set var="urlDel" value="${pageContext.request.contextPath }/admin/product/picture/del/${objPicture.id_picture }"></c:set>
									  <tr>
										<td>${objPicture.id_picture }</td>
										<td><a href="${urlEdit }"><img style="width: 170px; height: 100px" alt="" src="${pageContext.request.contextPath }/files/${objPicture.name_picture }" /></a></td>
										<td>${objPicture.name_product }</td>
										<td class="text-nowrap">
											<a href="${urlEdit }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="Edit"><i class="zmdi zmdi-edit txt-warning"></i></a>
											<a href="${urlDel }" class="text-inverse" title="" data-toggle="tooltip" data-original-title="Delete"><i class="zmdi zmdi-delete txt-danger"></i></a>
										</td>
									  </tr>
								</c:forEach>
								</tbody>
							  </table>
							</div>
						</div>
					</div>
					<div class="form-actions mb-20" >
						<a href="${pageContext.request.contextPath }/admin/product" type="button" class="btn btn-warning pull-left">Go back</a>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Bordered Table -->
		
	</div>
	
</div>
