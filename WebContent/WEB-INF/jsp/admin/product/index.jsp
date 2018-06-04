<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	input[value="Xóa"]{color: red;}
</style>
<div class="container-fluid">
	
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Sản phẩm</h5>
		</div>
		<!-- /Breadcrumb -->
	</div>
	<!-- /Title -->
	<div class="row">
		<!-- Bordered Table -->
		<div class="col-sm-12">
			<div class="panel panel-default card-view">						
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<c:if test="${not empty msg }">
							<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-info-outline mr-10"></i>${msg }</h6>
							<hr class="light-grey-hr"/>
						</c:if>
						<p class="text-muted">
							<a class="btn btn-success btn-anim" href="${pageContext.request.contextPath }/admin/product/add">
								<span>Add</span>
							</a>
						</p>
						<div class="form-wrap mt-40">
							<form action="${pageContext.request.contextPath }/admin/product/search" method="post">
								<div class="row">
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">Tên sản phẩm</label>
											<input name="name_product" type="text" id="firstName" class="form-control" placeholder="Tên danh mục">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">Danh mục</label>
											<select name="id_cat" class="form-control select2" data-placeholder="Choose a Category" tabindex="1">
											<option value="0">---- Không có ----</option>
											<c:forEach items="${alCat }" var="objCat">
												<c:if test="${objCat.id_parent == 0 && catDao.checkChild(objCat.id_cat).size() != 0 }">
													<optgroup label="${objCat.name_cat }">
													<c:forEach items="${alCat }" var="objItem">
														<c:if test="${objItem.id_parent == objCat.id_cat }">
															<option value="${objItem.id_cat }">${objItem.name_cat }</option>
														</c:if>
													</c:forEach>
													</optgroup>
												</c:if>
												<c:if test="${objCat.id_parent == 0 && catDao.checkChild(objCat.id_cat).size() == 0 }">
													<option value="${objCat.id_cat }">${objCat.name_cat }</option>
												</c:if>
											</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">hãng sản xuất</label>
											<select name="id_brand" class="form-control select2" data-placeholder="Choose a brand" tabindex="1">
											<option value="0">---- Không có ----</option>
											<c:forEach items="${alBrand }" var="objBrand">
												<option value="${objBrand.id_brand }">${objBrand.name_brand }</option>
											</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-md-3 mt-30">
										<div class="form-actions">
											<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <span>Search</span></button>
											<div class="clearfix"></div>
										</div>
									</div>
								</div>
								<!--/row-->
								
							</form>
						</div>
						<div class="table-wrap mt-40">
							<div class="table-responsive">
							<form action="${pageContext.request.contextPath }/admin/product/del" method="post">
							  <table class="table table-hover table-bordered mb-0">
								<thead>
								  <tr>
									<th>ID</th>
									<th>sản phẩm</th>
									<th>danh mục</th>
									<th>hãng sản xuất</th>
									<th>giá</th>
									<th>Giảm giá</th>
									<th>Ảnh</th>
									<th>Ngày đăng</th>
									<th>Trạng thái</th>
									<th class="text-nowrap">Chức năng</th>
									<th><input type="submit" value="Xóa" />	</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach items="${alProduct }" var="objProduct">
									<c:set var="urlEdit" value="${pageContext.request.contextPath }/admin/product/edit/${objProduct.id_product }"></c:set>
									<c:set var="urlDel" value="${pageContext.request.contextPath }/admin/product/del/${objProduct.id_product }"></c:set>
									<c:set var="urlPic" value="${pageContext.request.contextPath }/admin/product/picture/${objProduct.id_product }"></c:set>
									<fmt:formatDate value="${objProduct.date_created_product }" pattern="HH:mm:ss dd/MM/yyy" var="fmDate"/>
									  <tr>
										<td>${objProduct.id_product }</td>
										<td><a href="${urlEdit }">${objProduct.name_product }</a></td>
										<td>${objProduct.name_cat }</td>
										<td>${objProduct.name_brand }</td>
										<td>${objProduct.price_product }</td>
										<td>${objProduct.discount_product } %</td>
										<td><img style="width: 120px; height: 90px" alt="" src="${pageContext.request.contextPath }/files/${objProduct.picture_product }" /></td>
										<td>${fmDate }</td>
										<td class="status_${objProduct.id_product }">
                                       		<c:choose>
                                        		<c:when test="${objProduct.status_product == 1 }">
                                        			<img id="${objProduct.id_product }" class="turnOn" style="padding-left: 10px;" alt="" src="${defines.URL_ADMIN }/img/notification-tick.gif" onclick="return turnOn(this.id)">
                                        		</c:when>
                                        		<c:when test="${objProduct.status_product == 0 }">
                                        			<img id="${objProduct.id_product }" class="turnOff" style="padding-left: 10px;" alt="" src="${defines.URL_ADMIN }/img/minus-circle.gif" onclick="return turnOff(this.id)">
                                        		</c:when>
                                        	</c:choose>
                                       	</td>
										<td class="text-nowrap">
											<a href="${urlEdit }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="Edit"><i class="zmdi zmdi-edit txt-warning"></i></a>
											<a href="${urlDel }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="Delete"><i class="zmdi zmdi-delete txt-danger"></i></a>
											<a href="${urlPic }" class="text-inverse" title="" data-toggle="tooltip" data-original-title="Picture"><i class="zmdi zmdi-assignment-returned txt-warning"></i></a>
										</td>
										<td><input type="checkbox" name="id_product" value="${objProduct.id_product }"  /></td>
									  </tr>
								</c:forEach>
								</tbody>
							  </table>
							</form>
							</div>
							<script type="text/javascript">
							function turnOn(id_product){
			 	 				$.ajax({
									url: '${pageContext.request.contextPath }/admin/product/status',
									type: 'POST',
									cache: false,
									data: {
										Id_product: id_product,
										status: 0, 
									},
									success: function(data){
										$('.status_'+id_product).html(data);
									},
									error: function (){
									}
								}); 
					 		}
					 		function turnOff(id_product){
					 			$.ajax({
									url: '${pageContext.request.contextPath }/admin/product/status',
									type: 'POST',
									cache: false,
									data: {
										Id_product: id_product,
										status: 1, 
									},
									success: function(data){
										$('.status_'+id_product).html(data);
									},
									error: function (){
									}
								});
					 		} 
							</script>
							<div class="row">
								<div class="col-md-12">
									<ul class="pagination pagination-split">
									<c:set var="sumPage" value="${sumPage }"></c:set>
									<c:set var="currentPage" value="${currentPage }"></c:set>
									<c:set var="pageNum" value="${pageNum }"></c:set>
									<c:set var="numLink" value="${numLink }"></c:set>
									<c:set var="pageStart" value="0"></c:set>
									<c:set var="pageEnd" value="0"></c:set>
									<c:if test="${currentPage>1 && sumPage > 0 }">
										<li> <a href="${pageContext.request.contextPath }/admin/product?page=${currentPage-1 }"><i class="fa fa-angle-left"></i></a> </li>
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
										<li <c:if test="${currentPage == i }">class="active"</c:if>> <a href="${pageContext.request.contextPath }/admin/product?page=${i }">${i }</a> </li>
									</c:forEach>
									<c:if test="${currentPage < sumPage && sumPage > 1 }">
										<li> <a href="${pageContext.request.contextPath }/admin/product?page=${currentPage+1 }"><i class="fa fa-angle-right"></i></a></li>
									</c:if>	
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Bordered Table -->
		
	</div>
	
</div>
<script type="text/javascript">
	$(document).ready(function() {
		  $(".select2").select2();
		});
</script>