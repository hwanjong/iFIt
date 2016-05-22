<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="layer layer-shopMemberEdit" data-close-answer="true">
	<div class="bg"></div>
	<div id="popLayer" class="pop-layer shopMemberEditPop">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<p id="pop-title" class="pop-title mb20 pb10">입점회원 정보 수정</p>
				<form name="shopMemberEditForm" id="shopMemberEditForm" method="post" action="<s:url namespace="/member" action="shopMemberEditAction"/>" data-confirm-msg="입점회원 정보를 수정하시겠습니까?">
					<input type="hidden" id="seq" name="seq" value="" />
					<div class="pl20 pr20">
						<div class="mb25">
							<p class="dib mr15">아이디</p>
							<p class="dib ml15" id="shop_id"></p>
						</div>
						<div class="mb25">
							<p class="dib mr15">업체명</p>
							<p class="dib">
								<input type="text" id="shop_name" class="ml18 validate" name="shop_name" autocomplete="off" value="${shop_name}" />
							</p>
						</div>
						<div class="mb25">
							<p class="dib mr15">연락처</p>
							<p class="dib">
								<s:select id="shop_tel1" name="shop_tel1" cssClass="ml18 validate" list="Code.telNumberMap" headerKey="" headerValue="선택" />-
								<input type="text" id="shop_tel2" class="validate" name="shop_tel2" autocomplete="off" maxlength="4" value="${shop_tel2}" />-
								<input type="text" id="shop_tel3" class="validate" name="shop_tel3" autocomplete="off" maxlength="4" value="${shop_tel3}" />
							</p>
						</div>
					</div>
					<div class="tc mt10">
						<input type="submit" id="editBtn" class="submitBtn" value="수정" />
					</div>
				</form>
				<div class="btn-r">
					<i class="layerClose fa fa-times fa-2x" aria-hidden="true" title="닫기"></i>
				</div>
			</div>
		</div>
	</div>
</div>