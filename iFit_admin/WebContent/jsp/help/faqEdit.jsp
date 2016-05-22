<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="layer layer-faqEdit" data-close-answer="true">
	<div class="bg"></div>
	<div id="popLayer" class="pop-layer faqEditPop">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<p id="pop-title" class="pop-title mb20 pb10">자주하는질문 수정</p>
				<form name="faqEditForm" id="faqEditForm" method="post" action="<s:url namespace="/help" action="faqEditAction"/>" data-confirm-msg="자주하는질문을 수정하시겠습니까?">
					<input type="hidden" id="seq" name="seq" value="" />
					<div class="pl20 pr20">
						<div class="mb25">
							<p class="dib mr15 fl">제목</p>
							<p class="dib">
								<input type="text" id="faq_title" class="validate" name="faq_title" autocomplete="off" value="${faq_title}" />
							</p>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl">내용</p>
							<p class="dib">
								<textarea id="faq_content" name="faq_content" class="validate">${faq_content}</textarea>
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