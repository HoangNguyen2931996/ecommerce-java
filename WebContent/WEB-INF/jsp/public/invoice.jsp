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
        <script src="${defines.URL_PUBLIC }/js/jquery.table2excel.min.js"></script>
        <!-- FONTAWESOME STYLES-->
    </head>
    <body style="margin-top:20px" class="printableArea2">
        <div class="container">
            <div class="row">
                <div class="well col-xs-10 col-sm-10 col-md-8 col-xs-offset-1 col-sm-offset-1 col-md-offset-3">
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <address>
                                <strong>SMP Shop</strong>
                                <br>
                                54 Ninh Ton
                                <br>
                                Danang, Vietnam
                                <br>
                                <abbr title="Phone">Phone:</abbr> 0935579194
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
                            Địa chỉ nhận hàng: ${objOrder.address_receiver }<br>
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
                            <c:forEach items="${alCart }" var="objCart">
                            <c:set var="totalPrice" value="${totalPrice + objCart.total_amount }"></c:set>
                                <tr>
                                    <td class="col-md-6"><em>${objCart.name_product }</em></td>
                                    <td class="col-md-1 text-center">${objCart.quantity }</td>
                                    <td class="col-md-2" style="text-align: center">${stringUtils.changeMoney(objCart.price_product) }</td>
                                    <td class="col-md-1 text-center">${objCart.discount_product } %</td>
                                    <td class="col-md-2 text-center">${stringUtils.changeMoney(objCart.total_amount) }</td>
                                </tr>
                            </c:forEach>    
                                <tr>
                                    <td class="text-right" colspan="4">
                                        <p>
                                            <strong>Subtotal:&nbsp;</strong>
                                        </p>
                                        <p>
                                            <strong>Shipping:&nbsp;</strong>
                                        </p>
                                    </td>
                                    <td class="text-center" colspan="3">
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
                                    <td class="text-center text-danger" colspan="3">
                                        <h4><strong>&nbsp;${stringUtils.changeMoney(totalPrice) }</strong></h4>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="row noprint" style="padding:30px">
                            <div class="col-md-3">
                                <a href="${pageContext.request.contextPath }/checkout" class="btn btn-default btn-lg btn-block">
                               	Quay lại
                                </a>
                            </div>
                            <div class="col-md-6">
                                <form action="${pageContext.request.contextPath }/checkout/confirm" method="POST">
                                    <input type="hidden" name="_token" value="vrcUVrsNYioUVrcD57QebKKGpS7jzRHYg0oqzXB6">
                                    <button type="submit" class="btn btn-success btn-lg btn-block">
                                    Xác nhận
                                    </button>
                                </form>
                            </div>
                            <div class="col-md-3">
                                <a type="button" id="export_excel" class="btn btn-primary btn-lg btn-block printbtn">
                                Lưu file
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="trans_div" style="display:none"></div>
        <script type="text/javascript">
        	$("#export_excel").click(function(){
        	  $("#table2excel").table2excel({
        	    // exclude CSS class
        	    exclude: ".noExl",
        	    name: "Worksheet Name",
        	    filename: "SomeFile" //do not include extension
        	  }); 
        	});

        </script>
    </body>
</html>