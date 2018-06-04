<%@page import="entities.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Meta -->
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta name="keywords" content="MediaCenter, Template, eCommerce">
        <meta name="robots" content="all">
        <title>MediaCenter - Responsive eCommerce Template</title>
        <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/bootstrap.min.css">
        <!-- Customizable CSS -->
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/main.css">
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/green.css">
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/owl.carousel.css">
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/owl.transitions.css">
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/animate.min.css">
        <!-- Demo Purpose Only. Should be removed in production -->
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/config.css">
        <link href="${defines.URL_PUBLIC }/css/green.css" rel="alternate stylesheet" title="Green color">
        <link href="${defines.URL_PUBLIC }/css/blue.css" rel="alternate stylesheet" title="Blue color">
        <link href="${defines.URL_PUBLIC }/css/red.css" rel="alternate stylesheet" title="Red color">
        <link href="${defines.URL_PUBLIC }/css/orange.css" rel="alternate stylesheet" title="Orange color">
        <link href="${defines.URL_PUBLIC }/css/navy.css" rel="alternate stylesheet" title="Navy color">
        <link href="${defines.URL_PUBLIC }/css/dark-green.css" rel="alternate stylesheet" title="Darkgreen color">
        <!-- Demo Purpose Only. Should be removed in production : END -->
        <!-- Fonts -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800' rel='stylesheet' type='text/css'>
        <!-- Icons/Glyphs -->
        <link rel="stylesheet" href="${defines.URL_PUBLIC }/css/font-awesome.min.css">
        <!-- Favicon -->
        <link rel="shortcut icon" href="${defines.URL_PUBLIC }/images/favicon.ico">
        <script src="${defines.URL_PUBLIC }/js/jquery-1.10.2.min.js"></script>
        <script src="${defines.URL_ADMIN}/js/jquery.validate.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="wrapper">
        <c:if test="${not empty objUser }">
            <!-- ============================================================= TOP NAVIGATION ============================================================= -->
			<nav class="top-bar animate-dropdown">
			    <div class="container">
			        <div class="col-xs-12 col-sm-6 no-margin">
			            <ul>
			                <li><a href="javascript:void(0)">Xin chào: ${objUser.fullname }</a></li>
			                <c:if test="${not empty success }">
			                	<li><a href="javascript:void(0)" style="color: red">Đã đặt hàng thành công</a></li>
			                </c:if>
			            </ul>
			        </div><!-- /.col -->
			
			        <div class="col-xs-12 col-sm-6 no-margin">
			            <ul class="right">
			            	<c:if test="${not empty objOrder }">
			            		<li><a href="${pageContext.request.contextPath }/view/${objOrder.id_order }">Đơn đặt hàng gần đây</a></li>
			            	</c:if>
			            	<li><a href="${pageContext.request.contextPath }/sua/${objUser.id_user}">Sửa tài khoản</a></li>
			                <li><a href="${pageContext.request.contextPath }/logout">Thoát</a></li>
			            </ul>
			        </div><!-- /.col -->
			    </div><!-- /.container -->
			</nav>
		</c:if>
            <!-- /.top-bar -->
            <!-- ============================================================= TOP NAVIGATION : END ============================================================= -->		<!-- ============================================================= HEADER ============================================================= -->
            <header class="no-padding-bottom header-alt">
                <div class="container no-padding">
                    <div class="col-xs-12 col-md-3 logo-holder">
                        <!-- ============================================================= LOGO ============================================================= -->
                        <div class="logo">
                            <a href="${pageContext.request.contextPath }">
                                <img alt="logo" src="${defines.URL_PUBLIC }/images/logo.png" style="width: 233px; height: 100px"/>
                            </a>
                        </div>
                        <!-- /.logo -->
                        <!-- ============================================================= LOGO : END ============================================================= -->		
                    </div>
                    <!-- /.logo-holder -->
                    <div class="col-xs-12 col-md-6 top-search-holder no-margin">
                        <div class="contact-row">
                            <div class="phone inline">
                                <i class="fa fa-phone"></i> 01692766061
                            </div>
                            <div class="contact inline">
                                <i class="fa fa-envelope"></i> nguyenvanhoang2931996@<span class="le-color">gmail.com</span>
                            </div>
                        </div>
                        <!-- /.contact-row -->
                        <!-- ============================================================= SEARCH AREA ============================================================= -->
                        <div class="search-area">
                            <form action="${pageContext.request.contextPath }/search" method="post">
                                <div class="control-group">
                                    <input name="key_word" class="search-field" placeholder="Search for item" />
                                    <button type="submit" class="search-button" ></button>    
                                </div>
                            </form>
                        </div>
                        <!-- /.search-area -->
                        <!-- ============================================================= SEARCH AREA : END ============================================================= -->		
                    </div>
                    <!-- /.top-search-holder -->
                    <div class="col-xs-12 col-md-3 top-cart-row no-margin">
                        <div class="top-cart-row-container">
                            <!-- ============================================================= SHOPPING CART DROPDOWN ============================================================= -->
                            <div class="top-cart-holder dropdown animate-dropdown">
                                <div class="basket" id="cart">
                                <c:if test="${empty alCart }">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <div class="basket-item-count">
                                            <span class="count">0</span>
                                            <img src="${defines.URL_PUBLIC }/images/icon-cart.png" alt="" />
                                        </div>
                                        <div class="total-price-basket"> 
                                            <span class="lbl">your cart:</span>
                                            <span class="total-price">
                                            <span class="value">0 VNĐ</span>
                                            </span>
                                        </div>
                                    </a>
                                </c:if>
                                <c:if test="${not empty alCart }">
                                	<c:set var="sumPrice" value="0"></c:set>
                                	<c:forEach items="${alCart }" var="objCart">
                                		<c:set var="sumPrice" value="${sumPrice+objCart.total_amount }"></c:set>
                                	</c:forEach>
                                
                                	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <div class="basket-item-count">
                                            <span class="count">${alCart.size() }</span>
                                            <img src="${defines.URL_PUBLIC }/images/icon-cart.png" alt="" />
                                        </div>
                                        <div class="total-price-basket"> 
                                            <span class="lbl">your cart:</span>
                                            <span class="total-price">
                                            <span class="value">${stringUtils.changeMoney(sumPrice) }</span>
                                            </span>
                                        </div>
                                    </a>
                                    
                                		<ul class="dropdown-menu">
                                		<c:forEach items="${alCart }" var="objCart">
	                                        <li>
	                                            <div class="basket-item">
	                                                <div class="row">
	                                                    <div class="col-xs-4 col-sm-4 no-margin text-center">
	                                                        <div class="thumb">
	                                                            <img style="width: 73px; height: 73px" alt="" src="${pageContext.request.contextPath }/files/${objCart.picture_product}" />
	                                                        </div>
	                                                    </div>
	                                                    <div class="col-xs-8 col-sm-8 no-margin">
	                                                        <div class="title">${objCart.name_product }</div>
	                                                        <div>Số lượng: <span style="font-weight: bold;color: red">${objCart.quantity }</span></div>
	                                                        <div class="price">${stringUtils.changeMoney(objCart.total_amount) }</div>
	                                                    </div>
	                                                </div>
	                                                <a class="close-btn" href="javascript:void(0)" onclick="return deleteItem(${objCart.id_product})"></a>
	                                            </div>
	                                        </li>
	                                    </c:forEach>
	                                    <li class="checkout">
                                            <div class="basket-item">
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-6">
                                                        <a href="${pageContext.request.contextPath }/cart" class="le-button inverse">View cart</a>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-6">
                                                        <a href="${pageContext.request.contextPath }/checkout" class="le-button">Checkout</a>
                                                    </div>
                                                </div>
                                            </div>
                                      	</li>
                                	</ul>
                                </c:if>
                                </div>
                                
                                <!-- /.basket -->
                            </div>
                            <!-- /.top-cart-holder -->
                        </div>
                        <!-- /.top-cart-row-container -->
                        <!-- ============================================================= SHOPPING CART DROPDOWN : END ============================================================= -->		
                    </div>
                    <!-- /.top-cart-row -->
                </div>
                <!-- /.container -->
                <!-- ========================================= NAVIGATION ========================================= -->
                <nav id="top-megamenu-nav" class="megamenu-vertical animate-dropdown">
                    <div class="container">
                        <div class="yamm navbar">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mc-horizontal-menu-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                </button>
                            </div>
                            <!-- /.navbar-header -->
                            <div class="collapse navbar-collapse" id="mc-horizontal-menu-collapse">
                                <ul class="nav navbar-nav">
                                	<li>
                                        <a href="${pageContext.request.contextPath }" >Trang chủ</a>
                                    </li>
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">Danh mục sản phẩm</a>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <div class="yamm-content">
                                                    <div class="row">
                                                    <c:forEach items="${alCat }" var="objCat">
                                                    <c:if test="${catDao.checkChild(objCat.id_cat).size()!=0 && objCat.id_parent == 0 }">
                                                        <div class="col-xs-12 col-sm-4">
                                                            <h2>${objCat.name_cat }</h2>
                                                            <ul>
                                                            <c:forEach items="${alCat }" var="objItem">
                                                            	<c:if test="${objItem.id_parent==objCat.id_cat }">
                                                                <li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objItem.name_cat)}-${objItem.id_cat }">${objItem.name_cat }</a></li>
                                                            	</c:if>
                                                            </c:forEach>
                                                            </ul>
                                                        </div>
                                                     </c:if>
                                                     <c:if test="${catDao.checkChild(objCat.id_cat).size()==0 && objCat.id_parent == 0 }">
                                                     	<div class="col-xs-12 col-sm-4">
                                                     		<h2><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objCat.name_cat)}-${objCat.id_cat }">${objCat.name_cat }</a></h2>
                                                     	</div>
                                                     </c:if>
                                                        <!-- /.col -->
                                                    </c:forEach>
                                                    </div>
                                                    <!-- /.row -->
                                                </div>
                                                <!-- /.yamm-content -->
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="dropdown hidden-md">
                                        <a href="javascript:void(0)" class="dropdown-toggle" data-hover="dropdown">Thương hiệu</a>
                                        <ul class="dropdown-menu">
                                        <c:forEach items="${alBrand }" var="objBrand">
                                            <li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objBrand.name_brand)}-${objBrand.id_brand }.php">${objBrand.name_brand }</a></li>
                                        </c:forEach>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath }/lien-he" class="dropdown-toggle">Liên hệ</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath }/login" class="dropdown-toggle">Đăng nhập</a>
                                    </li>
                                </ul>
                                <!-- /.navbar-nav -->
                            </div>
                            <!-- /.navbar-collapse -->
                        </div>
                        <!-- /.navbar -->
                    </div>
                    <!-- /.container -->
                </nav>
                <!-- /.megamenu-vertical -->
                <!-- ========================================= NAVIGATION : END ========================================= -->
                <div class="animate-dropdown">
                    <!-- ========================================= BREADCRUMB ========================================= -->
                    <div id="breadcrumb-alt">
                        <div class="container">
                            <div class="breadcrumb-nav-holder minimal">
                                <ul>
                                    <li class="breadcrumb-item current">
                                        <a href="${pageContext.request.contextPath }/">Home</a>
                                    </li>
                                    <!-- /.breadcrumb-item -->
                                    <c:if test="${not empty active1 }">
                                    <li class="breadcrumb-item">
                                        <a href="">${active1 }</a>
                                    </li>
                                    </c:if>
                                    <c:if test="${not empty active2 }">
                                    <li class="breadcrumb-item">
                                        <a href="">${active2 }</a>
                                    </li>
                                    </c:if>
                                    <!-- /.breadcrumb-item -->
                                </ul>
                                <!-- /.breadcrumb-nav-holder -->
                            </div>
                        </div>
                        <!-- /.container -->
                    </div>
                    <!-- ========================================= BREADCRUMB : END ========================================= -->
                </div>
            </header>