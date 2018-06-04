<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container-fluid">
	
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Phương thức thanh toán</h5>
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
							<a class="btn btn-success btn-anim" href="${pageContext.request.contextPath }/admin/payment/add">
								<span>Add</span>
							</a>
						</p>
						<div class="table-wrap mt-40">
							<div class="table-responsive">
							 	<table class="table table-hover table-bordered mb-0 tree">
								<thead>
								  <tr>
									<th>Tên phương thức</th>
									<th class="text-nowrap">Chức năng</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach items="${alPayment }" var="objPayment">
								<c:set var="urlEdit" value="${pageContext.request.contextPath }/admin/payment/edit/${objPayment.id_payment }"></c:set>
								<c:set var="urlDel" value="${pageContext.request.contextPath }/admin/payment/del/${objPayment.id_payment }"></c:set>
								  <tr>
									<td>${objPayment.name_payment }</td>
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
				</div>
			</div>
		</div>
		<!-- /Bordered Table -->
		
	</div>
	
</div>
<script type="text/javascript" src="${defines.URL_ADMIN }/js/jquery.treegrid.min.js"></script>
<script type="text/javascript" src="${defines.URL_ADMIN }/js/jquery.treegrid.bootstrap3.js"></script>
<script type="text/javascript">

$(document).ready(function() {
    $('.tree').treegrid({
    	
    	expanderExpandedClass: 'glyphicon glyphicon-minus',
        expanderCollapsedClass: 'glyphicon glyphicon-plus',
      'initialState': 'collapsed',
    });
  });
</script>