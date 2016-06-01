<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<div class="adminLnbArea">
	<ul class="lnb_ul">
		<s:if test = "#session.isAdmin">
			<li>
				<p class="bold">회원관리</p>
				<ul>
					<li>
						<p><a href="<s:url namespace="/member" action="shopMemberList" />">- 입점회원</a></p>
						<p><a class="yet" href="#">- 일반회원</a></p>
					</li>
				</ul>
			</li>
		</s:if>
		<li>
			<p class="bold">상품관리</p>
			<ul>
				<li>
					<p><a href="<s:url namespace="/product" action="generalProductList" />">- 일반상품</a></p>
				</li>
			</ul>
		</li>
		<s:if test = "#session.isAdmin">
			<li>
				<p class="bold">노출컨텐츠관리</p>
				<ul>
					<li>
						<p><a href="<s:url namespace="/contentManager" action="mainLabelList" />">- 메인라벨관리</a></p>
						<p><a href="<s:url namespace="/contentManager" action="labelProductList" />">- 라벨컨텐츠</a></p>
						<p><a href="<s:url namespace="/contentManager" action="adminTagList" />">- 태그관리</a></p>
						<p><a class="yet" href="#">- 사이즈맵관리</a></p>
					</li>
				</ul>
			</li>
		</s:if>
		<li>
			<p class="bold">주문관리</p>
			<ul>
				<li>
					<p><a class="yet" href="#">- 판매리스트</a></p>
				</li>
			</ul>
		</li>
		<s:if test = "#session.isAdmin">
			<li>
				<p class="bold">컨텐츠관리</p>
				<ul>
					<li>
						<p><a href="<s:url namespace="/banner" action="eventBannerList" />">- 이벤트배너</a></p>
						<p><a class="yet" href="#">- 기획전</a></p>
					</li>
				</ul>
			</li>
			<li>
				<p class="bold">고객센터</p>
				<ul>
					<li>
						<p><a href="<s:url namespace="/help" action="faqList" />">- 자주하는질문</a></p>
						<p><a class="yet" href="#">- 1:1문의</a></p>
					</li>
				</ul>
			</li>
			<li>
				<p class="bold">거래현황</p>
				<ul>
					<li>
						<p><a class="yet" href="#">- 업체별 판매현황</a></p>
						<p><a class="yet" href="#">- 두비 매출</a></p>
					</li>
				</ul>
			</li>
		</s:if>
	</ul>
</div>
