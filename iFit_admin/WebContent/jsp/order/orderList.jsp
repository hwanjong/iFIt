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
				<h2 class="mb20"><span>판매리스트</span></h2>
				<div class="contentBody">
					<s:form id="order" name="orderList" cssClass="dib" method="get" namespace="/order" action="orderList" theme="simple">
						<input type="hidden" id="pageNum" name="pageNum" value="<s:property value="pageNum"/>" />
						<input type="hidden" id="sortCol" name="sortCol" value="<s:property value='sortCol' />" />	
						<input type="hidden" id="sortVal" name="sortVal" value="<s:property value='sortVal' />" />
						<input type="hidden" id="queryIncode" name="queryIncode" value="<s:property value='queryIncode' />"  disabled />	
						보기 : <s:select id="countPerPage" name="countPerPage" cssClass="" list="Code.countPerPageMap" headerKey="" headerValue="" />
						<input type="button" class="writeBtn simpleBtn mb10 btn2 clear fr" value="등록" />
						<table class="table_list tc">
							<colgroup>
								<col width="70px"><col width="70px"><col width="70px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col"><p class="listSort" data-sort-col="1">제목<i class="ml5 fa <s:if test='sortVal.equals("DESC")'>fa-caret-down</s:if><s:else>fa-caret-up</s:else> <s:if test="sortCol!=1">hide</s:if>" aria-hidden="true"></i></p></th>
									<th scope="col">추가작업</th>
								</tr>
							</thead>
							<tbody>
								<s:if test = "dataList.size==0">
									<tr>
										<td colspan="3" align="center">
											판매내역이 없습니다.
										</td>
									</tr>
								</s:if>
								<s:iterator value="dataList" status="stat">
									<tr>
										<td class="center"><s:property value="sub_seq"/></td>
										<td class="center"><p class="viewBtn pointer hoverLine" data-seq="<s:property value="sub_seq"/>"><s:property value="title"/></p></td>
										<td class="center">
											<i class="editBtn mr10 fa fa-pencil-square-o" aria-hidden="true" title="편집" data-seq="<s:property value="sub_seq"/>" > </i>
											<i class="deleteBtn fa fa-trash-o" aria-hidden="true" title="삭제" data-seq="<s:property value="sub_seq"/>" data-title="<s:property value="title"/>"></i>
										</td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
						<s:if test = "dataList.size!=0">
							<div class="paging"><s:property value="pagingHTML" escapeHtml="false" /></div>
						</s:if>
						<div class="tc">
							<select id="searchCol" name ="searchCol" class="common_select middle">
								<option title="제목을 검색합니다." value="1" <s:if test="searchCol==1">selected</s:if>>제목</option>
							</select>
							<input type="text" name ="searchVal" class="ml5 searchInput" value="${searchVal}" /><i class="listSearchBtn ml10 fa fa-search" aria-hidden="true" title="검색" > </i>
						</div>
					</s:form>
				</div>
			</div>
		</div>		
	</body>
</html>