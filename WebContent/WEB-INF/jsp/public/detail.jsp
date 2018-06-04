<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<div id="single-product">
                <div class="container">
                    <div class="no-margin col-xs-12 col-sm-6 col-md-5 gallery-holder">
                        <div class="product-item-holder size-big single-product-gallery small-gallery">
                            <div id="owl-single-product">
                                <div class="single-product-gallery-item" id="slide1">
                                    <a data-rel="prettyphoto" href="">
                                    <img style="width: 433px; height: 325px" class="img-responsive" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProduct.picture_product}" />
                                    </a>
                                </div>
                                <!-- /.single-product-gallery-item -->
                                <c:forEach items="${alPicture }" var="objPicture">
                                <div class="single-product-gallery-item" id="slide2">
                                    <a data-rel="prettyphoto" href="${pageContext.request.contextPath }/files/${objPicture.name_picture}">
                                    <img style="width: 433px; height: 325px" class="img-responsive" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objPicture.name_picture}" />
                                    </a>
                                </div>
                                </c:forEach>
                                <!-- /.single-product-gallery-item -->
                            </div>
                            <!-- /.single-product-slider -->
                            <div class="single-product-gallery-thumbs gallery-thumbs">
                                <div id="owl-single-product-thumbnails">
                                    <a class="horizontal-thumb active" data-target="#owl-single-product" data-slide="0" href="#slide1">
                                    <img style="width: 76px; height: 60px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProduct.picture_product}" />
                                    </a>
                                  <c:set var="i" value="0"></c:set>
                                  <c:forEach items="${alPicture }" var="objPicture">  
                                    <a class="horizontal-thumb" data-target="#owl-single-product" data-slide="${i+1 }" href="#slide2">
                                     <img style="width: 76px; height: 60px" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objPicture.name_picture}" />
                                    </a>
                                    <c:set var="i" value="${i+1 }"></c:set>
                                  </c:forEach> 
                                </div>
                                <!-- /#owl-single-product-thumbnails -->
                                <div class="nav-holder left hidden-xs">
                                    <a class="prev-btn slider-prev" data-target="#owl-single-product-thumbnails" href="#prev"></a>
                                </div>
                                <!-- /.nav-holder -->
                                <div class="nav-holder right hidden-xs">
                                    <a class="next-btn slider-next" data-target="#owl-single-product-thumbnails" href="#next"></a>
                                </div>
                                <!-- /.nav-holder -->
                            </div>
                            <!-- /.gallery-thumbs -->
                        </div>
                        <!-- /.single-product-gallery -->
                    </div>
                    <!-- /.gallery-holder -->        
                    <div class="no-margin col-xs-12 col-sm-7 body-holder">
                        <div class="body">
                            <div class="star-holder inline">
                                <div class="star" data-score="${maxReview }"></div>
                            </div>
                            <div class="title"><a href="#">${objProduct.name_product }</a></div>
                            <div class="brand">${objProduct.name_brand }</div>
                            <div class="excerpt">
                                <p>${objProduct.preview_product }</p>
                            </div>
                            <div class="prices">
                            <c:if test="${objProduct.discount_product > 0 }">
                            	<c:set var="curPrice" value="${stringUtils.currentPrice(objProduct.price_product,objProduct.discount_product) }"></c:set>
                                <div class="price-current">${stringUtils.changeMoney(curPrice) }</div>
                                <div class="price-prev">${stringUtils.changeMoney(objProduct.price_product) }</div>
                            </c:if>
                            <c:if test="${objProduct.discount_product == 0 }">
                            	<div class="price-current">${stringUtils.changeMoney(objProduct.price_product) }</div>
                                <div class="price-prev"></div>
                            </c:if>
                            </div>
                            <div class="qnt-holder">
                                <div class="le-quantity">
                                    <form>
                                        <input class="itemqty" name="quantity" id="qty" type="number" value="1" />
                                    </form>
                                </div>
                                <a id="addto-cart" href="javascript:void(0)" class="le-button huge" onclick="return updateDetail(${objProduct.id_product})">add to cart</a>
                            </div>
                            <!-- /.qnt-holder -->
                        </div>
                        <!-- /.body -->
                    </div>
                    <script type="text/javascript">
                    $(".itemqty").on("change paste keyup", function() {
                   		if($(this).val() < 1){
                   			$(this).val(1);
                   		}
                   	});
                    function updateDetail(IdProduct){
                    	var Quantity = $('#qty').val();
    	 				$.ajax({
	    					url: '${pageContext.request.contextPath }/updateDetail',
	    					type: 'POST',
	    					cache: false,
	    					data: {
	    						idProduct: IdProduct,
	    						quantity: Quantity,
	    					},
	    					success: function(data){
	    						$('#cart').html(data);
	    						$('.ajaxcartmessage').html("<div class='alert alert-success'>Đã thêm sản phẩm khỏi giỏ hàng</div>");
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
                    <!-- /.body-holder -->
                </div>
                <!-- /.container -->
            </div>
			<section id="single-product-tab">
                <div class="container">
                    <div class="tab-holder">
                        <ul class="nav nav-tabs simple" >
                            <li class="active"><a href="#description" data-toggle="tab">Chi tiết</a></li>
                            <li><a href="#reviews" data-toggle="tab">Đánh giá (${alReview.size() })</a></li>
                        </ul>
                        <!-- /.nav-tabs -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="description">
                                <p>${objProduct.detail_product }</p>
                                <!-- /.meta-row -->
                            </div>
                            <!-- /.tab-pane #additional-info -->
                            <div class="tab-pane" id="reviews">
                                <div class="comments">
                                <c:forEach items="${alReview }" var="objReview">
                                <fmt:formatDate value="${objReview.date_created }" pattern="dd/MM/yyyy hh:mm:ss" var="fmtDate"/>
                                    <div class="comment-item">
                                        <div class="row no-margin">
                                            <div class="col-lg-1 col-xs-12 col-sm-2 no-margin">
                                                <div class="avatar">
                                                    <img alt="avatar" src="${defines.URL_PUBLIC }/images/default-avatar.jpg">
                                                </div>
                                                <!-- /.avatar -->
                                            </div>
                                            <!-- /.col -->
                                            <div class="col-xs-12 col-lg-11 col-sm-10 no-margin">
                                                <div class="comment-body">
                                                    <div class="meta-info">
                                                        <div class="author inline">
                                                            <a href="javascript:void(0)" class="bold">${objReview.name }</a>
                                                        </div>
                                                        <div class="star-holder inline">
                                                            <div class="star" data-score="${objReview.score }"></div>
                                                        </div>
                                                        <div class="date inline pull-right">
                                                            ${fmtDate }
                                                        </div>
                                                    </div>
                                                    <!-- /.meta-info -->
                                                    <p class="comment-text">
                                                        ${objReview.content }
                                                    </p>
                                                    <!-- /.comment-text -->
                                                </div>
                                                <!-- /.comment-body -->
                                            </div>
                                            <!-- /.col -->
                                        </div>
                                        <!-- /.row -->
                                    </div>
                                </c:forEach>
                                </div>
                                <!-- /.comments -->
                                <div class="add-review row">
                                    <div class="col-sm-8 col-xs-12">
                                        <div class="new-review-form">
                                            <h2>Add review</h2>
                                            <form action="javascript:void(0)" id="formlH" class="contact-form" method="post" >
                                                <div class="row field-row">
                                                    <div class="col-xs-12 col-sm-6">
                                                        <label>name*</label>
                                                        <input name="name" id="name" class="le-input" value="" >
                                                    </div>
                                                    <div class="col-xs-12 col-sm-6">
                                                        <label>email*</label>
                                                        <input name="email" id="email" class="le-input" value="" >
                                                    </div>
                                                </div>
                                                <!-- /.field-row -->
                                                <div class="field-row star-row">
                                                    <label>your rating</label>
                                                    <div class="star-holder">
                                                        <div id="rate_review" class="star big" data-score="0"></div>
                                                    </div>
                                                </div>
                                                <!-- /.field-row -->
                                                <div class="field-row">
                                                    <label>your review</label>
                                                    <textarea name="message" id="message" rows="8" class="le-input" ></textarea>
                                                </div>
                                                <!-- /.field-row -->
                                                <div class="buttons-holder">
                                                    <button type="submit" class="le-button huge" >submit</button>
                                                </div>
                                                <!-- /.buttons-holder -->
                                            </form>
                                            <!-- /.contact-form -->
                                        </div>
                                        <!-- /.new-review-form -->
                                    </div>
                                    <!-- /.col -->
                                </div>
                                <!-- /.add-review -->
                            </div>
                            
                            <!-- /.tab-pane #reviews -->
                        </div>
                        <!-- /.tab-content -->
                    </div>
                    <!-- /.tab-holder -->
                </div>
                <!-- /.container -->
            </section>
            <script type="text/javascript">
            $(document).ready(function (){
        		$('#formlH').validate({
        			rules:{
        				name:{
        					required: true,
        					minlength: 4,
        					maxlength: 15,
        				},
        				email:{
        					required: true,
        					email: true,
        				},
        				message:{
        					required: true,
        				},
        			},
        			messages:{
        				name:{
        					required: "<p class='vali-error' style='color: red'>Vui lòng nhập tên</p>",
        					minlength: "<p class='vali-error' style='color: red'>Vui lòng nhập ít nhất 4 ký tự</p>",
        					maxlength: "<p class='vali-error' style='color: red'>Vui lòng nhập nhiều nhất 15 ký tự</p>",
        				},
        				email:{
        					required: "<p class='vali-error' style='color: red'>Vui lòng nhập email</p>",
        					email: "<p class='vali-error' style='color: red'>Vui lòng nhập email hợp lệ</p>",
        				},
        				message:{
        					required: "<p class='vali-error' style='color: red'>Vui lòng nhập nội dung</p>",
        				},
        			},
        			submitHandler: function(form) {
        				review('${objProduct.id_product}');
        			} ,
        		});
        	});
            function review(Id_product){
            	var Name = $('#name').val();
            	var Email = $('#email').val();
            	var Score_review = $('#rate_review').raty('score');
            	if(Score_review === undefined){
            		Score_review = 0;
            	}
            	var Message = $('#message').val();
 				 $.ajax({
					url: '${pageContext.request.contextPath }/review',
					type: 'POST',
					cache: false,
					data: {
						name: Name,
						email: Email,
						score_review: Score_review,
						message: Message,
						id_product: Id_product
					},
					success: function(data){
						if($('.comments .comment-item').length == 0){
							$('.comments').html(data);
						}else{
							$('.comments .comment-item:eq(0)').before(data);
						}
						$('#name').val("");
						$('#email').val("");
						$('#message').val("");
					},
					error: function (){
					}
				}); 
 			}
			</script>
            <section id="recently-reviewd" class="wow fadeInUp">
                <div class="container">
			         <div class="carousel-holder hover">
			             <div class="title-nav">
			                 <h2 class="h1">Sản phẩm liên quan</h2>
			                 <div class="nav-holder">
			                     <a href="#prev" data-target="#owl-recently-viewed" class="slider-prev btn-prev fa fa-angle-left"></a>
			                     <a href="#next" data-target="#owl-recently-viewed" class="slider-next btn-next fa fa-angle-right"></a>
			                 </div>
			             </div>
			             <!-- /.title-nav -->
			             <div id="owl-recently-viewed" class="owl-carousel product-grid-holder">
			             <c:forEach items="${alProductLQ }" var="objProductLQ">
			                 <div class="no-margin carousel-item product-item-holder size-small hover">
			                     <div class="product-item">
			                     <c:if test="${objProductLQ.discount_product > 0 }">
			                         <div class="ribbon red"><span>sale</span></div>
			                     </c:if>
			                         <div class="image">
			                             <img style="width: 194px; height: 143px;" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductLQ.picture_product}" />
			                         </div>
			                         <div class="body">
			                             <div class="title">
			                                 <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductLQ.name_product) }-${objProductLQ.id_product}.html">${objProductLQ.name_product }</a>
			                             </div>
			                             <div class="brand">${objProductLQ.name_brand }</div>
			                         </div>
			                      <c:if test="${objProductLQ.discount_product > 0 }">
			                         <c:set var="curPrice" value="${stringUtils.currentPrice(objProductLQ.price_product,objProductLQ.discount_product) }"></c:set>
			                         <div class="prices">
			                             <div class="price-current text-right">${stringUtils.changeMoney(curPrice) }</div>
			                         </div>
			                      </c:if>
			                      <c:if test="${objProductLQ.discount_product == 0 }">
			                      	<div class="prices">
			                             <div class="price-current text-right">${stringUtils.changeMoney(objProductLQ.price_product) }</div>
			                         </div>
			                      </c:if>
			                         <div class="hover-area">
			                             <div class="add-cart-button">
			                                 <a href="javascript:void(0)" class="le-button" onclick="return loadCart(${objProductLQ.id_product})">Add to Cart</a>
			                             </div>
			                         </div>
			                     </div>
			                 </div>
			            </c:forEach>
			             </div>
			         </div>
			     </div>
            </section>