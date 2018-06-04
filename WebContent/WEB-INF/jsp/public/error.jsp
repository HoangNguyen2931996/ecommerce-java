<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<title>Không tìm thấy trang</title>
		<meta name="description" content="Doodle is a Dashboard & Admin Site Responsive Template by hencework." />
		<meta name="keywords" content="admin, admin dashboard, admin template, cms, crm, Doodle Admin, Doodleadmin, premium admin templates, responsive admin, sass, panel, software, ui, visualization, web app, application" />
		<meta name="author" content="hencework"/>
		
		<!-- Favicon -->
		<link rel="shortcut icon" href="favicon.ico">
		<link rel="icon" href="favicon.ico" type="image/x-icon">
		<script src="${defines.URL_ADMIN }/js/jquery.min.js"></script>
		<!-- vector map CSS -->
		<link href="${defines.URL_ADMIN }/css/jasny-bootstrap.min.css" rel="stylesheet" type="text/css"/>
		
		
		
		<!-- Custom CSS -->
		<link href="${defines.URL_ADMIN }/css/style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<!--Preloader-->
		<div class="preloader-it">
			<div class="la-anim-1"></div>
		</div>
		<!--/Preloader-->
		
		<div class="wrapper error-page pa-0">
			<header class="sp-header">
				<div class="sp-logo-wrap pull-left">
					<a href="${pageContext.request.contextPath }/">
						<img class="brand-img mr-10" src="${defines.URL_ADMIN }/img/logo.png" alt="brand"/>
						<span class="brand-text">Smart Shop</span>
					</a>
				</div>
				<div class="form-group mb-0 pull-right">
					<a class="inline-block btn btn-info btn-rounded btn-outline nonecase-font" href="${pageContext.request.contextPath }/">Back to Home</a>
				</div>
				<div class="clearfix"></div>
			</header>
			
			<!-- Main Content -->
			<div class="page-wrapper pa-0 ma-0 error-bg-img">
				<div class="container-fluid">
					<!-- Row -->
					<div class="table-struct full-width full-height">
						<div class="table-cell vertical-align-middle auth-form-wrap">
							<div class="auth-form  ml-auto mr-auto no-float">
								<div class="row">
									<div class="col-sm-12 col-xs-12">
										<div class="mb-30">
											<span class="block error-head text-center txt-info mb-10">ERROR</span>
											<span class="text-center nonecase-font mb-20 block error-comment">Trang này không khả dụng</span>
											<p class="text-center">Liên kết bạn truy cập có thể bị hỏng hoặc trang có thể đã bị xóa.</p>
										</div>	
									</div>	
								</div>
							</div>
						</div>
					</div>
					<!-- /Row -->	
				</div>
				
			</div>
			<!-- /Main Content -->
		
		</div>
		<!-- /#wrapper -->
		
		<!-- JavaScript -->
		
		<!-- jQuery -->
		
		
		<!-- Bootstrap Core JavaScript -->
		<script src="${defines.URL_ADMIN }/js/bootstrap.min.js"></script>
		<script src="${defines.URL_ADMIN }/js/jasny-bootstrap.min.js"></script>
		
		<!-- Slimscroll JavaScript -->
		<script src="${defines.URL_ADMIN }/js/jquery.slimscroll.js"></script>
		
		<!-- Init JavaScript -->
		<script src="${defines.URL_ADMIN }/js/init.js"></script>
	</body>
</html>
