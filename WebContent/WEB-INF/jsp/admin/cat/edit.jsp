<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript">
	$(document).ready(function (){
		$('#edit_cat').validate({
			rules:{
				name_cat:{
					required: true,
					minlength: 4,
					maxlength: 15,
				},
			},
			messages:{
				name_cat:{
					required: "<p class='vali-error'>Vui lòng nhập tên danh mục</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 15 ký tự</p>"
				},
			}
		});
	});
</script>
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Sửa danh mục</h5>
		</div>
		<!-- Breadcrumb -->
		
	</div>
	<!-- /Title -->
	
	<!-- Row -->
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default card-view">
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="form-wrap">
							<form id="edit_cat" action="${pageContext.request.contextPath }/admin/cat/edit/${objCat.id_cat}" method="post">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Tên danh mục</label>
											<input name="name_cat" type="text" id="firstName" class="form-control" placeholder="Tên danh mục" value="${objCat.name_cat }">
											<form:errors path="objCat.name_cat" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
									<!--/span-->
								</div>
								<!-- Row -->
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Danh mục cha</label>
											<select name="id_parent" class="form-control select2">
												<option value="0">Không có</option>
												<c:forEach items="${alCat }" var="itemCat">
													<c:if test="${itemCat.id_parent == 0 && catDao.checkChild(objCat.id_cat).size() == 0 && objCat.id_cat != itemCat.id_cat }">
														<option <c:if test="${objCat.id_parent == itemCat.id_cat }">selected="selected"</c:if> value="${itemCat.id_cat }">${itemCat.name_cat }</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>
									<!--/span-->
								</div>
								<!--/row-->
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Edit</span></button>
									<a class="btn btn-warning pull-left" href="${pageContext.request.contextPath }/admin/cat">Go back</a>
									<div class="clearfix"></div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /Row -->
</div>
<script type="text/javascript">
	$(document).ready(function() {
		  $(".select2").select2();
		});
</script>