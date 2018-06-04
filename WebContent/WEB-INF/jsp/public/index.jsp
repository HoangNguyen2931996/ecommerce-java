<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <div id="top-banner-and-menu">
     <div class="container">
         <div class="col-xs-12 col-sm-4 col-md-3 sidemenu-holder">
             <!-- ================================== TOP NAVIGATION ================================== -->
             <div class="side-menu animate-dropdown">
                 <div class="head"><i class="fa fa-list"></i>Danh mục sản phẩm</div>
                 <nav class="yamm megamenu-horizontal" role="navigation">
                     <ul class="nav">
                     <c:forEach items="${alCat }" var="objCat">
                     <c:if test="${catDao.checkChild(objCat.id_cat).size()!=0 && objCat.id_parent == 0 }">
                         <li class="dropdown menu-item">
                             <a href="" class="dropdown-toggle" data-toggle="dropdown">${objCat.name_cat }</a>
                             <ul class="dropdown-menu mega-menu">
                                 <li class="yamm-content">
                                     <div class="row">
                                         <div class="col-md-12">
                                             <ul class="list-unstyled">
                                             <c:forEach items="${alCat }" var="objItem">
                                             	<c:if test="${objItem.id_parent==objCat.id_cat }">
                                                 <li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objItem.name_cat)}-${objItem.id_cat }">${objItem.name_cat }</a></li>
                                                </c:if>
                                             </c:forEach>
                                             </ul>
                                         </div>
                                        
                                     </div>
                                 </li>
                             </ul>
                         </li>
                     </c:if>
					 <c:if test="${catDao.checkChild(objCat.id_cat).size()==0 && objCat.id_parent == 0 }">
                         <li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objCat.name_cat)}-${objCat.id_cat }">${objCat.name_cat }</a></li>
                     </c:if>
                     </c:forEach>
                     </ul>
                     <!-- /.nav -->
                 </nav>
                 <!-- /.megamenu-horizontal -->
             </div>
             <!-- /.side-menu -->
             <!-- ================================== TOP NAVIGATION : END ================================== -->		
         </div>
         <!-- /.sidemenu-holder -->
         <div class="col-xs-12 col-sm-8 col-md-9 homebanner-holder">
             <!-- ========================================== SECTION – HERO ========================================= -->
             <div id="hero">
                 <div id="owl-main" class="owl-carousel owl-inner-nav owl-ui-sm">
                 <c:forEach items="${alSlide }" var="objSlide">
                     <div class="item" style="background-image: url(${pageContext.request.contextPath}/files/${objSlide.pic_slide }); background-size: 1920px 953px;">
                         <div class="container-fluid">
                             <div class="caption vertical-center text-left">
                             <c:if test="${objSlide.discount_product > 0 }">
                             <c:set var="curPrice" value="${stringUtils.currentPrice(objSlide.price_product,objSlide.discount_product) }"></c:set>
                                 <div class="big-text fadeInDown-1">
                                    Tiết kiệm đến<span class="big"><span class="sign">${stringUtils.changeMoney(objSlide.price_product-curPrice) }</span>
                                 </div>
                             </c:if>
                                 <div class="excerpt fadeInDown-2">
                                     ${objSlide.name_product }
                                 </div>
                                 <div class="small fadeInDown-2">
                                     ${objSlide.des_slide }
                                 </div>
                                 <div class="button-holder fadeInDown-3">
                                     <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objSlide.name_product) }-${objSlide.id_product}.html" class="big le-button ">shop now</a>
                                 </div>
                             </div>
                             <!-- /.caption -->
                         </div>
                         <!-- /.container-fluid -->
                     </div>
                 </c:forEach>
                     <!-- /.item -->
                 </div>
                 <!-- /.owl-carousel -->
             </div>
             <!-- ========================================= SECTION – HERO : END ========================================= -->			
         </div>
         <!-- /.homebanner-holder -->
     </div>
     <!-- /.container -->
 </div>
 <!-- /#top-banner-and-menu -->
 <!-- ========================================= HOME BANNERS ========================================= -->

 <!-- /#banner-holder -->
 <!-- ========================================= HOME BANNERS : END ========================================= -->
 <div id="products-tab" class="wow fadeInUp">
     <div class="container">
         <div class="tab-holder">
             <!-- Nav tabs -->
             <ul class="nav nav-tabs" >
                 <li class="active"><a href="#featured" data-toggle="tab">Nổi bật</a></li>
                 <li><a href="#new-arrivals" data-toggle="tab">Mới về</a></li>
                 <li><a href="#top-sales" data-toggle="tab">Giảm giá</a></li>
             </ul>
             <!-- Tab panes -->
             <div class="tab-content">
                 <div class="tab-pane active" id="featured">
                     <div class="product-grid-holder">
                     <c:set var="id_lastProduct" value="0"></c:set>
                     <c:forEach items="${alProductByHL }" var="objProductByHL">
                         <div class="col-sm-4 col-md-3  no-margin product-item-holder hover">
                             <div class="product-item">
                             <c:if test="${objProductByHL.discount_product > 0 }">
                                 <div class="ribbon red"><span>sale</span></div>
                             </c:if>
                                 <div class="image">
                                     <img style="width: 246px; height: 186px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductByHL.picture_product}" />
                                 </div>
                                 <div class="body">
                                 <c:if test="${objProductByHL.discount_product > 0 }">
                                     <div class="label-discount green">-${objProductByHL.discount_product }% sale</div>
                                 </c:if>
                                     <div class="title">
                                         <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductByHL.name_product) }-${objProductByHL.id_product}.html">${objProductByHL.name_product }</a>
                                     </div>
                                     <div class="brand">${objProductByHL.name_brand }</div>
                                 </div>
                                 <div class="prices">
                                 <c:if test="${objProductByHL.discount_product > 0 }">
                                 	<c:set var="curPrice" value="${stringUtils.currentPrice(objProductByHL.price_product,objProductByHL.discount_product) }"></c:set>
                                     <div class="price-prev">${stringUtils.changeMoney(objProductByHL.price_product) }</div>
                                     <div class="price-current pull-right">${stringUtils.changeMoney(curPrice) }</div>
                                 </c:if>
                                 <c:if test="${objProductByHL.discount_product == 0 }">
                                 	<div class="price-prev"></div>
                                 	<div class="price-current pull-right">${stringUtils.changeMoney(objProductByHL.price_product) }</div>
                                 </c:if>
                                 </div>
                                 <div class="hover-area">
                                     <div class="add-cart-button">
                                         <a href="javascript:void(0)" class="le-button" onclick="return loadCart(${objProductByHL.id_product})">add to cart</a>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <c:set var="id_lastProduct" value="${objProductByHL.id_product }"></c:set>
                         </c:forEach>
                     </div>
                 	<c:if test="${alProductByHL.size()==4 }">
                     <div class="loadmore-holder text-center" id="remove_row">
                         <a class="btn-loadmore" href="javascript:void(0)" onclick="return loadMoreHL(${id_lastProduct })">
                         <i class="fa fa-plus"></i>
                         <span id="btn_more">load more products</span></a>
                     </div>
                     </c:if>
                 </div>
      	          <script type="text/javascript">
                 function loadMoreHL(id_lastProduct){
                	 	$('#btn_more').html('Loading...');
	 	 				$.ajax({
							url: '${pageContext.request.contextPath }/loadMoreHL',
							type: 'POST',
							cache: false,
							
							data: {
								Id_lastProduct: id_lastProduct,
							},
							success: function(data){
								if(data != ""){
									$('#remove_row').remove();
									$('#featured').append(data);
								}
							},
							error: function (){
							}
						});
			 	}
                 </script>
                 <div class="tab-pane" id="new-arrivals">
                     <div class="product-grid-holder">
                     <c:forEach items="${alProductNew }" var="objProductNew">
                         <div class="col-sm-4 col-md-3 no-margin product-item-holder hover">
                             <div class="product-item">
                                 <c:if test="${objProductNew.discount_product > 0 }">
                                 		<div class="ribbon red"><span>sale</span></div>
                             		</c:if>
                                 <div class="image">
                                     <img style="width: 246px; height: 186px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductNew.picture_product }" />
                                 </div>
                                 <div class="body">
                                     <c:if test="${objProductNew.discount_product > 0 }">
                                     	<div class="label-discount green">-${objProductNew.discount_product }% sale</div>
                                 	</c:if>
                                     <div class="title">
                                         <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductNew.name_product) }-${objProductNew.id_product}.html">${objProductNew.name_product }</a>
                                     </div>
                                     <div class="brand">${objProductNew.name_brand }</div>
                                 </div>
                                 <div class="prices">
                                    <c:if test="${objProductNew.discount_product > 0 }">
                                 	<c:set var="curPrice" value="${stringUtils.currentPrice(objProductNew.price_product,objProductNew.discount_product) }"></c:set>
                                     <div class="price-prev">${stringUtils.changeMoney(objProductNew.price_product) }</div>
                                     <div class="price-current pull-right">${stringUtils.changeMoney(curPrice) }</div>
                                 	</c:if>
	                                 <c:if test="${objProductNew.discount_product == 0 }">
	                                 	<div class="price-prev"></div>
	                                 	<div class="price-current pull-right">${stringUtils.changeMoney(objProductNew.price_product) }</div>
	                                 </c:if> 
                                 </div>
                                 <div class="hover-area">
                                     <div class="add-cart-button">
                                         <a href="javascript:void(0)" class="le-button" onclick="return loadCart(${objProductNew.id_product})">add to cart</a>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </c:forEach>    
                     </div>
                     <c:if test="${alProductNew.size()==4 }">
                     <div class="loadmore-holder text-center" id="remove_row_new">
                         <a class="btn-loadmore" href="javascript:void(0)" onclick="return loadMoreNew(4)">
                         <i class="fa fa-plus" id="btn_more_new"></i>
                         load more products</a>
                     </div>
                     </c:if>
                 </div>
                 <script type="text/javascript">
                 function loadMoreNew(offset){
                	 	$('#btn_more_new').html('Loading...');
	 	 				$.ajax({
							url: '${pageContext.request.contextPath }/loadMoreNew',
							type: 'POST',
							cache: false,
							data: {
								Offset: offset,
							},
							success: function(data){
								if(data != ""){
									$('#remove_row_new').remove();
									$('#new-arrivals').append(data);
								}
							},
							error: function (){
							}
						});
			 		}
                 </script>
                 <div class="tab-pane" id="top-sales">
                     <div class="product-grid-holder">
                     <c:forEach items="${alProductByDis }" var="objProductByDis">
                         <div class="col-sm-4 col-md-3 no-margin product-item-holder hover">
                             <div class="product-item">
                                 <c:if test="${objProductByDis.discount_product > 0 }">
                                 	<div class="ribbon red"><span>sale</span></div>
                            	 </c:if>
                                 
                                 <div class="image">
                                     <img style="width: 246px; height: 186px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductByDis.picture_product }" />
                                 </div>
                                 <div class="body">
                                     <c:if test="${objProductByDis.discount_product > 0 }">
                                     <div class="label-discount green">-${objProductByDis.discount_product }% sale</div>
                                 	</c:if>
                                     <div class="title">
                                         <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductByDis.name_product) }-${objProductByDis.id_product}.html">${objProductByDis.name_product }</a>
                                     </div>
                                     <div class="brand">${objProductByDis.name_brand }</div>
                                 </div>
                                 <div class="prices">
                                     <c:if test="${objProductByDis.discount_product > 0 }">
                                 	<c:set var="curPrice" value="${stringUtils.currentPrice(objProductByDis.price_product,objProductByDis.discount_product) }"></c:set>
                                     <div class="price-prev">${stringUtils.changeMoney(objProductByDis.price_product) }</div>
                                     <div class="price-current pull-right">${stringUtils.changeMoney(curPrice) }</div>
                                 </c:if>
                                 <c:if test="${objProductByDis.discount_product == 0 }">
                                 	<div class="price-prev"></div>
                                 	<div class="price-current pull-right">${stringUtils.changeMoney(objProductByDis.price_product) }</div>
                                 </c:if> 
                                 </div>
                                 <div class="hover-area">
                                     <div class="add-cart-button">
                                         <a href="javascript:void(0)" class="le-button" onclick="return loadCart(${objProductByDis.id_product})">add to cart</a>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </c:forEach>    
                     </div>
                     <c:if test="${alProductByDis.size()==4 }">
                     <div class="loadmore-holder text-center" id="remove_row_sale">
                         <a class="btn-loadmore" href="javascript:void(0)" onclick="return loadMoreDis(4)" >
                         <i class="fa fa-plus" id="btn_more_sale"></i>
                         load more products</a>
                     </div>
                     </c:if>
                 </div>
                 <script type="text/javascript">
                 function loadMoreDis(offset){
                	 	$('#btn_more_sale').html('Loading...');
	 	 				$.ajax({
							url: '${pageContext.request.contextPath }/loadMoreDis',
							type: 'POST',
							cache: false,
							data: {
								Offset: offset,
							},
							success: function(data){
								if(data != ""){
									$('#remove_row_sale').remove();
									$('#top-sales').append(data);
								}
							},
							error: function (){
							}
						});
			 		}
                 </script>
             </div>
         </div>
     </div>
 </div>
 <section id="recently-reviewd" class="wow fadeInUp">
     <div class="container">
         <div class="carousel-holder hover">
             <div class="title-nav">
                 <h2 class="h1">Bán chạy nhất</h2>
                 <div class="nav-holder">
                     <a href="#prev" data-target="#owl-recently-viewed" class="slider-prev btn-prev fa fa-angle-left"></a>
                     <a href="#next" data-target="#owl-recently-viewed" class="slider-next btn-next fa fa-angle-right"></a>
                 </div>
             </div>
             <!-- /.title-nav -->
             <div id="owl-recently-viewed" class="owl-carousel product-grid-holder">
             <c:forEach items="${alProductSeller }" var="objProductSeller">
                 <div class="no-margin carousel-item product-item-holder size-small hover">
                     <div class="product-item">
                     <c:if test="${objProductSeller.discount_product > 0 }">
                         <div class="ribbon red"><span>sale</span></div>
                     </c:if>
                         <div class="image">
                             <img style="width: 194px; height: 143px;" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductSeller.picture_product}" />
                         </div>
                         <div class="body">
                             <div class="title">
                                 <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductSeller.name_product) }-${objProductSeller.id_product}.html">${objProductSeller.name_product }</a>
                             </div>
                             <div class="brand">${objProductSeller.name_brand }</div>
                         </div>
                      <c:if test="${objProductSeller.discount_product > 0 }">
                         <c:set var="curPrice" value="${stringUtils.currentPrice(objProductSeller.price_product,objProductSeller.discount_product) }"></c:set>
                         <div class="prices">
                             <div class="price-current text-right">${stringUtils.changeMoney(curPrice) }</div>
                         </div>
                      </c:if>
                      <c:if test="${objProductSeller.discount_product == 0 }">
                      	<div class="prices">
                             <div class="price-current text-right">${stringUtils.changeMoney(objProductSeller.price_product) }</div>
                         </div>
                      </c:if>
                         <div class="hover-area">
                             <div class="add-cart-button">
                                 <a href="javascript:void(0)" class="le-button" onclick="return loadCart(${objProductSeller.id_product})">Add to Cart</a>
                             </div>
                         </div>
                     </div>
                     <!-- /.product-item -->
                 </div>
            </c:forEach>
                 <!-- /.product-item-holder -->
             </div>
             <!-- /#recently-carousel -->
         </div>
         <!-- /.carousel-holder -->
     </div>
     <!-- /.container -->
 </section>
 <!-- /#recently-reviewd -->
 <!-- ========================================= RECENTLY VIEWED : END ========================================= -->
 <!-- ========================================= TOP BRANDS ========================================= -->
 <section id="top-brands" class="wow fadeInUp">
     <div class="container">
         <div class="carousel-holder" >
             <div class="title-nav">
                 <h1>Các thương hiệu</h1>
                 <div class="nav-holder">
                     <a href="#prev" data-target="#owl-brands" class="slider-prev btn-prev fa fa-angle-left"></a>
                     <a href="#next" data-target="#owl-brands" class="slider-next btn-next fa fa-angle-right"></a>
                 </div>
             </div>
             <!-- /.title-nav -->
             <div id="owl-brands" class="owl-carousel brands-carousel">
             <c:forEach items="${alBrand }" var="objBrand">
                 <div class="carousel-item">
                     <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objBrand.name_brand)}-${objBrand.id_brand }.php">
                     <img style="height: 75px;" alt="" src="${pageContext.request.contextPath }/files/${objBrand.picture_brand }" />
                     </a>
                 </div>
             </c:forEach>
                 <!-- /.carousel-item -->
             </div>
             <!-- /.brands-caresoul -->
         </div>
         <!-- /.carousel-holder -->
     </div>
     <!-- /.container -->
 </section>
