<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container-fluid">
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Liên hệ</h5>
		</div>
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
						<div class="table-wrap mt-40">
						<div class="table-responsive">
							  <table class="table table-hover table-bordered mb-0">
								<thead>
								  <tr>
									<th>ID</th>
									<th>name</th>
									<th>mail</th>
									<th>phone</th>
									<th>title</th>
									<th>status(sent?)</th>
									<th class="text-nowrap">Action</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach items="${alContact }" var="objContact">
									<c:set var="urlView" value="${pageContext.request.contextPath }/admin/contact/view/${objContact.id_contact }"></c:set>
									<c:set var="urlDel" value="${pageContext.request.contextPath }/admin/contact/del/${objContact.id_contact }"></c:set>
									<c:set var="urlAns" value="${pageContext.request.contextPath }/admin/contact/answer/${objContact.id_contact }"></c:set>
									  <tr>
										<td>${objContact.id_contact }</td>
										<td>${objContact.name }</td>
										<td>${objContact.mail }</td>
										<td>${objContact.phone }</td>
										<td>${objContact.title }</td>
										<td>
											<c:choose>
                                        		<c:when test="${objContact.status == 1 }">
                                        			<img style="padding-left: 10px;" alt="" src="${defines.URL_ADMIN }/img/notification-tick.gif">
                                        		</c:when>
                                        		<c:when test="${objContact.status == 0 }">
                                        			<img style="padding-left: 10px;" alt="" src="${defines.URL_ADMIN }/img/minus-circle.gif">
                                        		</c:when>
                                        	</c:choose>
										</td>
										<td class="text-nowrap">
											<a href="${urlView }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="View"><i class="zmdi zmdi-eye txt-warning"></i></a>
											<a href="${urlDel }" class="text-inverse pr-10" title="" data-toggle="tooltip" data-original-title="Delete"><i class="zmdi zmdi-delete txt-danger"></i></a>
											<a href="${urlAns }" class="text-inverse" title="" data-toggle="tooltip" data-original-title="Answer"><i class="zmdi zmdi-mail-send txt-danger"></i></a>
									  	</td>
									  </tr>
								</c:forEach>
								</tbody>
							  </table>
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
										<li> <a href="${pageContext.request.contextPath }/admin/contact?page=${currentPage-1 }"><i class="fa fa-angle-left"></i></a> </li>
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
										<li <c:if test="${currentPage == i }">class="active"</c:if>> <a href="${pageContext.request.contextPath }/admin/contact?page=${i }">${i }</a> </li>
									</c:forEach>
									<c:if test="${currentPage < sumPage && sumPage > 1 }">
										<li> <a href="${pageContext.request.contextPath }/admin/contact?page=${currentPage+1 }"><i class="fa fa-angle-right"></i></a></li>
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
