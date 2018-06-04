<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!-- saved from url=(0038)http://smpshop.esy.es/order/step2.html -->
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SMPShop Confirm Receipt: Customer - Le Vien Thuong</title>
        <!-- BOOTSTRAP STYLES-->
        <link href="${pageContext.request.contextPath }/templates/public/css/bootstrap.min.css" rel="stylesheet">
        <script src="${defines.URL_PUBLIC }/js/jquery-1.10.2.min.js"></script>
        <script src="${defines.URL_ADMIN }/js/jQuery.print.min.js"></script>
    </head>
    <body style="margin-top:20px" class="printableArea2" >
        <div class="container" id="ele1">
            <div class="row">
                <div class="well col-xs-10 col-sm-10 col-md-8 col-xs-offset-1 col-sm-offset-1 col-md-offset-3">
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <address>
                                <strong>Smart Shop</strong>
                                <br>
                                54 Ninh Tốn
                                <br>
                                Đà Nẵng, Việt Nam
                                <br>
                                <abbr title="Phone">Phone:</abbr> 01692766061
                            </address>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 text-right">
                            <p>
                            </p>
                            <p>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="text-center">
                            <h1>Receipt</h1>
                        </div>
                        <div class="text-left" style="padding-left:20px">
                            Tên khách hàng: ${objOrder.name_receiver }<br>
                            Địa chỉ nhận: ${objOrder.address_receiver }<br>
                            Số điện thoại: ${objOrder.phone_receiver }<br>
                            Email: ${objOrder.email_receiver }<br>
                            Thông tin thêm: ${objOrder.more_infor }<br>
                            Phương thức thanh toán: ${objOrder.name_payment }
                        </div>
                        <table class="table table-hover" id="table2excel">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th class="text-center">Price</th>
                                    <th class="text-center">(-%)</th>
                                    <th class="col-md-2 text-center">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:set var="totalPrice" value="0"></c:set>
                            <c:forEach items="${alOrderItem }" var="objOrderItem">
                            <c:set var="totalPrice" value="${totalPrice + objOrderItem.total_amount }"></c:set>
                                <tr>
                                    <td class="col-md-6"><em>${objOrderItem.name_product }</em></td>
                                    <td class="col-md-1 text-center">${objOrderItem.quantity }</td>
                                    <td class="col-md-2" style="text-align: center">${stringUtils.changeMoney(objOrderItem.price_product) }</td>
                                    <td class="col-md-1 text-center">${objOrderItem.discount_product } %</td>
                                    <td class="col-md-2 text-center">${stringUtils.changeMoney(objOrderItem.total_amount) }</td>
                                </tr>
                            </c:forEach>    
                                <tr>
                                    <td class="text-right"  colspan="4">
                                        <p>
                                            <strong>Subtotal:&nbsp;</strong>
                                        </p>
                                        <p>
                                            <strong>Shipping:&nbsp;</strong>
                                        </p>
                                    </td>
                                    <td class="text-center">
                                        <p>
                                            <strong>${stringUtils.changeMoney(totalPrice) }</strong>
                                        </p>
                                        <p>
                                            <strong>Free</strong>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-right" colspan="4">
                                        <h4><strong>Total:</strong></h4>
                                    </td>
                                    <td class="text-center text-danger">
                                        <h4><strong>&nbsp;${stringUtils.changeMoney(totalPrice) }</strong></h4>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="row noprint print-link no-print" style="padding:30px">
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath }/checkout" class="btn btn-default btn-lg btn-block">
                                Quay lại
                                </a>
                            </div>
                            
                            <div class="col-md-6">
                                <a type="button" id="print_order" class="btn btn-primary btn-lg btn-block printbtn" onclick="jQuery('#ele1').print()">
                                In hóa đơn
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="trans_div" style="display:none"></div>
    </body>
</html>