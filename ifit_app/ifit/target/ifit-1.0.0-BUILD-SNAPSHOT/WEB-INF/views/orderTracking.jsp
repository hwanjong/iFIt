<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css" />
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>

<!--  Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/orderTracking.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">

<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>
<script type="text/javascript" src="js/orderTracking.js"></script>
<script src="js/common/backHeader.js"></script>
<script src="js/deviceRender.js"></script>
</head>
<body>
	<div data-role="page" id="orderTracking" class="eachPage render"
		data-render="padding-left,padding-right,padding-top">
		<div data-role="header" data-position="fixed" data-tap-toggle="false"
			id="backheader" class="render" data-render="height"
			data-render-ratio="height">
			<span id="backBtn" data-rel="back" class="render"
				data-render="width,height,left,background-size"
				data-render-ratio="height"></span> <span id="pageName"
				class="font-size-16 render" data-render="line-height,font-size"
				data-render-ratio="height">주문 / 배송</span> <span
				class="headerMargin render" data-render="height,border-top-width"
				data-render-ratio="height"></span>
		</div>
		<div id="orderContent" class="render"
			data-render="margin-top,margin-bottom">
			<c:forEach var="order" items="${orderList}">
				<c:if test="${order.state == 1 }">
					<hr class="order_item_separate clear render"
						data-render="width,border-top-width,margin-top" />
					<div class="order_item render"
						data-render="width,height,margin-bottom">
						<div class="itemPhotoArea center render"
							data-render="width,height,line-height">
							<img class="cart_photo" src="http://${order.productURL }" onclick="getMoreInfo(${order.productId})">
						</div>
						<div class="itemOptionArea render"
							data-render="width,height,padding-top,padding-bottom,padding-left">
							<div class="black font-size-13 mb10 render"
								data-render="width,height,margin-bottom,font-size,line-height">
								<p class="font-size-13 render dib" data-render="font-size">${order.productName }</p>
								<p class="priceInfo mr10 right render" data-render="margin-right">${order.price }</p>
							</div>
							<div class="black mb10 render"
								data-render="width,height,line-height,margin-bottom">
								<p class="colorValue dib render mr10" data-render="width,height,margin-right" data-render-ratio="width,height" style="background-color: ${order.colorName};"></p>
								<ul id="selectSize" class="middle font-size-13 render"
									data-render="font-size">
									<li class="render" data-render="width,height,margin-right">${order.sizeName }</li>
								</ul>
								<p class="middle font-size-13 render dib"
									data-render="font-size">${order.amount }개</p>
							</div>
							<div class="font-size-13 mb10 render"
								data-render="width,height,margin-bottom,line-height">
								<p class="font-size-13 render dib" data-render="font-size">${order.deliveryNumber }</p>
							</div>
							<div class="font-size-13 render"
								data-render="width,height,font-size,line-height">
								<p class="black font-size-13 render dib left"
									data-render="font-size">접수대기중</p>
								<hr class="connect_line render"
									data-render="width,border-top-width" />
								<p class="font-size-13 render dib" data-render="font-size">배송중</p>
								<hr class="connect_line render"
									data-render="width,border-top-width" />
								<p class="font-size-13 render dib" data-render="font-size">배송완료</p>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${order.state == 2 }">
					<hr class="order_item_separate clear render"
						data-render="width,border-top-width,margin-top" />
					<div class="order_item render"
						data-render="width,height,margin-bottom">
						<div class="itemPhotoArea center render"
							data-render="width,height,line-height">
							<img class="cart_photo" src="http://${order.productURL }" onclick="getMoreInfo(${order.productId})">
						</div>
						<div class="itemOptionArea render"
							data-render="width,height,padding-top,padding-bottom,padding-left">
							<div class="black font-size-13 mb10 render"
								data-render="width,height,margin-bottom,font-size,line-height">
								<p class="font-size-13 render dib" data-render="font-size">${order.productName }</p>
								<p class="priceInfo mr10 right render" data-render="margin-right">${order.price }</p>
							</div>
							<div class="black mb10 render"
								data-render="width,height,line-height,margin-bottom">
								<p class="colorValue dib render mr10" data-render="width,height,margin-right" data-render-ratio="width,height" style="background-color: ${order.colorName};"></p>
								<ul id="selectSize" class="middle font-size-13 render"
									data-render="font-size">
									<li class="render" data-render="width,height,margin-right">${order.sizeName }</li>
								</ul>
								<p class="middle font-size-13 render dib"
									data-render="font-size">${order.amount }개</p>
								<div class="regist fr mr10 render" data-render="margin-right"  data-order_seq="${order.orderSeq }" data-product_id="${order.productId }" >
									<p class="font-size-13 fr render dib" data-render="font-size">평가하기</p>
									<img src="img/mypage/emptyStar.png" class="star_icon render fr"
										data-render="width,margin-top">
								</div>
							</div>
							<div class="font-size-13 mb10 render"
								data-render="width,height,margin-bottom,line-height">
								<p class="font-size-13 render dib" data-render="font-size">${order.deliveryNumber }</p>
							</div>
							<div class="font-size-13 render"
								data-render="width,height,font-size,line-height">
								<p class="font-size-13 render dib left" data-render="font-size">접수대기중</p>
								<hr class="connect_line render"
									data-render="width,border-top-width" />
								<p class="black font-size-13 render dib" data-render="font-size">배송중</p>
								<hr class="connect_line render"
									data-render="width,border-top-width" />
								<p class="font-size-13 render dib" data-render="font-size">배송완료</p>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${order.state == 3 }">
					<hr class="order_item_separate clear render"
						data-render="width,border-top-width,margin-top" />
					<div class="order_item render"
						data-render="width,height,margin-bottom">
						<div class="itemPhotoArea center render"
							data-render="width,height,line-height">
							<img class="cart_photo" src="http://${order.productURL }" onclick="getMoreInfo(${order.productId})">
						</div>
						<div class="itemOptionArea render"
							data-render="width,height,padding-top,padding-bottom,padding-left">
							<div class="black font-size-13 mb10 render"
								data-render="width,height,margin-bottom,font-size,line-height">
								<p class="font-size-13 render dib" data-render="font-size">${order.productName}</p>
								<p class="priceInfo mr10 right render" data-render="margin-right">${order.price}</p>
							</div>
							<div class="black mb10 render"
								data-render="width,height,line-height,margin-bottom">
								<p class="colorValue dib render mr10" data-render="width,height,margin-right" data-render-ratio="width,height" style="background-color: ${order.colorName};"></p>
								<ul id="selectSize" class="middle font-size-13 render"
									data-render="font-size">
									<li class="render" data-render="width,height,margin-right">${order.sizeName }</li>
								</ul>
								<p class="middle font-size-13 render dib"
									data-render="font-size">${order.amount }개</p>
								<div class="fr mr10 dib render" data-render="margin-right">
									<c:forEach begin="${order.score }" end="4" >
										<img src="img/mypage/emptyStar.png" class="star_icon render fr" data-render="width,margin-top">
									</c:forEach>
									<c:forEach begin="1" end="${order.score }" >
										<img src="img/mypage/fullStar.png" class="star_icon render fr" data-render="width,margin-top">
									</c:forEach>  
								</div>
							</div>
							<div class="font-size-13 mb10 render"
								data-render="width,height,margin-bottom,line-height">
								<p class="font-size-13 render dib" data-render="font-size">${order.deliveryNumber }</p>
							</div>
							<div class="font-size-13 render"
								data-render="width,height,font-size,line-height">
								<p class="font-size-13 render dib left" data-render="font-size">접수대기중</p>
								<hr class="connect_line render"
									data-render="width,border-top-width" />
								<p class="font-size-13 render dib" data-render="font-size">배송중</p>
								<hr class="connect_line render"
									data-render="width,border-top-width" />
								<p class="black font-size-13 render dib" data-render="font-size">배송완료</p>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
			<hr class="order_item_separate clear render"
				data-render="width,border-top-width,margin-top" />
		</div>
		<div class="t-center">
			<img class="bottomAnchor render" src="img/anchor.png"
				data-render="width,margin-top,margin-bottom"
				onclick="window.scrollTo(0,0);" />
		</div>
		<div data-role="popup" id="registPopup" data-history="false"
			data-overlay-theme="d" class="font-size-13 render"
			data-render="font-size">
			<div data-role="content">
				<div id="popupHead" class="font-size-16 render mb10"
					data-render="margin-bottom,font-size">평가하기 입력</div>
				<div id="popupBody" class="mb10 render" data-render="margin-bottom">
					<div id="starWrap" class="render"
						data-render="height,width,line-height,border-bottom-width,padding-left,padding-right">
						<img src="img/mypage/fullStar.png" class="starItem render"
							id="star_1" data-render="width"> <img
							src="img/mypage/fullStar.png" class="starItem render" id="star_2"
							data-render="width"> <img src="img/mypage/fullStar.png"
							class="starItem render" id="star_3" data-render="width"> <img
							src="img/mypage/fullStar.png" class="starItem render" id="star_4"
							data-render="width"> <img src="img/mypage/emptyStar.png"
							class="starItem render" id="star_5" data-render="width">
					</div>
					<input id="evaluation" class="render" name="comment"
						data-render="width,height,padding-left,padding-right,font-size"
						data-role="none" type="text" placeholder="내용을 입력 해 주세요(200자)">
				</div>
				<div id="pupupFoot" class="render" data-render="width,height">
					<div id="cancelBtn" class="dib fl render"
						data-render="height,line-height">취소</div>
					<div id="writeBtn" class="dib fr render"
						data-render="height,line-height">완료</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>