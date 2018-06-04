<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <footer id="footer" class="color-bg">
            <div class="ajaxcartmessage">
            	
            </div>
                <div class="container">
                	
                    <div class="row no-margin widgets-row">
                        <div class="col-xs-12  col-sm-4 no-margin-left">
                            <!-- ============================================================= FEATURED PRODUCTS ============================================================= -->
                            <div class="widget">
                                <h2>Sản phẩm nổi bật</h2>
                                <div class="body">
                                    <ul>
									<c:forEach items="${alProductTopHL }" var="objProductTopHL">                                   
                                        <li>
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-9 no-margin">
                                                    <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductTopHL.name_product) }-${objProductTopHL.id_product}.html">${objProductTopHL.name_product }</a>
                                                    <c:if test="${objProductTopHL.discount_product > 0 }">
                                                    <c:set var="curPrice" value="${stringUtils.currentPrice(objProductTopHL.price_product,objProductTopHL.discount_product) }"></c:set>
                                                    <div class="price">
                                                        <div class="price-prev">${stringUtils.changeMoney(objProductTopHL.price_product) }</div>
                                                        <div class="price-current">${stringUtils.changeMoney(curPrice) }</div>
                                                    </div>
                                                    </c:if>
                                                    <c:if test="${objProductTopHL.discount_product == 0 }">
                                                    	<div class="price-prev"></div>
                                                        <div class="price-current">${stringUtils.changeMoney(objProductTopHL.price_product) }</div>
                                                    </c:if>
                                                </div>
                                                <div class="col-xs-12 col-sm-3 no-margin">
                                                    <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductTopHL.name_product) }-${objProductTopHL.id_product}.html" class="thumb-holder">
                                                    <img style="width: 73px; height: 73px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductTopHL.picture_product}" />
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach> 
                                    </ul>
                                </div>
                                <!-- /.body -->
                            </div>
                            <!-- /.widget -->
                            <!-- ============================================================= FEATURED PRODUCTS : END ============================================================= -->            
                        </div>
                        <!-- /.col -->
                        <div class="col-xs-12 col-sm-4 ">
                            <!-- ============================================================= ON SALE PRODUCTS ============================================================= -->
                            <div class="widget">
                                <h2>Top giảm giá</h2>
                                <div class="body">
                                    <ul>
                                    <c:forEach items="${alProductTopSale }" var="objProductTopSale">                                   
                                        <li>
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-9 no-margin">
                                                    <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductTopSale.name_product) }-${objProductTopSale.id_product}.html">${objProductTopSale.name_product }</a>
                                                    <c:if test="${objProductTopSale.discount_product > 0 }">
                                                    <c:set var="curPrice" value="${stringUtils.currentPrice(objProductTopSale.price_product,objProductTopSale.discount_product) }"></c:set>
                                                    <div class="price">
                                                        <div class="price-prev">${stringUtils.changeMoney(objProductTopSale.price_product) }</div>
                                                        <div class="price-current">${stringUtils.changeMoney(curPrice) }</div>
                                                    </div>
                                                    </c:if>
                                                    <c:if test="${objProductTopSale.discount_product == 0 }">
                                                    	<div class="price-prev"></div>
                                                        <div class="price-current">${stringUtils.changeMoney(objProductTopSale.price_product) }</div>
                                                    </c:if>
                                                </div>
                                                <div class="col-xs-12 col-sm-3 no-margin">
                                                    <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductTopSale.name_product) }-${objProductTopSale.id_product}.html" class="thumb-holder">
                                                    <img style="width: 73px; height: 73px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductTopSale.picture_product}" />
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach> 
                                    </ul>
                                </div>
                                <!-- /.body -->
                            </div>
                            <!-- /.widget -->
                            <!-- ============================================================= ON SALE PRODUCTS : END ============================================================= -->            
                        </div>
                        <!-- /.col -->
                        <div class="col-xs-12 col-sm-4 ">
                            <!-- ============================================================= TOP RATED PRODUCTS ============================================================= -->
                            <div class="widget">
                                <h2>Top bán chạy</h2>
                                <div class="body">
                                    <ul>
                                    <c:forEach items="${alProductTopSell }" var="objProductTopSell">                                   
                                        <li>
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-9 no-margin">
                                                    <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductTopSell.name_product) }-${objProductTopSell.id_product}.html">${objProductTopSell.name_product }</a>
                                                    <c:if test="${objProductTopSell.discount_product > 0 }">
                                                    <c:set var="curPrice" value="${stringUtils.currentPrice(objProductTopSell.price_product,objProductTopSell.discount_product) }"></c:set>
                                                    <div class="price">
                                                        <div class="price-prev">${stringUtils.changeMoney(objProductTopSell.price_product) }</div>
                                                        <div class="price-current">${stringUtils.changeMoney(curPrice) }</div>
                                                    </div>
                                                    </c:if>
                                                    <c:if test="${objProductTopSell.discount_product == 0 }">
                                                    	<div class="price-prev"></div>
                                                        <div class="price-current">${stringUtils.changeMoney(objProductTopSell.price_product) }</div>
                                                    </c:if>
                                                </div>
                                                <div class="col-xs-12 col-sm-3 no-margin">
                                                    <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductTopSell.name_product) }-${objProductTopSell.id_product}.html" class="thumb-holder">
                                                    <img style="width: 73px; height: 73px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductTopSell.picture_product}" />
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>    
                                    </ul>
                                </div>
                                <!-- /.body -->
                            </div>
                            <!-- /.widget -->
                            <!-- ============================================================= TOP RATED PRODUCTS : END ============================================================= -->            
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.widgets-row-->
                </div>
                <!-- /.container -->
                <div class="copyright-bar">
                    <div class="container">
                        <div class="col-xs-12 col-sm-6 no-margin">
                            <div class="copyright">
                                &copy; <a href="index.html">Smart Shop</a> - Designed by Nguyễn Văn Hoàng
                            </div>
                            <!-- /.copyright -->
                        </div>
                        <div class="col-xs-12 col-sm-6 no-margin">
                            <div class="payment-methods ">
                                <ul>
                                    <li><img alt="" src="${defines.URL_PUBLIC }/images/payments/payment-visa.png"></li>
                                    <li><img alt="" src="${defines.URL_PUBLIC }/images/payments/payment-master.png"></li>
                                    <li><img alt="" src="${defines.URL_PUBLIC }/images/payments/payment-paypal.png"></li>
                                    <li><img alt="" src="${defines.URL_PUBLIC }/images/payments/payment-skrill.png"></li>
                                </ul>
                            </div>
                            <!-- /.payment-methods -->
                        </div>
                    </div>
                    <!-- /.container -->
                </div>
                <!-- /.copyright-bar -->
            </footer>
            <!-- /#footer -->
            <!-- ============================================================= FOOTER : END ============================================================= -->	
        </div>
        <!-- /.wrapper -->
        <!-- For demo purposes – can be removed on production -->
        <div class="config open">
            <div class="config-options">
                <h4>Colors</h4>
                <ul class="list-unstyled">
                    <li><a class="changecolor green-text" href="#" title="Green color">Green</a></li>
                    <li><a class="changecolor blue-text" href="#" title="Blue color">Blue</a></li>
                    <li><a class="changecolor red-text" href="#" title="Red color">Red</a></li>
                    <li><a class="changecolor orange-text" href="#" title="Orange color">Orange</a></li>
                    <li><a class="changecolor navy-text" href="#" title="Navy color">Navy</a></li>
                    <li><a class="changecolor dark-green-text" href="#" title="Darkgreen color">Dark Green</a></li>
                </ul>
            </div>
            <a class="show-theme-options" href="#"><i class="fa fa-wrench"></i></a>
        </div>
        <!-- For demo purposes – can be removed on production : End -->
        <!-- JavaScripts placed at the end of the document so the pages load faster -->
        
        <script src="${defines.URL_PUBLIC }/js/jquery-migrate-1.2.1.js"></script>
        <script src="${defines.URL_PUBLIC }/js/bootstrap.min.js"></script>
        <script src="http://maps.google.com/maps/api/js?sensor=false&amp;language=en"></script>
        <script src="${defines.URL_PUBLIC }/js/gmap3.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/bootstrap-hover-dropdown.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/owl.carousel.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/css_browser_selector.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/echo.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/jquery.easing-1.3.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/bootstrap-slider.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/jquery.raty.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/jquery.prettyPhoto.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/jquery.customSelect.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/wow.min.js"></script>
        <script src="${defines.URL_PUBLIC }/js/scripts.js"></script>
        <!-- For demo purposes – can be removed on production -->
        <script src="${defines.URL_PUBLIC }/js/switchstylesheet.js"></script>
        <script>
            $(document).ready(function(){ 
            	$(".changecolor").switchstylesheet( { seperator:"color"} );
            	$('.show-theme-options').click(function(){
            		$(this).parent().toggleClass('open');
            		return false;
            	});
            });
            
            $(window).bind("load", function() {
               $('.show-theme-options').delay(2000).trigger('click');
            });
            function loadCart(IdProduct){
	 				$.ajax({
					url: '${pageContext.request.contextPath }/loadCart',
					type: 'POST',
					cache: false,
					data: {
						idProduct: IdProduct,
					},
					success: function(data){
						$('#cart').html(data);
						$('.ajaxcartmessage').html("<div class='alert alert-success'>Đã thêm sản phẩm vào giỏ hàng</div>");
						$('.ajaxcartmessage').show();
						setTimeout(function(){
							$('.ajaxcartmessage').slideUp('slow');
						},3000);
					},
					error: function (){
					}
				});
	 		}
            function deleteItem(IdProduct){
				$.ajax({
					url: '${pageContext.request.contextPath }/deleteItem',
					type: 'POST',
					cache: false,
					dataType: "json",
					data: {
						idProduct: IdProduct,
					},
					success: function(data){
						$('#cart').html(data[0]);
   						$('#total_price').html(data[1]);
   						$('#row_'+IdProduct).remove();
   						$('.ajaxcartmessage').html("<div class='alert alert-success'>Đã xóa sản phẩm khỏi giỏ hàng</div>");
						$('.ajaxcartmessage').show();
						setTimeout(function(){
							$('.ajaxcartmessage').slideUp('slow');
						},3000);
					},
					error: function (){
					}
				});
 			}	
        </script>
        <!-- For demo purposes – can be removed on production : End -->
        <script src="http://w.sharethis.com/button/buttons.js"></script>
    </body>
</html>