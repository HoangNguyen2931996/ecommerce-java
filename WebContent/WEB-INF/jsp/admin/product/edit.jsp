<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript">
	$(document).ready(function (){
		$('#edit_product').validate({
			rules:{
				name_product:{
					required: true,
					minlength: 4,
					maxlength: 30,
				},
				price_product:{
					required: true,
					digits: true,
					min: 1000000,
					max: 100000000,
				},
				preview_product:{
					required: true,
					minlength: 10,
					maxlength: 255,
				},
			},
			messages:{
				name_product:{
					required: "<p class='vali-error'>Vui lòng nhập tên sản phẩm</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 4 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 30 ký tự</p>"
				},
				price_product:{
					required: "<p class='vali-error'>Vui lòng giá của sản phẩm</p>",
					digits: "<p class='vali-error'>Vui lòng giá hợp lệ</p>",
					min: "<p class='vali-error'>Vui lòng nhập lớn hơn 1000000</p>",
					max: "<p class='vali-error'>Vui lòng nhập nhỏ hơn 100000000</p>",
				},
				preview_product:{
					required: "<p class='vali-error'>Vui lòng giới thiệu sơ lược về sản phẩm</p>",
					minlength: "<p class='vali-error'>Vui lòng nhập ít nhất 10 ký tự</p>",
					maxlength: "<p class='vali-error'>Vui lòng nhập nhiều nhất 255 ký tự</p>"
				},
			}
		});
	});
</script>
<div class="container-fluid">
	<!-- Title -->
	<div class="row heading-bg">
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		  <h5 class="txt-dark">Sửa sản phẩm</h5>
		</div>
		<!-- Breadcrumb -->
		<!-- /Breadcrumb -->
	</div>
	<!-- /Title -->
	
	<!-- Row -->
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default card-view">
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="form-wrap">
							<form id="edit_product" action="${pageContext.request.contextPath }/admin/product/edit/${objProduct.id_product }" method="post" enctype="multipart/form-data">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Sản phẩm</label>
											<input name="name_product" type="text" id="firstName" class="form-control" placeholder="tên sản phẩm" value="${objProduct.name_product }">
											<form:errors path="objProduct.name_product" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">Status</label>
											<div class="radio-list">
												<div class="radio-inline pl-0">
													<div class="radio radio-info">
														<input <c:if test="${objProduct.status_product == 1 }">checked</c:if> type="radio" name="status_product" id="radio1" value="1">
														<label for="radio1">Công bố</label>
													</div>
												</div>
												<div class="radio-inline">
													<div class="radio radio-info">
														<input <c:if test="${objProduct.status_product == 0 }">checked</c:if> type="radio" name="status_product" id="radio2" value="0">
														<label for="radio2">Nháp</label>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label class="control-label mb-10">Sản phẩm nổi bật</label>
											<div class="radio-list">
												<div class="radio-inline pl-0">
													<div class="radio radio-info">
														<input <c:if test="${objProduct.highlight == 1 }">checked</c:if> type="radio" name="highlight" id="radio1" value="1">
														<label for="radio1">Có</label>
													</div>
												</div>
												<div class="radio-inline">
													<div class="radio radio-info">
														<input <c:if test="${objProduct.status_product == 0 }">checked</c:if> type="radio" name="highlight" id="radio2" value="0">
														<label for="radio2">Không</label>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!--/span-->
								</div>
								
								<!-- Row -->
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Danh mục</label>
											<select name="id_cat" class="form-control select2" data-placeholder="Choose a Category" tabindex="1">
											<c:forEach items="${alCat }" var="objCat">
												<c:if test="${objCat.id_parent == 0 && catDao.checkChild(objCat.id_cat).size() != 0 }">
													<optgroup label="${objCat.name_cat }">
													<c:forEach items="${alCat }" var="objItem">
														<c:if test="${objItem.id_parent == objCat.id_cat }">
															<option <c:if test="${objProduct.id_cat==objItem.id_cat }">selected="selected"</c:if> value="${objItem.id_cat }">${objItem.name_cat }</option>
														</c:if>
													</c:forEach>
													<c:if test="${objProduct.id_cat==objItem.id_cat }">selected="selected"</c:if>
													</optgroup>
												</c:if>
												<c:if test="${objCat.id_parent == 0 && catDao.checkChild(objCat.id_cat).size() == 0 }">
													<option <c:if test="${objProduct.id_cat==objCat.id_cat }">selected="selected"</c:if> value="${objCat.id_cat }">${objCat.name_cat }</option>
												</c:if>
											</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">hãng sản xuất</label>
											<select name="id_brand" class="form-control select2" data-placeholder="Choose a brand" tabindex="1">
											<c:forEach items="${alBrand }" var="objBrand">
												<option <c:if test="${objProduct.id_brand==objBrand.id_brand }">selected="selected"</c:if> value="${objBrand.id_brand }">${objBrand.name_brand }</option>
											</c:forEach>
											</select>
										</div>
									</div>									
									<!--/span-->
								</div>
								<!--/row-->
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Giá</label>
											<div class="input-group">
												<div class="input-group-addon">VNĐ</div>
												<input name="price_product" type="text" class="form-control" id="exampleInputuname" placeholder="" value="${objProduct.price_product }">
												<form:errors path="objProduct.price_product" cssStyle="color:red; display: block"></form:errors>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="control-label mb-10">Giảm giá(%)</label>
											<div class="input-group">
												<div class="input-group-addon"><i class="ti-money"></i></div>
												<select name="discount_product" class="form-control select2" data-placeholder="Choose a brand" tabindex="1">
												<c:forEach var="i" begin="0" end="100" step="1">
													<option <c:if test="${objProduct.discount_product == i }">selected="selected"</c:if> value="${i }">${i }</option>
												</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<!--/span-->
								</div>
								<div class="seprator-block"></div>
								<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-comment-text mr-10"></i>Mô tả</h6>
								<hr class="light-grey-hr"/>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<textarea name="preview_product" class="form-control" rows="4">${objProduct.preview_product }</textarea>
											<form:errors path="objProduct.preview_product" cssStyle="color:red; display: block"></form:errors>
										</div>
									</div>
								</div>
								<!--/row-->
								<div class="seprator-block"></div>
								<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-comment-text mr-10"></i>Chi tiết</h6>
								<hr class="light-grey-hr"/>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<textarea id="detail_ecommerce" name="detail_product" class="form-control" rows="4">${objProduct.detail_product }</textarea>
										</div>
									</div>
								</div>
								<script type="text/javascript">
                                   	var editor = CKEDITOR.replace('detail_ecommerce');
                                   	CKFinder.setupCKEditor(editor, '/ecommerce/templates/admin/js/ckfinder/');
                                </script>
								<div class="seprator-block"></div>
								<h6 class="txt-dark capitalize-font"><i class="zmdi zmdi-collection-image mr-10"></i>Hình ảnh</h6>
								<hr class="light-grey-hr"/>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<input name="picture" type="file" class="upload" />
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label class="control-label mb-10">Ảnh cũ</label>
											<img class="form-control" style="width: 120px; height: 90px" alt="" src="${pageContext.request.contextPath }/files/${objProduct.picture_product }" />
										</div>
									</div>
								</div>
								<div class="form-actions">
									<button type="submit" class="btn btn-success btn-icon left-icon mr-10 pull-left"> <i class="fa fa-check"></i> <span>Edit</span></button>
									<a href="${pageContext.request.contextPath }/admin/product" type="button" class="btn btn-warning pull-left">Go back</a>
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