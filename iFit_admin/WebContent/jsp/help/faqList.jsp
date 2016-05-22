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
			});
		</script>
	</head>
	<body>
		<jsp:include page="/jsp/include/gnb.jsp" flush="false" />
		<div class="admin_container">
			<jsp:include page="/jsp/include/lnb.jsp" flush="false" />
			<div class="adminContentArea">
				<h2 class="mb20">자주하는질문 목록</h2>
				<div class="contentBody">
					<input id="pageNum" type="hidden" value="<s:property value="pageNum"/>" />
					<input type="button" data-layer-id="faqWrite" class="writeBtn simpleBtn mb10 btn2 clear fr" value="등록" />
					<table class="table_list tc">
						<colgroup>
							<col width="70px"><col width="70px"><col width="70px"><col width="70px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">등록일</th>
								<th scope="col">추가작업</th>
							</tr>
						</thead>
						<tbody>
							<s:if test = "dataList.size==0">
								<tr>
									<td colspan="4" align="center">
										등록된 질문이 없습니다.
									</td>
								</tr>
							</s:if>
							<s:iterator value="dataList" status="stat">
								<tr>
									<td class="center"><s:property value="seq"/></td>
									<td class="center"><s:property value="title"/></td>
									<td class="center"><s:property value="regdate"/></td>
									<td class="center">
										<i class="viewBtn mr10 fa fa-file-text-o" aria-hidden="true" title="보기" data-layer-id="faqView" data-kind="faq" data-seq="<s:property value="seq"/>" > </i>
										<i class="editBtn mr10 fa fa-pencil-square-o" aria-hidden="true" title="편집" data-layer-id="faqEdit" data-kind="faq" data-seq="<s:property value="seq"/>" > </i>
										<i class="deleteBtn fa fa-trash-o" aria-hidden="true" title="삭제" data-kind="faq" data-seq="<s:property value="seq"/>" data-title="<s:property value="title"/>"></i>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
					<s:if test = "dataList.size!=0">
						<div class="paging"><s:property value="pagingHTML" escapeHtml="false" /></div>
					</s:if>
				</div>
			</div>
		</div>
		
		<jsp:include page="/jsp/help/faqView.jsp" flush="false" />
		<jsp:include page="/jsp/help/faqWrite.jsp" flush="false" />
		<jsp:include page="/jsp/help/faqEdit.jsp" flush="false" />
		
	</body>
</html>