<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!-- ============================================================= HEADER : END ============================================================= -->		<!-- ========================================= CONTENT ========================================= -->
            <section id="checkout-page">
                <div class="container">
                    <div class="col-xs-12 no-margin">
                        <div class="billing-address">
                            <h2 class="border h1">Địa chỉ thanh toán</h2>
                            <form action="${pageContext.request.contextPath}/checkout" method="post" id="form_address">
                                <div class="row field-row">
                                    <div class="col-xs-12 col-sm-6">
                                        <label>Tên đầy đủ*</label>
                                        <input class="le-input" value="${objUser.fullname }" name="name_receiver">
                                    </div>
                                    <div class="col-xs-12 col-sm-6">
                                        <label>Địa chỉ*</label>
                                        <input class="le-input" data-placeholder="street address" value="${objUser.address }" name="address_receiver">
                                    </div>
                                </div>
                                <!-- /.field-row -->
                                <div class="row field-row">
                                    <div class="col-xs-12 col-sm-6">
                                        <label>Email*</label>
                                        <input class="le-input" value="${objUser.email }" name="email_receiver">
                                    </div>
                                    <div class="col-xs-12 col-sm-6">
                                        <label>Số điện thoại*</label>
                                        <input class="le-input" value="${objUser.phone }" name="phone_receiver">
                                    </div>
                                </div>
                                <div class="row field-row">
                                	<div class="col-xs-12 col-sm-12">
	                         			<label>Thông tin bổ sung</label>
	                          			<textarea name="more_infor" rows="8" class="le-input"></textarea>
                          			</div>
                                </div>
		                       <div id="payment-method-options">
		                       <c:forEach items="${alPayment }" var="objPayment">
		                            <!-- /.payment-method-option -->
		                            <div class="payment-method-option">
		                                <input class="le-radio" type="radio" name="id_payment" value="${objPayment.id_payment }">
		                                <div class="radio-label bold ">${objPayment.name_payment }</div>
		                            </div>
		                       </c:forEach>
		                       </div>
                            </form>
                        </div>
                        <!-- /#shipping-address -->
                        <section id="your-order">
                            <h2 class="border h1">Đơn đặt hàng của bạn</h2>
                            <form>
                            <c:set var="totalAmount" value="0"></c:set>
                            <c:forEach items="${alCart }" var="objCart">
                            	<c:set var="totalAmount" value="${totalAmount + objCart.total_amount }"></c:set>
                                <div class="row no-margin order-item">
                                    <div class="col-xs-12 col-sm-1 no-margin">
                                        <a href="#" class="qty">${objCart.quantity } x</a>
                                    </div>
                                    <div class="col-xs-12 col-sm-9 ">
                                        <div class="title"><a href="#">${objCart.name_product } </a></div>
                                        <div class="brand">${objCart.name_brand }</div>
                                    </div>
                                    <div class="col-xs-12 col-sm-2 no-margin">
                                        <div class="price">${stringUtils.changeMoney(objCart.total_amount) }</div>
                                    </div>
                                </div>
                            </c:forEach>
                                <!-- /.order-item -->
                            </form>
                        </section>
                        <!-- /#your-order -->
                        <div id="total-area" class="row no-margin">
                            <div class="col-xs-12 col-lg-4 col-lg-offset-8 no-margin-right">
                                <div id="subtotal-holder">
                                    <ul class="tabled-data inverse-bold no-border">
                                        <li>
                                            <label>Tổng giỏ hàng</label>
                                            <div class="value ">${stringUtils.changeMoney(totalAmount) }</div>
                                        </li>
                                        <li>
                                            <label>shipping</label>
                                            <div class="value">
                                                <div class="radio-group">
                                                    <div class="radio-label bold">free shipping</div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <!-- /.tabled-data -->
                                    <ul id="total-field" class="tabled-data inverse-bold ">
                                        <li>
                                            <label>Tổng đơn đặt hàng</label>
                                            <div class="value">${stringUtils.changeMoney(totalAmount) }</div>
                                        </li>
                                    </ul>
                                    <!-- /.tabled-data -->
                                </div>
                                <!-- /#subtotal-holder -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /#total-area -->
                        <!-- /#payment-method-options -->
                        <div class="place-order-button">
                            <button type="submit" class="le-button big" onclick="return submitForms()">place order</button>
                        </div>
                        <!-- /.place-order-button -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.container -->    
            </section>
            
            <script type="text/javascript">
            submitForms = function(){
            	if ($('input[name=id_payment]:checked').length > 0) {
            	}else{
            		$('.ajaxcartmessage').html("<div class='alert alert-danger'>Vui lòng chọn phương thức thanh toán</div>");
            		$('.ajaxcartmessage').show();
					setTimeout(function(){
						$('.ajaxcartmessage').slideUp('slow');
					},3000);
            		return false;
            	}
                document.getElementById("form_address").submit();
            }
			</script>
            <!-- /#checkout-page -->
            <!-- ========================================= CONTENT : END ========================================= -->		<!-- ============================================================= FOOTER ============================================================= -->
