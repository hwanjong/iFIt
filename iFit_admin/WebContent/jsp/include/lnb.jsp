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
			<p class="bold">판매관리</p>
			<ul>
				<li>
					<p><a class="yet" href="#">- 판매리스트</a></p>
				</li>
			</ul>
		</li>
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
				<p class="bold">광고관리</p>
				<ul>
					<li>
						<p><a class="yet" href="#">- 메인광고</a></p>
						<p><a class="yet" href="#">- 제휴광고</a></p>
					</li>
				</ul>
			</li>
			<li>
				<p class="bold">고객센터</p>
				<ul>
					<li>
						<p><a class="yet" href="#">- 1:1문의</a></p>
						<p><a href="<s:url namespace="/help" action="faqList" />">- 자주하는질문</a></p>
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
