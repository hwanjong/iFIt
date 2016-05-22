<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<jsp:include page="/jsp/include/head.jsp" flush="false">
			<jsp:param value=""  name="title"/>
		</jsp:include>
		<script type="text/javascript">
			$(function(){
				$(document).on("click",".colorSelected",function(e){
					if(!confirm("해당 색상을 삭제 하시겠습니까?")){
						return false;
					}
					$(this).remove();
				});
				
				// 상품 메인 이미지
				$('#p_main_url').filer({
				    limit: 1,
				    maxSize: 10,
				    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
				    showThumbs: true,
				    templates: FilerTemplate.edit,
				    addMore: true
				});
				
				// 상품 상세 이미지
				$('#detail_url').filer({
				    limit: 5,
				    maxSize: 10,
				    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
				    showThumbs: true,
				    templates: FilerTemplate.edit,
				    addMore: true
				});
				
				// 상품 코디 이미지
				$('#lookup_url').filer({
				    limit: 1,
				    maxSize: 10,
				    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
				    showThumbs: true,
				    templates: FilerTemplate.edit,
				    addMore: true
				});
			});
		</script>
	</head>
	<body>
		<jsp:include page="/jsp/include/gnb.jsp" flush="false" />
		<div class="admin_container">
			<jsp:include page="/jsp/include/lnb.jsp" flush="false" />
			<div class="adminContentArea">
				<h2 class="mb20"><span>일반상품 등록</span></h2>
				<div class="contentBody">
					<s:form id="generalProduct" name="generalProductWriter" data-mode="WriteForm" data-confirm-msg="상품을 등록 하시겠습니까?" cssClass="dib" method="post" namespace="/product" action="generalProductWriteAction" theme="simple" enctype="multipart/form-data">
						<input type="hidden" id="queryDecode" name="queryDecode" value="<s:property value='queryDecode' />"  disabled />	
						<table class="table_editor tc">
							<colgroup>
								<col width="180px"><col width="*">
							</colgroup>
							<tbody>
								<s:if test = "#session.isAdmin">
									<tr>
										<th scope="col">입점업체명</th>
										<td tabIndex="1" id="admin_seq_check" >
											<input type="hidden" class="validate" id="admin_seq" name="admin_seq" value="" />
											<input type="text" class="pointer openPop" data-pop-id="shopSearch" autocomplete="off" placeholder="업체 검색" id="admin_name" value="" readonly />
										</td>
									</tr>
								</s:if>
								<s:else>
									<input type="hidden" class="validate" id="admin_seq" name="admin_seq" value="<s:property value="#session.admin_seq" />" />
								</s:else>
								<tr>
									<th scope="col">상품명</th>
									<td tabIndex="2" id="p_name_check"><input type="text" class="validate" autocomplete="off" id="p_name" name="p_name" value="${p_name}" /></td>
								</tr>
								<tr>
									<th scope="col">상품분류</th>
									<td class="tl" tabIndex="3" id="category_check"><s:select id="category" name="category" cssClass="validate" list="Code.productCategoryMap" headerKey="" headerValue="선택" /></td>
								</tr>
								<tr>
									<th scope="col">가격</th>
									<td class="tl" tabIndex="4" id="p_price_check">
										<input type="text" class="validate" autocomplete="off" numberonly="true" id="p_price" name="p_price" value="${p_price}" />원
										<span class="ml5">(ex: 10000, 20000 등 숫자로 입력 )</span>
									</td>
								</tr>
								<tr>
									<th scope="col">색상</th>
									<td class="tl" tabIndex="5" id="p_color_check">
										<p class="colorReady vm mr10">
											<i class="openPop ml10 fa fa-plus" data-pop-id="colorSelector" title="색상추가"></i>
										</p>
									</td>
								</tr>
								<tr>
									<th scope="col">사이즈</th>
									<td class="tl" tabIndex="6" id="p_size_check">
										<s:select id="sizeArray" name="sizeArray" cssClass="" list="sizeList" listKey="size_id" listValue="size_val" multiple="true" />
										<span class="ml5">(Ctrl 혹은 Shift 키를 누른상태로 클릭하면 복수선택 가능)</span>
									</td>
								</tr>
								<tr>
									<th scope="col">메인이미지</th>
									<td class="tl" tabIndex="7" id="p_main_url_check"><input type="file" id="p_main_url" class="validate p_main_url" name="p_main_url" autocomplete="off" multiple="multiple" /></td>
								</tr>
								<tr>
									<th scope="col">상세이미지</th>
									<td class="tl" tabIndex="8" id="detail_url_check"><input type="file" id="detail_url" class="validate detail_url" name="detail_url" autocomplete="off" multiple="multiple" /></td>
								</tr>
								<tr>
									<th scope="col">코디이미지</th>
									<td class="tl" tabIndex="9" id="lookup_url_check"><input type="file" id="lookup_url" class="validate lookup_url" name="lookup_url" autocomplete="off" multiple="multiple" /></td>
								</tr>
								<tr>
									<th scope="col">3D 코드</th>
									<td class="tl"><input type="text" class="validate" autocomplete="off" id="cat_ref" name="cat_ref" value="${cat_ref}" /></td>
								</tr>
								<tr>
									<th scope="col">상세설명</th>
									<td class="tl">
										<textarea id="detail_info" name="detail_info" class="validate">${detail_info}</textarea>
									</td>
								</tr>
								<tr>
									<th scope="col">태그</th>
									<td class="tl"><input type="text" autocomplete="off" /></td>
								</tr>
							</tbody>
						</table>
						<div class="mt20 clear">
							<input type="button" class="listBtn simpleBtn mb10 btn2 dib fl" value="목록으로" />
							<input type="submit" class="writeActionBtn simpleBtn mb10 btn2 dib fr" value="등록" />
						</div>
					</s:form>
				</div>
			</div>
		</div>
		
		<jsp:include page="/jsp/product/pop/shopSearch.jsp" flush="false" />
		<jsp:include page="/jsp/product/pop/colorSelector.jsp" flush="false" />
	</body>
</html>