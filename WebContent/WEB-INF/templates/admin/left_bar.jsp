<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty access }">
<ul class="nav navbar-nav side-nav nicescroll-bar">
	<li class="navigation-header">
		<span>Main</span> 
		<i class="zmdi zmdi-more"></i>
	</li>

	<li><a href="${pageContext.request.contextPath }/admin"><div class="pull-left"><i class="zmdi zmdi-landscape mr-20"></i><span class="right-nav-text">Tổng quan</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/cat"><div class="pull-left"><i class="zmdi zmdi-apps mr-20"></i><span class="right-nav-text">Danh mục</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/brand"><div class="pull-left"><i class="zmdi zmdi-assignment-o mr-20"></i><span class="right-nav-text">Thương hiệu</span></div><div class="clearfix"></div></a></li>
	<li>
		<a href="javascript:void(0);" data-toggle="collapse" data-target="#dashboard_dr"><div class="pull-left"><i class="zmdi zmdi-shopping-basket mr-20"></i><span class="right-nav-text">Sản phẩm</span></div><div class="pull-right"><i class="zmdi zmdi-caret-down"></i></div><div class="clearfix"></div></a>
		<ul id="dashboard_dr" class="collapse collapse-level-1">
			<li>
				<a  href="${pageContext.request.contextPath }/admin/product"">Sản phẩm</a>
			</li>
			<li>
				<a  href="${pageContext.request.contextPath }/admin/picture"">Ảnh sản phẩm</a>
			</li>
		</ul>
	</li>	
	<li><a href="${pageContext.request.contextPath }/admin/user"><div class="pull-left"><i class="zmdi zmdi-accounts-alt mr-20"></i><span class="right-nav-text">Người dùng</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/order"><div class="pull-left"><i class="zmdi zmdi-wallpaper mr-20"></i><span class="right-nav-text">Đơn đặt hàng</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/slide"><div class="pull-left"><i class="zmdi zmdi-balance-wallet mr-20"></i><span class="right-nav-text">Slide sản phẩm</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/contact"><div class="pull-left"><i class="zmdi zmdi-calendar-account mr-20"></i><span class="right-nav-text">Liên hệ</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/review"><div class="pull-left"><i class="zmdi zmdi-comment-alert mr-20"></i><span class="right-nav-text">Đánh giá</span></div><div class="clearfix"></div></a></li>
	<li><a href="${pageContext.request.contextPath }/admin/payment"><div class="pull-left"><i class="zmdi zmdi-card mr-20"></i><span class="right-nav-text">Thanh toán</span></div><div class="clearfix"></div></a></li>
</ul>
</c:if>