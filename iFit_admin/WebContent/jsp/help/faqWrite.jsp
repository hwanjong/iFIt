<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="layer layer-faqWrite" data-close-answer="true">
	<div class="bg"></div>
	<div id="popLayer" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<p id="pop-title" class="pop-title mb20 pb10">자주하는질문 등록</p>
				<form name="faqWriteForm" id="faqWriteForm" method="post" action="<s:url namespace="/help" action="faqWriteAction"/>" data-confirm-msg="자주하는질문을 등록하시겠습니까?">
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
						<input type="submit" id="writeBtn" class="submitBtn" value="등록" />
					</div>
				</form>
				<div class="btn-r">
					<i class="layerClose fa fa-times fa-2x" aria-hidden="true" title="닫기"></i>
				</div>
			</div>
		</div>
	</div>
</div>