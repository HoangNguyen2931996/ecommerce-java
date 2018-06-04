<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<title>Smart Shop</title>
		<meta name="description" content="Doodle is a Dashboard & Admin Site Responsive Template by hencework." />
		<meta name="keywords" content="admin, admin dashboard, admin template, cms, crm, Doodle Admin, Doodleadmin, premium admin templates, responsive admin, sass, panel, software, ui, visualization, web app, application" />
		<meta name="author" content="hencework"/>	
		<!-- Favicon -->
		<link rel="shortcut icon" href="${defines.URL_ADMIN }/img/favicon.ico">
		<link rel="icon" href="${defines.URL_ADMIN }/img/favicon.ico" type="image/x-icon">
		<!-- select2 CSS -->
		<link href="${defines.URL_ADMIN }/css/select2.min.css" rel="stylesheet" type="text/css"/>

		<!-- Custom CSS -->
		<link href="${defines.URL_ADMIN }/css/style.css" rel="stylesheet" type="text/css">
		<!-- jQuery -->
		
		<script src="${defines.URL_ADMIN }/js/jquery.min.js"></script>
		
		<script src="${defines.URL_ADMIN}/js/jquery.validate.min.js" type="text/javascript"></script>
		<!-- Bootstrap Core JavaScript -->
		<script src="${defines.URL_ADMIN }/js/bootstrap.min.js"></script>
		<script src="${defines.URL_ADMIN}/js/ckeditor/ckeditor.js" type="text/javascript"></script>
		<script src="${defines.URL_ADMIN}/js/ckfinder/ckfinder.js" type="text/javascript"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	</head>
	<body>
		<!--Preloader-->
		<div class="preloader-it">
			<div class="la-anim-1"></div>
		</div>
		<!--/Preloader-->
		<div class="wrapper theme-4-active pimary-color-red">
			<!-- Top Menu Items -->
			<nav class="navbar navbar-inverse navbar-fixed-top">
				<div class="mobile-only-brand pull-left">
					<div class="nav-header pull-left">
						<div class="logo-wrap">
							<a href="index.html">
								<img class="brand-img" src="${defines.URL_ADMIN }/img/logo.png" alt="brand"/>
								<span class="brand-text">Smart shop</span>
							</a>
						</div>
					</div>	
					<a id="toggle_nav_btn" class="toggle-left-nav-btn inline-block ml-20 pull-left" href="javascript:void(0);"><i class="zmdi zmdi-menu"></i></a>
					<a id="toggle_mobile_search" data-toggle="collapse" data-target="#search_form" class="mobile-only-view" href="javascript:void(0);"><i class="zmdi zmdi-search"></i></a>
					<a id="toggle_mobile_nav" class="mobile-only-view" href="javascript:void(0);"><i class="zmdi zmdi-more"></i></a>
				</div>
				<div id="mobile_only_nav" class="mobile-only-nav pull-right">
					<ul class="nav navbar-right top-nav pull-right">
						<li>
							<a href="${pageContext.request.contextPath }/logout"><i class="zmdi zmdi-power-off-setting top-nav-icon"></i></a>
						</li>
					</ul>
				</div>	
			</nav>