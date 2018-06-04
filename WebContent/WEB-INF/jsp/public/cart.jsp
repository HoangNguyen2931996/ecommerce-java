<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!-- ============================================================= HEADER : END ============================================================= -->		
            <section id="cart-page">
                <div class="container">
                    <!-- ========================================= CONTENT ========================================= -->
                    <div class="col-xs-12 col-md-9 items-holder no-margin">
                    <c:set var="totalPrice" value="0"></c:set>
                    <c:forEach items="${alCart }" var="objCart">
                    	<c:set var="totalPrice" value="${totalPrice+objCart.total_amount }"></c:set>
                        <div class="row no-margin cart-item cart_header" id="row_${objCart.id_product }">
                            <div class="col-xs-12 col-sm-1 no-margin">
                                <a href="#" class="thumb-holder">
                                <img style="width: 73px; height: 73px;" class="lazy" alt="" src="${pageContext.request.contextPath }/files/${objCart.picture_product }" />
                                </a>
                            </div>
                            <div class="col-xs-12 col-sm-4 ">
                                <div class="title">
                                    <a href="#">${objCart.name_product }</a>
                                </div>
                                <div class="brand">${objCart.name_brand }</div>
                            </div>
                            <div class="col-xs-12 col-sm-2 no-margin">
                                <div class="quantity">
                                    <div class="le-quantity">
                                        <form>
                                            <input class="itemqty" name="quantity" id="${objCart.id_product }" type="number" value="${objCart.quantity }"/>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-5 no-margin">
                            <c:set var="curPrice" value="${stringUtils.currentPrice(objCart.price_product,objCart.discount_product) }"></c:set>
                                <div class="price" rawprice="${curPrice }">
                                    ${stringUtils.changeMoney(objCart.total_amount) }
                                </div>
                                <a class="close-btn" href="javascript:void(0)" onclick="return deleteItem(${objCart.id_product})"></a>
                            </div>
                        </div>
                    </c:forEach>
                        <!-- /.cart-item -->
                    </div>
                    <!-- ========================================= CONTENT : END ========================================= -->
                    <!-- ========================================= SIDEBAR ========================================= -->
                    <div class="col-xs-12 col-md-3 no-margin sidebar ">
                        <div class="widget cart-summary">
                            <h1 class="border">shopping cart</h1>
                            <div class="body" id="total_price">
                                <ul class="tabled-data no-border inverse-bold">
                                    <li>
                                        <label>Tổng tiền đã mua</label>
                                        <div class="value pull-right">${stringUtils.changeMoney(totalPrice) }</div>
                                    </li>
                                    <li>
                                        <label>shipping</label>
                                        <div class="value pull-right">free shipping</div>
                                    </li>
                                </ul>
                                <ul id="total-price" class="tabled-data inverse-bold no-border">
                                    <li>
                                        <label>Tổng tiền</label>
                                        <div class="value pull-right">${stringUtils.changeMoney(totalPrice) }</div>
                                    </li>
                                </ul>
                                <div class="buttons-holder">
                                    <a class="le-button big" href="${pageContext.request.contextPath }/checkout" >checkout</a>
                                    <a class="simple-link block" href="${pageContext.request.contextPath }" >continue shopping</a>
                                </div>
                            </div>
                        </div>
                        <script>
	                        $(".itemqty").on("change paste keyup", function() {
		                   		if($(this).val() < 1){
		                   			$(this).val(1);
		                   		}
		                   		var link = $(this);
		                   		var Quantity = link.val();
		                   		var parent = $(this).closest('.cart_header');
		                   		var price = parent.find('.price').attr('rawprice');
		                   		var subtotal = number_format(Quantity*price,0);
		                   		parent.find('.price').text(subtotal+' VNĐ'); 
		                   	});
                        	$(".itemqty").on('focusout', function(){
                        		if($(this).val() < 1){
                        			$(this).val(1);
                        		}
                        		var link = $(this);
                        		var id_product = link.attr('id');
                        		var Quantity = link.val();
                        		$.ajax({
    		       					url: '${pageContext.request.contextPath }/updateCart',
    		       					type: 'POST',
    		       					cache: false,
    		       					data: {
    		       						idProduct: id_product,
    		       						quantity: Quantity,
    		       					},
    		       					success: function(data){
    		       						$('#cart').html(data[0]);
    		       						$('#total_price').html(data[1]);
    		       						$('.ajaxcartmessage').html("<div class='alert alert-success'>Đã cập nhập giỏ hàng</div>");
    		    						$('.ajaxcartmessage').show();
    		    						setTimeout(function(){
    		    							$('.ajaxcartmessage').slideUp('slow');
    		    						},3000);
    		       					},
    		       					error: function (){
    		       					}
    		       				});
                        	});
                        	function number_format( number, decimals, dec_point, thousands_sep ) {
                        	    // http://kevin.vanzonneveld.net
                        	    // + original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
                        	    // + improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
                        	    // + bugfix by: Michael White (http://crestidg.com)
                        	    // + bugfix by: Benjamin Lupton
                        	    // + bugfix by: Allan Jensen (http://www.winternet.no)
                        	    // + revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
                        	    // * example 1: number_format(1234.5678, 2, '.', '');
                        	    // * returns 1: 1234.57
                        	                              
                        	    var n = number, c = isNaN(decimals = Math.abs(decimals)) ? 2 : decimals;
                        	    var d = dec_point == undefined ? "," : dec_point;
                        	    var t = thousands_sep == undefined ? "." : thousands_sep, s = n < 0 ? "-" : "";
                        	    var i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
                        	                              
                        	    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
                        	}
                        	
                        </script>
                        <!-- /.widget -->
                    </div>
                    <!-- /.sidebar -->
                    <!-- ========================================= SIDEBAR : END ========================================= -->
                </div>
            </section>
            <!-- ============================================================= FOOTER ============================================================= -->
