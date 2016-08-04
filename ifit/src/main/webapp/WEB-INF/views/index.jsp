<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">



<link rel="stylesheet"
	href="css/jquery.mobile-1.4.5.min.css" />
<script src="js/jquery-1.11.1.min.js"></script>
<script
	src="js/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="js/jssor.slider.mini.js"></script>
<script type="text/javascript" src="js/imageSliderMain.js"></script>

<!--  Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/main_home.css" rel="stylesheet">
<link href="css/category.css" rel="stylesheet">
<link href="css/three_d.css" rel="stylesheet">
<link href="css/hotdeal.css" rel="stylesheet">
<link href="css/myPage.css" rel="stylesheet">
<link href="css/product_list.css" rel="stylesheet">
<link href="css/cart.css" rel="stylesheet">
<link href="css/codi.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">

<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>
<script type="text/javascript" src="js/deviceRender.js"></script>
<script type="text/javascript" src="js/hotdeal.js"></script>
<script type="text/javascript" src="js/mypage.js"></script>
<script type="text/javascript" src="js/product_list.js"></script>
<script type="text/javascript" src="js/cart.js"></script>
<script type="text/javascript" src="js/codiPage.js"></script>
<script type="text/javascript" src="js/common/backHeader.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	showLoading();
	$.ajax({
		  url: '/ifit/getMainProduct',
		  dataType: "json",
		  success: function(obj){
			  var labelList = obj.mainLabelList;
			  for(var i in labelList){
				  var htmlCode = '<div id="'+labelList[i].mainType +'" class="mainpage_mainBox">';
				  htmlCode+= '<p class="mainpage_boxTitle">'+labelList[i].labelName+'</p>';
				  htmlCode+= '<div class="mainpage_boxContents">';
				  htmlCode+= '</div></div>';
				  $("#mainLabels").append(htmlCode);
			  }
			  
			  var productList = obj.allProductList;
			  for(var i in productList){
				  var htmlCode = '<div class="mainpage_productDiv" onclick="getMoreInfo('+productList[i].productId+')">';
				  htmlCode+= '<div class="mainpage_imgDiv">';
				  if(productList[i].catRef!=null)
				  	htmlCode+= '<div class="fitLogo"></div>';
				  htmlCode+='<img src="http://'+productList[i].productMainURL+'">';
				  htmlCode+='</div><div class="mainpage_infoDiv">';
				  htmlCode+='<p class="right">'+productList[i].productName+'</p>';
				  htmlCode+='<p class="price clear right">'+addCurrencyMark(productList[i].productPrice)+'<p>';
				  htmlCode+= '</div></div>';
				  var locationId = '#'+productList[i].mainType;
				  $("#main_home").find(locationId).find(".mainpage_boxContents").append(htmlCode);
			  }
			  var adminTagList = obj.adminTagList;
			  for(var i in adminTagList){
				  var htmlCode = '<div class="tag" onclick="searchTag_Handler(\''+adminTagList[i]+'\');">#'+adminTagList[i]+'</div>';
				  $("#adminTags").append(htmlCode);
			  }
			  var hotTagList = obj.hotTagList;
			  for(var i in hotTagList){
				  var htmlCode = '<div class="tag" onclick="searchTag_Handler(\''+hotTagList[i]+'\');">#'+hotTagList[i]+'</div>';
				  $("#hotTags").append(htmlCode);
			  }
			  hideLoading();
		  }
		});
});
</script>

</head>
<body>
	<div data-role="header" id="menuBar" data-position="fixed" data-tap-toggle="false">
		<div id="loadingDiv">
			<img src="img/ajax-loader.gif">
		</div>
		<img id="closet" src=" img/header/closet.png" onclick="headBar_handler('closet')"> 
		<span id="searchDiv"> 
			<img src="img/header/search.png"> 
			<input id="searchBar" data-role="none" onkeydown='detailOption(null)'>
			<span id="searchBarClickView" onclick='detailOption(1)'>
			GO</span>
		</span>
		<img id="likeItem" src=" img/header/likeItem.png" onclick="headBar_handler('zzim')" class="headerIcon"> 
		<img id="shoppingCart" src=" img/header/shoppingCart.png" onclick="headBar_handler('cart')" class="headerIcon">
	</div>
	<div data-role="header" id="tagDiv" style="display: none; position:fixed; top:30px; border: 0px; width: 100%; height: 100%; z-index: 20; " >
		<div id="tagList">
			<div id="adminTags" class="font-bold font-size-18">
			</div>
			<div id="hotTags" class="font-light font-size-18">
			</div>
		</div>
		<div id = "blackDiv" style="background-color: black; height:100%; opacity:0.8;" onclick="stopSearchBar()">
		</div>
	
	</div>
	
	<div id="adWrap">
		<div class="photoArea">	
			<div id="jssor_1" class="slider_image" style="margin: 0px;">
		        <div id="jssor_1_container" class="slider_image" data-u="slides">
		        </div>
		        <!-- Bullet Navigator -->
		        <div data-u="navigator" class="jssorb05" data-autocenter="1">
		            <!-- bullet navigator item prototype -->
		            <div data-u="prototype"></div>
		        </div>
		        <!-- Arrow Navigator -->
		        <!-- 일단보류
		        <span data-u="arrowleft" class="jssora22l" data-autocenter="2"></span>
		        <span data-u="arrowright" class="jssora22r" data-autocenter="2"></span>
		         -->
		    </div>
		</div>
	</div>
	
	<div data-role="page" id="main_home" 	class="eachPage haveADContent">
		
		<div id="mainpage_middleBar">
			<div id="bestMiddleBar" class="middleEach">
				<p class="middleImg">
					<img src="img/mainHome/best.png">
				</p>
				<p class="middleText">BEST</p>
			</div>
			<div id="eventMiddleBar" class="middleEach">
				<p class="middleImg">
					<img src="img/mainHome/event.png">
				</p>
				<p class="middleText">EVENT</p>
			</div>
			<div id="ffitingMiddleBar" class="middleEach">
				<p class="middleImg">
					<img src="img/mainHome/fitting.png">
				</p>
				<p class="middleText">FITTING</p>
			</div>
			<div id="weddingMiddleBar" class="middleEach" style="border-right: 0px;">
				<p class="middleImg">
					<img src="img/mainHome/wedding.png">
				</p>
				<p class="middleText">WEDDING</p>
			</div>
		</div>
		<div id="mainLabels" class="clear">
		</div>
		<div id="eventBanners">
			<p>Event</p>
		</div>
		<div style="width: 100%; text-align: center; padding: 42px 0px;" onclick="window.scrollTo(0,0);"><img width="15px;" src="img/anchor.png"></div>
		<div id="adminInfoBox" class="f11">
			두비파트너스 (주) | 대표이사 : 백태섭 | 소재지 : 서울특별시 강남구 영동대로  721-0 1410호 (주)두비파트너스 | 
			쇼핑몰센터 : 02-543-8820 | 팩스 : 02-0000-0000 | 전자우편 : seants100@dobepartners.com | 
			사업자등록번호 : 553-87-00053 | 통신판매업신고 : 제 2016-서울강남-01543 호 |  
			개인정보관리책임자 : 김종휘 (jaykim@dobepartners.com) | 
		</div>
	</div>
	<div data-role="page" id="categoryPage" class="eachPage haveADContent">
			<div class="categoryMiddleBar">
				<div class="middleEach" id="1">
					<p class="middleImg">
						<img src="img/category/top.png">
					</p>
					<p class="middleText">TOP</p>
				</div>
				<div class="middleEach" id="2">
					<p class="middleImg">
						<img src="img/category/pants.png">
					</p>
					<p class="middleText">PANTS</p>
				</div>
				<div class="middleEach" id="3">
					<p class="middleImg">
						<img src="img/category/skirt.png">
					</p>
					<p class="middleText">SKIRT</p>
				</div>
				<div class="middleEach" style="border-right: 0px;" id="4">
					<p class="middleImg">
						<img src="img/category/onepiece.png">
					</p>
					<p class="middleText">ONE PIECE</p>
				</div>
			</div>
			<div class="categoryMiddleBar">
				<div class="middleEach" id="5">
					<p class="middleImg">
						<img src="img/category/outer.png">
					</p>
					<p class="middleText">OUTER</p>
				</div>
				<div class="middleEach" id="6">
					<p class="middleImg">
						<img src="img/category/dress.png">
					</p>
					<p class="middleText">DRESS</p>
				</div>
				<div class="middleEach" id="7">
					<p class="middleImg">
						<img src="img/category/accessorie.png">
					</p>
					<p class="middleText">ACCESSORIE</p>
				</div>
				<div class="middleEach" style="border-right: 0px;" id="8">
					<p class="middleImg">
						<img src="img/category/shoes.png">
					</p>
					<p class="middleText">SHOES</p>
				</div>
			</div>
		<div id="categoryContents">
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Top</p>
				<div id="1" class="mainpage_boxContents">
				
				</div>
			</div>
			
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Pants</p>
				<div id="2" class="mainpage_boxContents">
				
				</div>
			</div>
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Skirt</p>
				<div id="3" class="mainpage_boxContents">
				
				</div>
			</div>
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">One piece</p>
				<div id="4" class="mainpage_boxContents">
				</div>
			</div>
			
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Outer</p>
				<div id="5" class="mainpage_boxContents">
				</div>
			</div>
			
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Dress</p>
				<div id="6" class="mainpage_boxContents">
				</div>
			</div>
			
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Accessories</p>
				<div id="7" class="mainpage_boxContents">
				
					
				</div>
			</div>
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle">Shoes</p>
				<div id="8" class="mainpage_boxContents">
				
				</div>
			</div>
		</div>
		<div class="topBtn" onclick="window.scrollTo(0,0);"><img width="15px;" src="img/anchor.png"></div>
	</div>
	<div data-role="page" id="threeDPage" class="eachPage">
			<div class="product">
			<div class="imgDiv">
				<div class="fitLogo"></div>
				<img src="img/mainHome/item_2.png">
			</div>
			<div class="productInfo font-size-10">
				<div class="moreInfo">
					<img src="img/header/likeItem.png" class="left">
					<p class="left">231</p>
					<p class="right">페이크 레더 점퍼</p>
				</div>
				<p class="price clear right">&#8361 36,000<p>
			</div>
		</div>
		
		<div class="product">
			<div class="imgDiv">
				<div class="fitLogo"></div>
				<img src="img/mainHome/item_2.png">
			</div>
			<div class="productInfo font-size-10">
				<div class="moreInfo">
					<img src="img/header/likeItem.png" class="left">
					<p class="left">231</p>
					<p class="right">페이크 레더 점퍼</p>
				</div>
				<p class="price clear right">&#8361 36,000<p>
			</div>
		</div>
		
		<div class="product">
			<div class="imgDiv">
				<div class="fitLogo"></div>
				<img src="img/mainHome/item_2.png">
			</div>
			<div class="productInfo font-size-10">
				<div class="moreInfo">
					<img src="img/header/likeItem.png" class="left">
					<p class="left">231</p>
					<p class="right">페이크 레더 점퍼</p>
				</div>
				<p class="price clear right">&#8361 36,000<p>
			</div>
		</div>
		
		<div class="product">
			<div class="imgDiv">
				<div class="fitLogo"></div>
				<img src="img/mainHome/item_2.png">
			</div>
			<div class="productInfo font-size-10">
				<div class="moreInfo">
					<img src="img/header/likeItem.png" class="left">
					<p class="left">231</p>
					<p class="right">페이크 레더 점퍼</p>
				</div>
				<p class="price clear right">&#8361 36,000<p>
			</div>
		</div>
		
				<div class="product">
			<div class="imgDiv">
				<div class="fitLogo"></div>
				<img src="img/mainHome/item_2.png">
			</div>
			<div class="productInfo font-size-10">
				<div class="moreInfo">
					<img src="img/header/likeItem.png" class="left">
					<p class="left">231</p>
					<p class="right">페이크 레더 점퍼</p>
				</div>
				<p class="price clear right">&#8361 36,000<p>
			</div>
		</div>
		
				<div class="product">
			<div class="imgDiv">
				<div class="fitLogo"></div>
				<img src="img/mainHome/item_2.png">
			</div>
			<div class="productInfo font-size-10">
				<div class="moreInfo">
					<img src="img/header/likeItem.png" class="left">
					<p class="left">231</p>
					<p class="right">페이크 레더 점퍼</p>
				</div>
				<p class="price clear right">&#8361 36,000<p>
			</div>
		</div>
		<div class="topBtn" onclick="window.scrollTo(0,0);"><img width="15px;" src="img/anchor.png"></div>
		
		
	</div>
	<div data-role="page" id="hotDealPage" 	class="eachPage">
		<div id="promotions">
			<div id="promotions">
			</div>
		</div>
		<div id="subPromotion" class="ifitFont" style="z-index:1001; position: fixed; width: 100%;height: 210px; background-color: black; right: 0px; bottom: 43px; display: none;">
			<div id="optionHeadbar" style="background-color: black; color: white; height: 40px; padding: 0px 10px;">
				<span id="promotionName" style="color:#9B9B9B" class="left">롯데백화점 특가전</span>
				<span style="color:#9B9B9B" class="right" onclick="closeSubPromotion()">닫기</span>
			</div>
			<div>
				<div class="mainpage_mainBox">
					<div id="subPromotionBox" class="mainpage_boxContents">
					</div>
				</div>
			</div>
		</div>
		<div class="topBtn" onclick="window.scrollTo(0,0);"><img width="15px;" src="img/anchor.png"></div>
	</div>	
	<div data-role="page" id="myPage" class="eachPage render" data-render="padding-left,padding-right,margin-top" data-redner-ratio="height">
		<c:choose>
		<c:when test="${not empty sessionScope.user}">
			<div id="user_info_box" class="render" data-render="padding-left,padding-right">
				<div id="userImage" class="render" data-render="margin-bottom,width,height">
				<c:choose>
					<c:when test="${user.profileImage ne null  }">
						<img style="margin-top: 0px;" src="${user.profileImage}" />
					</c:when>
					<c:otherwise>
						<img style="margin-top: -20px; height:120%;" src="img/mypage/userSample.png" />
					</c:otherwise>
				</c:choose>
				</div>
				<p class="font-size-11 t-center render" id="loginLabel2" data-render="height,font-size,margin-bottom">
				<c:choose>
					<c:when test="${user.nickname ne null }">${user.nickname}</c:when>
					<c:otherwise>${user.userId}</c:otherwise>
				</c:choose>
				님 | <span id="updateUserInfo">회원정보수정</span> | <span id="logoutBtn">로그아웃</span></p>
			</div>
			
		</c:when>
		<c:otherwise>
			<div id="login_box" class="render" data-render="padding-left,padding-right">
				<form>
				<input type="text" id="input_id" class="font-size-11 render" data-render="height,font-size,margin-bottom" placeholder="ID"/>
				<input type="password" id="input_pw" class="font-size-11 render" data-render="height,font-size,margin-bottom" placeholder="PASSWORD"/>
				<p class="font-size-11 t-center render" id="loginLabel1" data-render="height,font-size,margin-bottom"><span id="idSearch">아이디찾기</span> | <span id="pwSearch">비밀번호 찾기</span> | <span id="joinBtn">회원가입</span></p>
				
				<div id="icon_box" class="t-center render" data-render="height,margin-bottom">
					<img class="mr30" src="img/mypage/kakao_icon.png" onclick="loginWithKakao()">
					<img class="mr30" src="img/mypage/weibo_icon.png">
					<img src="img/mypage/facebook_icon.png" onclick="checkLoginState();">
				</div>
				<div id="loginBtn" class="t-center font-size-13 render" data-render="height,margin-bottom,font-size,line-height">
					로그인
				</div>
				</form>
			</div>
		</c:otherwise>
		</c:choose>
		
		<div id="list">
			<div id="requestOrder" class="clear render" data-render="height,padding-left,padding-right">
				<div class="render" data-render="line-height">
					<p class="font-medium font-size-13 render" data-render="font-size">주문 / 배송</p>
				</div>
				<div class="t-right render" data-render="line-height">
					<p class="messageBox t-center font-size-13 render" data-render="width,height,line-height,font-size">1</p>
					<img src="img/mypage/arrow.png" class="listIcon render ml5" data-render="height,margin-left">
				</div>
			</div>
			<div id="requestManyQnA" class="clear render" data-render="height,padding-left,padding-right">
				<div class="render" data-render="line-height">
					<p class="font-medium font-size-13 render" data-render="font-size">자주하는질문</p>
				</div>
				<div class="t-right render" data-render="line-height">
					<img src="img/mypage/arrow.png" class="listIcon render ml5" data-render="height,margin-left">
				</div>
			</div>
			<div id="requestOneByOne" class="clear render" data-render="height,padding-left,padding-right">
				<div class="render" data-render="line-height">
					<p class="font-medium font-size-13 render" data-render="font-size">1:1 문의</p>
				</div>
				<div class="t-right render" data-render="line-height">
					<img src="img/mypage/arrow.png" class="listIcon render ml5" data-render="height,margin-left">
				</div>
			</div>
			<div id="requestUsingApp" class="clear render" data-render="height,padding-left,padding-right">
				<div class="render" data-render="line-height">
					<p class="font-medium font-size-13 render" data-render="font-size">이용안내</p>
				</div>
				<div class="t-right render" data-render="line-height">
					<img src="img/mypage/arrow.png" class="listIcon render ml5" data-render="height,margin-left">
				</div>
			</div>
		</div>
		<div data-role="popup" id="idSearchPopup" data-history="false" data-overlay-theme="d" class="font-size-13 render" data-render="font-size">
			<div data-role="content">
				<div id="popupHead" class="font-size-16 render mb10" data-render="margin-bottom,font-size">
					핸드폰 번호로 찾기(아이디 찾기)
				</div>
				<div id="popupBody" class="mb10 render" data-render="margin-bottom">
					<div id="searchWrap" class="render" data-render="height,width,line-height,border-bottom-width,padding-left,padding-right">
						<input id="idSearchTitle" class="searchTitle t-center render" data-render="width,height,padding-left,padding-right,font-size" data-role="none" type="text" placeholder="핸드폰 번호를 입력해 주세요.">
					</div>
				</div>
				<div id="pupupFoot" class="render" data-render="width,height" >
					<div id="idSearchConfirm" class="writeBtn dib render" data-render="height,line-height,width">확인</div>
				</div>				
			</div>
		</div>
		<div data-role="popup" id="pwSearchPopup" data-history="false" data-overlay-theme="d" class="font-size-13 render" data-render="font-size">
			<div data-role="content">
				<div id="popupHead" class="font-size-16 render mb10" data-render="margin-bottom,font-size">
					비밀번호 찾기
				</div>
				<div id="popupBody" class="mb10 render" data-render="margin-bottom">
					<div id="searchWrap" class="render" data-render="height,width,line-height,border-bottom-width,padding-left,padding-right">
						<input id="findId_id" class="searchTitle render" data-render="width,height,padding-left,padding-right,font-size" data-role="none" type="text" placeholder="아이디를 입력해주세요">
						<input id="findId_email" class="searchTitle render" data-render="width,height,padding-left,padding-right,font-size" data-role="none" type="email" placeholder="가입하셨던 이메일주소를 입력해주세요.">
					</div>
				</div>
				<div id="pupupFoot" class="render" data-render="width,height" >
					<div id="pwSearchConfirm" class="writeBtn dib render" data-render="height,line-height,width" onclick="findPwRequest()">확인</div>
				</div>				
			</div>
		</div>
		<div data-role="popup" id="updateUserInfoPopup" data-history="false" data-overlay-theme="d" class="font-size-13 render" data-render="font-size">
			<div data-role="content">
				<div id="popupHead" class="font-size-16 render mb10" data-render="margin-bottom,font-size">
					회원정보 수정
				</div>
				<div id="popupBody" class="mb10 render" data-render="margin-bottom">
					<div id="searchWrap" class="render" data-render="height,width,line-height,border-bottom-width,padding-left,padding-right">
						<input id="updateUserInfoTitle" class="searchTitle t-center render" data-render="width,height,padding-left,padding-right,font-size" data-role="none" type="text" placeholder="비밀번호를 입력 해 주세요.">
					</div>
				</div>
				<div id="pupupFoot" class="render" data-render="width,height" >
					<div id="updateUserInfoConfirm" class="writeBtn dib render" data-render="height,line-height,width" onclick="updateRequest();">확인</div>
				</div>				
			</div>
		</div>
		<div id="useInfo" style="display: none;">
			<div id="cancelDiv" class="right" style="width: 100%; padding: 5%;  position: absolute ; z-index: 1;">
				<img id="useInfoCancelBtn" src="img/cancel_x_btn.png" class="right" style="width: 30px;" onclick="closeUseInfo()">
			</div>
			<div id="arrowDiv" class="right" style="width: 100%; padding: 5%;  position: absolute; top: 45%; z-index: 1;">
				<img class= "left" src="img/mypage/back.png" onclick="useInfoLeft()">
				<img class= "right" src="img/mypage/arrow.png" onclick="useInfoRight()">
			</div>
			<div id="useInfoImgDiv" style="position: relative;">
				<img id="use1" data-seq="1" src="img/use_info/use_info1.png" style="display: block;">
				<img id="use2" data-seq="2" src="img/use_info/use_info2.png">
				<img id="use3" data-seq="3" src="img/use_info/use_info3.png">
				<img id="use4" data-seq="4" src="img/use_info/use_info4.png">
				<img id="use5" data-seq="5" src="img/use_info/use_info5.png">
			</div>
		</div>
	</div>
	<div data-role="page" id="productList" class="eachPage">
		<div id="optionDiv">
			<span id="selectedCategory" style="line-height: 30px;" class="f14"></span>/
			<span id="selectedInputValue" style="line-height: 30px;" class="f14"></span> 
			<span id="searchOptionBtn" onclick='$("#detailSearch").show()' class="right">상세검색</span>
		</div>
		<div id="detailSearch" class="ifitFont" style="z-index:1001; position: fixed; width: 100%;height: 100%; background-color: white; right: 0px; top: 0px; display: none;">
			<div id="optionHeadbar" style="background-color: black; color: white; height: 40px; padding: 0px 10px;">
				<span style="color:#9B9B9B" class="left" onclick="optionCancel();">취소</span>
				<span class="f16">상세 검색</span>
				<span style="color:#9B9B9B" class="right" onclick="getOption()">적용</span>
			</div>
			<div id="sortOption">
				<div class="eachSelectOption">
					<p>인기순</p>
					<input type="radio" name="sort" value="인기" checked="checked">
				</div>
				<div class="eachSelectOption">
					<p>최신순</p>
					<input type="radio" name="sort" value="최신">
				</div>
				<div class="eachSelectOption">
					<p>낮은가격순</p>
					<input type="radio" name="sort" value="낮은가격">
				</div>
			</div>
			<p style="border-bottom: 1px solid; padding: 10px;" class="f16 bold">카테고리</p>
			<div id="categoryOption">
				<p id="1" class="optionCategory">TOP</p>
				<p id="2" class="optionCategory">PANTS</p>
				<p id="3" class="optionCategory">SKIRT</p>
				<p id="4" class="optionCategory">ONEPIECE</p>
				<p id="5" class="optionCategory">OUTER</p>
				<p id="6" class="optionCategory">DRESS</p>
				<p id="7" class="optionCategory">ACCESSORIE</p>
				<p id="8" class="optionCategory">SHOES</p>
				<input id="selectedCategoryOption" type="text" style="display: none;">
			</div>
		</div>
		<div id="searchProductList">
		</div>
		<div class="topBtn" onclick="window.scrollTo(0,0);"><img width="15px;" src="img/anchor.png"></div>
		
	</div>
	<div data-role="page" id="zzimPage" class="eachPage render" data-render="padding-left,padding-right">
		<div class="font-light font-size-16 ">
			찜 리스트
		</div>
		<div id="zzimItemListView">
			
		</div>
		<hr class="cart_item_separate clear render" data-render="width" />
		<div class="t-center">
			<img class="bottomAnchor render" src="img/anchor.png" data-render="width,margin-top,margin-bottom" onclick="window.scrollTo(0,0);" />
		</div>
		
	</div>

	<div data-role="page" id="cartPage" class="eachPage render" data-render="padding-left,padding-right">
		<div class="font-light font-size-16 ">
			장바구니 리스트
		</div>			
		<div class="basicItem">
			<hr class="cart_item_separate clear render" data-render="width,border-top-width,margin-top" />
			<div id="cartListView">
			</div>
		</div>
		
		<div id="priceInfo" class="cart_item2 render" data-render="width,margin-top,margin-bottom">
			<div class="itemPhotoArea center render" data-render="width"></div>
			<div class="itemOptionArea render" data-render="width,line-height,padding-top,padding-bottom,padding-left">
				<div id="delivery_price" class="item_price_list font-size-13 mb10 render" data-render="width,height,margin-bottom">
					<p class="font-size-13 render dib" data-render="font-size">배송료</p>
					<p id="deleveryFee" class="font-size-13 render dib fr" data-render="font-size">￦0</p>
				</div>
				<hr class="cart_item_separate last-separate clear render" data-render="width,margin-top,margin-bottom,border-top-width" />
				<div class="mt10 render" data-render="width,height,margin-top">
					<p class="font-size-13 render dib" data-render="font-size">총계</p>
					<p id="item_price_sum" class="font-medium font-size-18 render dib fr" data-render="font-size">￦0</p>
				</div>
			</div>
			
		</div>
		 
		<div class="purchaseBtn font-medium font-size-13 render" data-render="margin-bottom,font-size">
			<div class="dib fr mb20 render" data-render="height,line-height,margin-bottom" onclick="cartToBuyBtn()">구매하기</div>
		</div>
		<div id="deliveryPopUp" style="display: none;">
	 			<div id="backheader">
		 			<span id="backBtn2" onclick="closePopUp()"></span>
					<span id="pageName" class="font-size-16">구매정보입력</span>
					<span class="headerMargin" ></span>
				</div>
				<div id="diliveryBody">
					<div class="btnDiv" onclick="getCurDelivery()">최근 배송지 가져오기</div>
					<div id="recentAddress">
					</div>
					<input type="text" id="address1" placeholder="ex) 전남 여수시 미평동">
					<input type="text" id="address2" placeholder="상세주소 - ex) 54번지 202호">
					<input type="text" id="userName" placeholder="이름(수령인)">
				</div>
				<div id="diliveryFooter">
					<div class="clear line" style="margin-bottom: 5px;"></div>
					<p>
						<span class="left">총 상품 금액</span>
						<span id="popUpPrice" class="right">￦0</span>
					</p>
					<p class="clear">
						<span class="left">총 배송비</span>
						<span id="deliveryFee" class="right">￦2,500</span>
					</p>
					<div class="clear line" style="margin-bottom: 5px; border-bottom: 2px solid;" ></div>
					<p class="clear bold" style="margin: 10px 0px;">
						<span class="left">총 결제금액</span>
						<span id="popUpTotalPrice" class="right">￦0</span>
					</p>
					<div class="clear line" style="margin-bottom: 5px; border-bottom: 2px solid;" ></div>
					<form accept-charset="euc-kr" id="pgForm" action="https://mobile.inicis.com/smart/wcard/" method="post" >
						<input type="hidden" name="P_MID" value="INIpayTest">
						<input id="pAmnt" type="hidden" name="P_AMT" value="">
						<input id="pNoti" type="hidden" name="P_NOTI" value="">
						<input id="pUname" type="hidden" name="P_UNAME" value="noName">
						<input id="pGoods" type="hidden" name="P_GOODS" value="">
						<input id="pNextUrl" type="hidden" name="P_NEXT_URL" value="http://<%=request.getServerName().toString()+":"+request.getServerPort() %>/ifit/pageView/requestPayPg.ap">
						<input type="hidden" name="P_HPP_METHOD" value="2">
						<input type="hidden" name="P_RESERVED" value="twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&below1000=Y" />
					</form>
					<select id="actionURL" data-role="none">
						<option value="none" selected="selected">결제수단선택</option>
						<option value="https://mobile.inicis.com/smart/wcard/">신용카드</option>
						<option value="https://mobile.inicis.com/smart/mobile/">휴대폰</option>
						<option value="https://mobile.inicis.com/smart/culture/">문화상품권</option>
						<option value="https://mobile.inicis.com/smart/hpmn/">해피머니상품권</option>
						<option value="https://mobile.inicis.com/smart/dgcl/">스마트문화상품권</option>
					</select>
						<input type="hidden" id="paySeq">
						<div class="btnDiv f15" onclick="pgRequest()">결제하기</div>
					</div>
	 		</div>
	</div>
	
	<div data-role="page" id="codiPage" class="eachPage">
		<div id="preView" style="position: fixed; z-index: 1;">
			<div id="leftDoor" class="door" style="float: left;">
				<p class="doorHand" style="right: 0px;"></p>
			</div>
			<div id="rightDoor" class="door" style="float: right;">
				<p class="doorHand"></p>
			</div>
		</div>

		<div id="tabDiv">
			<div>찜한상품</div>
			<div>장바구니</div>
		</div>
		<p style="width: 100%; line-height: 400px; text-align: center;"> 준비중입니다..</p>
	</div>
	
	
	<div data-role="footer" id="footer" data-position="fixed"
		data-tap-toggle="false">
		<div id="footBalckDiv" style="position:fixed;width:100%;height:100%; background-color: black; opacity:0.8;border:none; display: none;" onclick="stopSearchBar()"></div>
		
		<div class="eachFoot">
			<img id="homeBtn" class="footerIcon" src=" img/footer/homeClick.png"
			onclick="homeBtn_Handler()"> 
		</div>
		<div class="eachFoot">
			<img id="categoryBtn"
			class="footerIcon" src=" img/footer/category.png"
			onclick="categoryBtn_Handler()">
		</div>
		<div class="eachFoot">
			<img id="threeDBtn"
			class="footerIcon" src=" img/footer/threeD.png"
			onclick="threeDBtn_Handler()">		
		</div>
		<div class="eachFoot">
			<img id="hotDealBtn"
			class="footerIcon" src=" img/footer/hotDeal.png"
			onclick="hotDealBtn_Handler()">
		</div>
		<div class="eachFoot">
			<img id="myPageBtn"
			class="footerIcon" src=" img/footer/myPage.png"
			onclick="myPageBtn_Handler()">
		</div>
	</div>
	<script type="text/javascript">
	 	Kakao.init('ec0df6073da378bc5886481cc0aa3c91');
	    function loginWithKakao() {
	      // 로그인 창을 띄웁니다.
	      	Kakao.Auth.login({
	        success: function(authObj) {
	          Kakao.API.request({
	              url: '/v1/user/me',
	              success: function(res) {
	                var nickname =  res.properties.nickname;
	                var userId = res.id;
	                var profileImage = res.properties.profile_image;
	                $.ajax({
	          		  url: '/ifit/Users/snsLogin',
	          		  type:"POST",
	          		  dataType: "json",
	          		  data: {userId:userId, nickname:nickname,profileImage:profileImage,route:'k'},
	          		  success: function(obj){
	          			  window.location.reload(true);
	          		  }
	                });
	              },
	              fail: function(error) {
	                alert(JSON.stringify(error));
	              }
	            });
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    };
	</script>
<script type="text/javascript">
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      FB.login();
      console.log('not_authorized');
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
    	console.log('else!!');
      	FB.login();
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1861818357378765',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.6' // use version 2.6
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.


  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
    	var userId = response.id;
    	var nickname = response.name;
    	var profileImage = 'https://graph.facebook.com/'+userId+'/picture?type=large';
    	$.ajax({
    		  url: '/ifit/Users/snsLogin',
    		  type:"POST",
    		  dataType: "json",
    		  data: {userId:userId, nickname:nickname,profileImage:profileImage,route:'f'},
    		  success: function(obj){
    			  window.location.reload(true);
    		  }
          });
    });
  }
</script>
</body>
</html>
