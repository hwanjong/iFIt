<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="layer layer-faqView" data-close-answer="false">
	<div class="bg"></div>
	<div id="popLayer" class="pop-layer faqViewPop">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<p id="faq_title" class="pop-title mb20 pb10"></p>
				<form name="faqViewForm" id="faqViewForm" method="post">
					<div class="pl20 pr20">
						<div class="mb25">
							<p class="dib mr15 fl">내용</p>
							<p id="faq_content" class="pop-content-box dib"></p>
						</div>
					</div>
				</form>
				<div class="btn-r">
					<i class="layerClose fa fa-times fa-2x" aria-hidden="true" title="닫기"></i>
				</div>
			</div>
		</div>
	</div>
</div>