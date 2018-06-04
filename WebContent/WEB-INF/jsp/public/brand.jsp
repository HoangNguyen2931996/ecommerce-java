<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <section id="category-grid">
                <div class="container">
                    <!-- ========================================= SIDEBAR ========================================= -->
                    <div class="col-xs-12 col-sm-3 no-margin sidebar narrow">
                        <!-- ========================================= PRODUCT FILTER ========================================= -->
                        
                        <div class="widget accordion-widget category-accordions">
                            <h1 class="border">Danh mục</h1>
                            <div class="accordion">
                            <c:forEach items="${alCat }" var="objCat">
                            <c:if test="${catDao.checkChild(objCat.id_cat).size()!=0 && objCat.id_parent == 0 }">
                                <div class="accordion-group">
                                    <div class="accordion-heading">
                                        <a class="accordion-toggle collapsed" data-toggle="collapse" href="#collapse_${objCat.id_cat }">
                                        ${objCat.name_cat }
                                        </a>
                                    </div>
                                    <div id="collapse_${objCat.id_cat }" class="accordion-body collapse">
                                        <div class="accordion-inner">
                                            <ul>
                                            <c:forEach items="${alCat }" var="objItem">
                                            <c:if test="${objItem.id_parent==objCat.id_cat }">
                                                <li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objItem.name_cat) }-${objItem.id_cat }">${objItem.name_cat }</a></li>
                                            </c:if>
                                            </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                             </c:if>
                             <c:if test="${catDao.checkChild(objCat.id_cat).size()==0 && objCat.id_parent == 0 }">
                                <!-- /.accordion-group -->
                                <div class="accordion-group">
                                    <div class="accordion-heading">
                                        <a class="accordion-toggle collapsed"  href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objCat.name_cat) }-${objCat.id_cat }">
                                        ${objCat.name_cat }
                                        </a>
                                    </div>
                                </div>
                             </c:if>
                             </c:forEach>
                                <!-- /.accordion-group -->
                            </div>
                            <!-- /.accordion -->
                        </div>
                        <div class="widget">
                            <h1 class="border">Giảm giá</h1>
                            <ul class="product-list">
                            <c:forEach items="${alProductByDis }" var="objProductByDis">
                                <li>
                                    <div class="row">
                                        <div class="col-xs-4 col-sm-4 no-margin">
                                            <a href="#" class="thumb-holder">
                                            <img style="width: 73px; height: 73px;" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProductByDis.picture_product}" />
                                            </a>
                                        </div>
                                        <div class="col-xs-8 col-sm-8 no-margin">
                                            <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProductByDis.name_product) }-${objProductByDis.id_product}.html">${objProductByDis.name_product } </a>
                                            <c:if test="${objProductByDis.discount_product > 0 }">
                                                 <c:set var="curPrice" value="${stringUtils.currentPrice(objProductByDis.price_product,objProductByDis.discount_product) }"></c:set>
                                                 <div class="price">
                                                     <div class="price-prev">${stringUtils.changeMoney(objProductByDis.price_product) }</div>
                                                     <div class="price-current">${stringUtils.changeMoney(curPrice) }</div>
                                                 </div>
                                             </c:if>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                            </ul>
                        </div>
                        <!-- ========================================= FEATURED PRODUCTS : END ========================================= -->
                    </div>
                    <!-- ========================================= SIDEBAR : END ========================================= -->
                    <!-- ========================================= CONTENT ========================================= -->
                    <div class="col-xs-12 col-sm-9 no-margin wide sidebar">
                        <section id="gaming">
                            <div class="grid-list-products">
                                <h2 class="section-title">${objBrand.name_brand }</h2>
                              
                                <!-- /.control-bar -->
                                <div class="tab-content">
                                    <div id="grid-view" class="products-grid fade tab-pane in active">
                                        <div class="product-grid-holder">
                                            <div class="row no-margin">
                                            <c:forEach items="${alProduct }" var="objProduct">
                                                <div class="col-xs-12 col-sm-4 no-margin product-item-holder hover">
                                                    <div class="product-item">
                                                        <c:if test="${objProduct.discount_product > 0 }">
                                 							<div class="ribbon red"><span>sale</span></div>
                            							 </c:if>
                                                        <div class="image">
                                                            <img style="width: 246px; height: 186px;" alt="" src="${defines.URL_PUBLIC }/images/blank.gif" data-echo="${pageContext.request.contextPath }/files/${objProduct.picture_product}" />
                                                        </div>
                                                        <div class="body">
                                                            <c:if test="${objProduct.discount_product > 0 }">
                                     							<div class="label-discount green">-${objProduct.discount_product }% sale</div>
                                 							</c:if>
                                                            <div class="title">
                                                                <a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objProduct.name_product) }-${objProduct.id_product}.html">${objProduct.name_product }</a>
                                                            </div>
                                                            <div class="brand">${objProduct.name_brand }</div>
                                                        </div>
                                                        <div class="prices">
                                                            <c:if test="${objProduct.discount_product > 0 }">
                                 								<c:set var="curPrice" value="${stringUtils.currentPrice(objProduct.price_product,objProduct.discount_product) }"></c:set>
                                     							<div class="price-prev">${stringUtils.changeMoney(objProduct.price_product) }</div>
                                     							<div class="price-current pull-right">${stringUtils.changeMoney(curPrice) }</div>
                                 							</c:if>
							                                 <c:if test="${objProduct.discount_product == 0 }">
							                                 	<div class="price-prev"></div>
							                                 	<div class="price-current pull-right">${stringUtils.changeMoney(objProduct.price_product) }</div>
							                                 </c:if>
                                                        </div>
                                                        <div class="hover-area">
                                                            <div class="add-cart-button">
                                                                <a href="javascript:void(0)" class="le-button" onclick="return loadCart(${objProduct.id_product})">add to cart</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /.product-item -->
                                                </div>
                                            </c:forEach>
                                               
                                                <!-- /.product-item-holder -->
                                            </div>
                                            <!-- /.row -->
                                        </div>
                                        <!-- /.product-grid-holder -->
                                        <c:if test="${sumPage > 1 }">
                                        <div class="pagination-holder">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-6 text-left">
                                                    <ul class="pagination ">
                                                    	<c:set var="sumPage" value="${sumPage }"></c:set>
														<c:set var="currentPage" value="${currentPage }"></c:set>
														<c:set var="pageNum" value="${pageNum }"></c:set>
														<c:set var="numLink" value="${numLink }"></c:set>
														<c:set var="pageStart" value="0"></c:set>
														<c:set var="pageEnd" value="0"></c:set>
														<c:if test="${currentPage>1 && sumPage > 0 }">
															<li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objBrand.name_brand)}-${objBrand.id_brand}.php?page=${currentPage - 1 }">previous</a></li>
														</c:if>
														<c:if test="${currentPage>=pageNum }">
															<c:set var="pageStart" value="${currentPage-numLink }"></c:set>
															<c:choose>
																<c:when test="${sumPage>(currentPage+numLink) }">
																	<c:set var="pageEnd" value="${currentPage+numLink }"></c:set>
																</c:when>
																<c:when test="${currentPage<=sumPage && currentPage>(sumPage-(pageNum-1)) }">
																	<c:set var="pageStart" value="${sumPage - (pageNum-1) }"></c:set>
																	<c:set var="pageEnd" value="${sumPage }"></c:set>
																</c:when>
																<c:otherwise>
																	<c:set var="pageEnd" value="${sumPage }"></c:set>
																</c:otherwise>
															</c:choose>
														</c:if>
														<c:if test="${currentPage<pageNum }">
															<c:set var="pageStart" value="1"></c:set>
															<c:choose>
																<c:when test="${sumPage>pageNum }">
																	<c:set var="pageEnd" value="${pageNum }"></c:set>
																</c:when>
																<c:otherwise>
																	<c:set var="pageEnd" value="${sumPage }"></c:set>
																</c:otherwise>
															</c:choose>
														</c:if>
														<c:forEach var="i" begin="${pageStart }" end="${pageEnd }" step="1">
															<li <c:if test="${currentPage==i }">class="current"</c:if> ><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objBrand.name_brand)}-${objBrand.id_brand}.php?page=${i }">${i }</a></li>
														</c:forEach>
														<c:if test="${currentPage < sumPage && sumPage > 1 }">
															<li><a href="${pageContext.request.contextPath }/${slugUtils.makeSlug(objBrand.name_brand)}-${objBrand.id_brand}.php?page=${currentPage + 1 }">Next</a></li> 
														</c:if>
                                                    </ul>
                                                </div>
                                                <div class="col-xs-12 col-sm-6">
                                                    <div class="result-counter">
                                                        Showing <span>${currentPage }-${sumPage }</span> of <span>${sumItem }</span> results
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.row -->
                                        </div>
                                        </c:if>
                                        <!-- /.pagination-holder -->
                                    </div>
                                </div>
                                <!-- /.tab-content -->
                            </div>
                            <!-- /.grid-list-products -->
                        </section>
                        <!-- /#gaming -->            
                    </div>
                    <!-- /.col -->
                    <!-- ========================================= CONTENT : END ========================================= -->    
                </div>
                <!-- /.container -->
            </section>
            <!-- /#category-grid -->		<!-- ============================================================= FOOTER ============================================================= -->
  