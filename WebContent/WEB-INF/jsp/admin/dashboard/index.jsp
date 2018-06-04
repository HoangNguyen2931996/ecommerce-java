<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	input[value="Xóa"]{color: red;}
</style>
<div class="container-fluid">
	
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Tổng quan</h5>
		</div>
		<!-- /Breadcrumb -->
	</div>
	<!-- /Title -->
	<div class="row">
		<!-- Bordered Table -->
		<div class="col-sm-12">
			<div class="panel panel-default card-view">						
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="form-wrap mt-40">
							<div class="row">
								<div class="col-md-6">
									<div id="piechart"></div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label mb-10"><a href="${pageContext.request.contextPath }/admin/order/view/${objNewOrder.id_order }">Đơn đặt hàng mới: ${objNewOrder.name_receiver }</a></label>
									</div>
									<div class="form-group">
										<label class="control-label mb-10"><a href="${pageContext.request.contextPath }/admin/contact/view/${objNewContact.id_contact }">Liên hệ mới: ${objNewContact.name }</a></label>
									</div>
									<div class="form-group">
										<label class="control-label mb-10"><a href="${pageContext.request.contextPath }/admin/review/view/${objNewReview.id_review }">Đánh giá mới: ${objNewReview.name }</a></label>
									</div>
									<div class="form-group">
										<label class="control-label mb-10"><a href="${pageContext.request.contextPath }/admin/user/edit/${objNewUser.id_user }">Người dùng mới: ${objNewUser.fullname }</a></label>
									</div>
									<div class="form-actions">
									<a class="btn btn-success pull-left mr-10 mt-10" href="${pageContext.request.contextPath }/admin/cat">Danh mục</a>
									<a class="btn btn-success pull-left mr-10 mt-10" href="${pageContext.request.contextPath }/admin/brand">Thương hiệu</a>
									<a class="btn btn-success pull-left mr-10 mt-10" href="${pageContext.request.contextPath }/admin/product">Sản phẩm</a>
									<a class="btn btn-success pull-left mr-10 mt-10" href="${pageContext.request.contextPath }/admin/user">Người dùng</a>
									<a class="btn btn-success pull-left mr-10 mt-10" href="${pageContext.request.contextPath }/admin/order">Đơn hàng</a>
									<div class="clearfix"></div>
								</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div id="piechartcol"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Bordered Table -->
	</div>
	<script type="text/javascript">
		// Load google charts
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		// Draw the chart and set the chart values
		function drawChart() {
		  var data = google.visualization.arrayToDataTable([
		  ['Tên thương hiệu', 'Số lượng'],
		  <c:forEach var="objChart" items="${alChartBrand}">['${objChart.name}',${objChart.value}],</c:forEach>
		]);
		  // Optional; add a title and set the width and height of the chart
		  var options = {'title':'Biểu đồ thống kê sản phẩm theo thương hiệu', 'width':550, 'height':400};
		
		  // Display the chart inside the <div> element with id="piechart"
		  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		  chart.draw(data, options);
		}
	</script>
	<script type="text/javascript">
	function drawChart() {
		   // Define the chart to be drawn.
		   var data = google.visualization.arrayToDataTable([
		      ['Danh mục', 'Số lượng'],
		      <c:forEach var="objChart" items="${alChartCat}">['${objChart.name}',${objChart.value}],</c:forEach>
		   ]);

		   var options = {
		      title: 'Biểu đồ thống kê sản phẩm theo danh mục',
		      height: 400
		   }; 

		   // Instantiate and draw the chart.
		   var chart = new google.visualization.ColumnChart(document.getElementById('piechartcol'));
		   chart.draw(data, options);
		}
		google.charts.setOnLoadCallback(drawChart);
	</script>
</div>
