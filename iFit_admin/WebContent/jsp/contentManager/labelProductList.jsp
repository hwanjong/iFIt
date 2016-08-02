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
				$("#main_type").change(function(){
					$(this).parents("form").submit();
				});
				
				$( "#sortable" ).sortable({
					placeholder: "ui-state-highlight"
				});
				$( "#sortable" ).disableSelection();
				
				$("#contentDeleteBtn").click(function(){
					if(confirm("[" + $(this).prev().val() + "] 컨텐츠를 삭제하시겠습니까?")){
						var inputHTML = '<input type="hidden" name="deleteContentList" value="' + $(".ui-selected").find("input[name='m_p_seq']").val() + '" />';
						$("#labelProduct").append(inputHTML);
						$(".ui-selected").remove();
						$(this).prev().val("");
						$("#labelProductDetailAreaInput").hide();
					}
				});
			});
			
			$(document).on("click","#sortable li",function(e){
				$("#sortable li").removeClass("ui-selected");
				$(this).addClass("ui-selected");
				$("#labelProductDetailAreaInput").show();
				$("#labelProductDetailAreaInput #new_p_name").val($(this).find("input[name='p_name']").val());
			});
			
			/*
			$(document).on("keyup","#new_p_name",function(e){
				$(".ui-selected").find("input[name=p_name']").val($(this).val());
				$(".ui-selected").find("span").html($(this).val());
			});
			*/
		</script>
	</head>
	<body>
		<jsp:include page="/jsp/include/gnb.jsp" flush="false" />
		<div class="admin_container">
			<jsp:include page="/jsp/include/lnb.jsp" flush="false" />
			<div class="adminContentArea">
				<h2 class="mb20"><span>라벨컨텐츠</span></h2>
				<div class="contentBody">
					<s:form id="labelProduct2" name="labelProductList" method="get" namespace="/contentManager" action="labelProductList" theme="simple">
						<s:select id="main_type" name="main_type" list="labelList" listKey="main_type" listValue="label_name" />
					</s:form>
					<s:form id="labelProduct" name="labelProductEditor" data-mode="EditorForm" data-confirm-msg="라벨컨텐츠를 저장 하시겠습니까?" cssClass="dib" method="post" namespace="/contentManager" action="labelProductUpdateAction" theme="simple">
						<input type="hidden" name="main_type" value="<s:property value="main_type"/>" />
						<div id="labelProductEditArea">
							<div class="dib fl">
								<ul id="sortable">
									<s:iterator value="dataList" status="stat">
										<li class="pointer ui-state-default"><input type="hidden" name="m_p_seq" value="<s:property value="m_p_seq"/>" /><input type="hidden" id="p_id" name="p_id" value="<s:property value="p_id"/>" /><input type="hidden" name="p_name" value="<s:property value="p_name"/>" /><span><s:property value="p_name"/></span></li>
									</s:iterator>
								</ul>
								<p id="labelProductAddBtn" class="pointer openPop" data-pop-id="productSearch">
									<i class="mt5 ml5 fa fa-plus db" title="컨텐츠추가" ></i>
								</p>
							</div>
							<div id="labelProductDetailArea" class="fl dib">
								<div class="hide" id="labelProductDetailAreaInput">
									<span class="mr10">컨텐츠명</span>
									<input type="text" autocomplete="off" id="new_p_name" value="" readonly />
									<input type="button" id="contentDeleteBtn" value="삭제" />
								</div>
								<div id="labelProductDetailAreaDefault">
									<h4>라벨컨텐츠 설정 안내</h4>
									<ul>
										<li>상단 셀렉트박스로 원하는 라벨을 선택할 수 있습니다.</li>
										<li>+버튼을 클릭하면 컨텐츠를 추가할 수 있습니다.</li>
										<li>드래그 앤 드롭으로 순서를 변경할 수 있습니다.</li>
										<li>컨텐츠를 클릭하면 상세항목이 표시됩니다.</li>
										<li>
											<span>컨텐츠를 편집한 후에 저장하기 버튼을 꼭 클릭해야<br/>변경된 내용이 반영됩니다.</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="mt20 tc">
							<input type="submit" class="updateActionBtn simpleBtn mb10 btn2 clear" value="저장" />
						</div>
					</s:form>
				</div>
			</div>
		</div>
		
		<jsp:include page="/jsp/contentManager/pop/productSearch.jsp" flush="false" />
				
	</body>
</html>