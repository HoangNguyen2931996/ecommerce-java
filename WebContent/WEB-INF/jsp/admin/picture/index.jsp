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
		  <h5 class="txt-dark">Ảnh sản phẩm</h5>
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
							<a class="btn btn-success btn-anim" href="${pageContext.request.contextPath }/admin/picture/add">
								<span>Add</span>
							</a>
						</p>
						<div class="form-wrap mt-40">
							<form action="${pageContext.request.contextPath }/admin/picture/search" method="post">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Tên sản phẩm</label>
											<select name="id_product" class="form-control select2" data-placeholder="Choose a brand" tabindex="1">
											<c:forEach items="${alProduct }" var="objProduct">
												<option value="${objProduct.id_product }">${objProduct.name_product }</option>
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
							<form action="${pageContext.request.contextPath }/admin/picture/del" method="post">
							  <table class="table table-hover table-bordered mb-0">
								<thead>
								  <tr>
									<th>ID</th>
									<th>Hình ảnh</th>
									<th>Tên sản phẩm</th>
									<th class="text-nowrap">Action</th>
									<th><input type="submit" value="Xóa" />	</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach items="${alPicture }" var="objPicture">
									<c:set var="urlEdit" value="${pageContext.request.contextPath }/admin/picture/edit/${objPicture.id_picture }"></c:set>
									<c:set var="urlDel" value="${pageContext.request.contextPath }/admin/picture/del/${objPicture.id_picture }"></c:set>
									  <tr>
										<td>${objPicture.id_picture }</td>
										<td><a href="${urlEdit }"><img style="width: 170px; height: 100px" alt="" src="${pageContext.request.contextPath }/files/${objPicture.name_picture }" /></a></td>
										<td>${objPicture.name_product }</td>
										<td class="text-nowrap">
											<a href="${urlEdit }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="Edit"><i class="zmdi zmdi-edit txt-warning"></i></a>
											<a href="${urlDel }" class="text-inverse" title="" data-toggle="tooltip" data-original-title="Delete"><i class="zmdi zmdi-delete txt-danger"></i></a>
										</td>
										<td><input type="checkbox" name="id_picture" value="${objPicture.id_picture }"  /></td>
									  </tr>
								</c:forEach>
								</tbody>
							  </table>
							</form>
							</div>
							<c:if test="${sumPage > 1 }">
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
										<li> <a href="${pageContext.request.contextPath }/admin/picture?page=${currentPage-1 }"><i class="fa fa-angle-left"></i></a> </li>
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
										<li <c:if test="${currentPage == i }">class="active"</c:if>> <a href="${pageContext.request.contextPath }/admin/picture?page=${i }">${i }</a> </li>
									</c:forEach>
									<c:if test="${currentPage < sumPage && sumPage > 1 }">
										<li> <a href="${pageContext.request.contextPath }/admin/picture?page=${currentPage+1 }"><i class="fa fa-angle-right"></i></a></li>
									</c:if>	
									</ul>
								</div>
							</div>
							</c:if>
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