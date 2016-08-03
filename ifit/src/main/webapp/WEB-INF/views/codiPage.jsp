<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 필수요소 -->
<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css" />
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>


<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">
<link href="css/codi.css" rel="stylesheet">

<script src="js/common/backHeader.js"></script>
<script src="js/deviceRender.js"></script>
<script src="js/codiPage.js"></script>
<script src="js/Carousel.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript">
function goCart(){
	if('${user}'==''){
		alert("로그인 후 이용하세요.");
		location = 'index.html#myPage';
		return;
	}
	showLoading();
	var productList = new Array();
	$(".codiSelect").each(function() {
		productList.push($(this).attr("data-product_id"));
	});
	$.ajax({
		 url: '/ifit/Users/codiToCart.ap',
		  type:"POST",
		  data: {productList:productList},
		  dataType: "json",
		  success: function(obj){
			  hideLoading();
			  if(obj.result =='success'){
				  location = 'index.html#cartPage';
			  }else{
				  alert("로그인 후 이용하세요");
				  location = 'index.html#myPage';
			  }
		  }
	});
}
</script>
</head>

<body>

	<div data-role="page" class="eachPage">
		<div data-role="header" data-position="fixed" data-tap-toggle="false"
			id="backheader" style="height: 3.5em; border-bottom: 1px groove;">
			<span id="backBtn" data-rel="back" style="line-height: 3.5em;"></span>
			<span id="pageName" class="font-size-16" data-render="font-size">옷장</span>
		</div>
		<div id="loadingDiv">
			<img src="img/ajax-loader.gif">
		</div>
		<div id="codiView">
			<div style="text-align: center;">
				<img src="img/closet/closetCallBtn.png" style=""
					onclick="closetCall();"> <img src="img/closet/refresh.png"
					width="25px;" style="position: absolute; right: 20px; top: 5px;"
					onclick="refresh();">
			</div>

			<div id="imgListDiv">
				<div class="selectItem"></div>

			</div>
			<div id="order"
				style="border-top: 2px groove; border-bottom: 2px solid gray; padding: 15px 15px 2px 15px;">
				<div class="font-size-13 mb10"
					style="height: 20px; margin-bottom: 10px;">
					<p class="font-size-13 render dib" data-render="font-size"
						style="font-size: 13px;">페이크 레더 점퍼</p>
					<p class="font-size-13 render dib fr" data-render="font-size"
						style="font-size: 13px;">￦36,000</p>
				</div>

				<div class="font-size-13 mb10"
					style="height: 20px; margin-bottom: 10px;">
					<p class="font-size-13 render dib" data-render="font-size"
						style="font-size: 13px;">페이크 레더 점퍼</p>
					<p class="font-size-13 render dib fr" data-render="font-size"
						style="font-size: 13px;">￦36,000</p>
				</div>

				<div class="font-size-13 mb10"
					style="height: 20px; margin-bottom: 10px;">
					<p class="font-size-13 render dib" data-render="font-size"
						style="font-size: 13px;">페이크 레더 점퍼</p>
					<p class="font-size-13 render dib fr" data-render="font-size"
						style="font-size: 13px;">￦36,000</p>
				</div>
			</div>
			<div class="mb10"
				style="height: 20px; padding-right: 10px; margin: 10px 0px;">
				<div id="funImg" class="dib">
					<div class="shareDiv">
						<a class="fb-xfbml-parse-ignore" target="_blank"
							href="https://www.facebook.com/sharer/sharer.php?u=http://175.126.82.37/ifit/pageView/codiPage.html"><img
							src="img/closet/face_color_icon.png"></a>
					</div>
					<div class="shareDiv">
						<a id="kakao-link-btn" href="javascript:;"> <img
							src="img/closet/kakaolink_btn_small.png">
						</a>
					</div>
				</div>
				<p id="totalPrice" class="font-medium font-size-18 render dib fr"
					data-render="font-size" style="font-size: 18px;"></p>

			</div>

		</div>

		<div id="closetSelector">
			<div class="container" id="container1">
				<img id="topIcon" src="img/closet/top.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>
					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 1 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }" /></li>
							<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 1 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }" /></li>
							<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 1 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									/></li>
									<c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>

			<div class="container" id="container2">
				<img id="topIcon" src="img/closet/pants.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>
					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 2 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 2 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 2 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									/></li>
									<c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>

			<div class="container" id="container3">
				<img id="topIcon" src="img/closet/skirt.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>
					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 3 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								' /></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 3 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 3 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									/></li>
									<c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>

			<div class="container" id="container4">
				<img id="topIcon" src="img/closet/onepiece.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>

					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 4 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								 /></li>
								 <c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 4 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 4 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									/></li>
									<c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>

			<div class="container" id="container5">
				<img id="topIcon" src="img/closet/outer.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>
					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 5 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 5 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 5 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									 /></li>
									 <c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>

			<!-- 드레스가 6번인데 빠져있으니 7번부터너야함. -->
			<div class="container" id="container6">
				<img id="topIcon" src="img/closet/accessorie.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>
					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 7 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								 /></li>
								 <c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 7 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 7 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									/></li>
									<c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>

			<div class="container" id="container7">
				<img id="topIcon" src="img/closet/shoes.png"
					style="position: absolute; left: 5px; top: 45%;">
				<ul>
					<c:set var="count" value="0"></c:set>
					<!-- 찜상품 -->
					<c:forEach var="best" items="${zzimList }">
						<c:if test="${best.category == 8 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 카트상품 -->
					<c:forEach var="best" items="${cartList }">
						<c:if test="${best.category == 8 }">
							<li data-product_id="${best.productId}"
								data-price="${best.productPrice }"
								data-product_name="${best.productName}"><img
								class="eachImg" src="http://${best.lookupURL }"
								/></li>
								<c:set var="count" value="${count+1 }"></c:set>

						</c:if>
					</c:forEach>
					<!-- 나머지채우기 -->
					<c:if test="${count < 5 }">
						<c:forEach var="best" items="${bestList }">
							<c:if test="${best.category == 8 && count <5 }">
								<li data-product_id="${best.productId}"
									data-price="${best.productPrice }"
									data-product_name="${best.productName}"><img
									class="eachImg" src="http://${best.lookupURL }"
									/></li>
									<c:set var="count" value="${count+1 }"></c:set>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
		<div id="codiHidDiv" style="display: none;">
			<img class="cancelImg" src="img/closet/cancel.png"
				style="position: absolute; top: 8px; right: 8px;"> <img
				class="cancelImg" src="img/closet/buy2.png"
				style="position: absolute; bottom: 10px; left: 19px; width: 26px;"
				onclick='location.href="moreInfoPage.html"'> <img
				class="cancelImg" src="img/closet/fitting.png"
				style="position: absolute; bottom: 10px; right: 19px; width: 26px;"
				onclick='alert("Fit N Shop 준비중");'>
		</div>
		<div id="cloCoFooter">
			<div id="closetFooter" onclick="codiCall();">
				<img src="img/closet/codi_icon.png" style="margin-right: 10px;">코디하기
			</div>
			<div id="codiFooter" style="display: none;">
				<div style="border-right: 1px solid white;"
					onclick='alert("Fit N shop 준비중")'>3D 피팅</div>
				<div onclick='goCart()'>구매하기</div>
			</div>
		</div>
	</div>
	<script type='text/javascript'>
		//<![CDATA[
		// // 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('ec0df6073da378bc5886481cc0aa3c91');
		// // 카카오톡 링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
		Kakao.Link
				.createTalkLinkButton({
					container : '#kakao-link-btn',
					label : '친구의 코디를 확인하세요.',
					image : {
						src : 'http://download.nboard2.naver.net/download/1000001521/2007121300000ACCD124E6CF/na3658/Untitled-2%20copy.jpg',
						width : '200',
						height : '300'
					},
					webButton : {
						text : '아이핏-코디',
						url : 'http://175.126.82.37/ifit/pageView/codiPage.html' // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
					}
				});
		//]]>
	</script>

	<script>
		window.fbAsyncInit = function() {
			FB.init({
				appId : '1861818357378765',
				xfbml : true,
				version : 'v2.6'
			});
			/*
			FB.ui({
				method:'share',
				mobile_iframe:true,
				href: 'https://developers.facebook.com/docs/',
			},function(response){});
			*/
		};

		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/ko_KR/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>
</body>
</html>