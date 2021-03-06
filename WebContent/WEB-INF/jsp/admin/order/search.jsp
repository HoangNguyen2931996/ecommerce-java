<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container-fluid">
	
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">basic table</h5>
		</div>
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
						<div class="form-wrap mt-40">
							<form action="${pageContext.request.contextPath }/admin/order/search" method="post">
								<div class="row">
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">From: </label>
											<input name="from_date" type="date" class="form-control" value="2017-07-11">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">To: </label>
											<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
											<fmt:formatDate var="cur_date" value="${now }" pattern="yyyy-MM-dd"/>
											<input name="to_date" type="date" class="form-control" value="${cur_date }">
										</div>
									</div>
									<div class="col-md-3 mt-30">
										<div class="form-actions">
											<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <span>Search</span></button>
											<div class="clearfix"></div>
										</div>
									</div>
								</div>
							</form>
						</div>
						<div class="table-wrap mt-40">
							<div class="table-responsive">
							  <table class="table table-hover table-bordered mb-0">
								<thead>
								  <tr>
									<th>Username</th>
									<th>Name</th>
									<th>Address</th>
									<th>Phone</th>
									<th>Email</th>
									<th>More information</th>
									<th>Total Price</th>
									<th>Order date</th>
									<th>Phương thức thanh toán</th>
									<th class="text-nowrap">Chức năng</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach items="${alOrder }" var="objOrder">
									<c:set var="urlEdit" value="${pageContext.request.contextPath }/admin/order/view/${objOrder.id_order }"></c:set>
									<c:set var="urlDel" value="${pageContext.request.contextPath }/admin/order/del/${objOrder.id_order }"></c:set>
									<fmt:formatDate value="${objOrder.date_order }" pattern="HH:mm:ss dd/MM/yyy" var="fmDate"/>
									  <tr>
										<td>${objOrder.username }</td>
										<td>${objOrder.name_receiver }</td>
										<td>${objOrder.address_receiver }</td>
										<td>${objOrder.phone_receiver }</td>
										<td>${objOrder.email_receiver }</td>
										<td>${objOrder.more_infor } </td>
										<td>${objOrder.total_order }</td>
										<td>${fmDate }</td>
										<td>${objOrder.name_payment }</td>
										<td class="text-nowrap">
											<a href="${urlEdit }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="View"><i class="zmdi zmdi-eye txt-warning"></i></a>
											<a href="${urlDel }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="Delete"><i class="zmdi zmdi-delete txt-danger"></i></a>
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
