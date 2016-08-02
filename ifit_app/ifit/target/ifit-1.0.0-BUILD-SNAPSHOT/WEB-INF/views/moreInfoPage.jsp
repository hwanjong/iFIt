<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ecu-kr">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css" />
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="js/jssor.slider.mini.js"></script>
<script type="text/javascript" src="js/imageSliderMore.js"></script>

<!--  Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/moreInfoPage.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">


<script src="js/bootstrap.min.js"></script>
<script src="js/moreInfoPage.js"></script>
<script src="js/common/common.js"></script>
<script src="js/common/backHeader.js"></script>
<script src="js/deviceRender.js"></script>
</head>
<script type="text/javascript">
function getCurDelivery(){
	$("#diliveryFooter").hide();
	$.ajax({
		  url: '/ifit/Users/curDeliveryAddress',
		  type:"GET",
		  dataType: "json",
		  success: function(obj){
			  if(obj==''){
				  alert("최근배송지가 없습니다.");
				  $("#diliveryFooter").show();
				  return;
			  }
			  var htmlCode='';
			  for(var i in obj){
				  htmlCode += '<p data-userName="'+obj[i].payUserName+'" data-address="'+obj[i].deliveryAddress+'" data-addressDetail="'+obj[i].deliveryAddressDetail+'" onclick="choiceAddress(this)"><img src="img/itemcheck_off.png"><span>'+obj[i].deliveryAddress+' '+obj[i].deliveryAddressDetail+'</span></p>';
			  }
			  $("#recentAddress").html(htmlCode);
		  }
	});
}
function choiceAddress(item){
	$("#diliveryFooter").show();
	var userName = $(item).attr('data-userName');
	var address1 = $(item).attr('data-address');
	var address2 = $(item).attr('data-addressDetail');
	
	$("#userName").val(userName);
	$("#address1").val(address1);
	$("#address2").val(address2);
	$("#recentAddress").html('');
	
}
function closePopUp(){
	$("#deliveryPopUp").hide();
}
function cartClickFunc(modeType){
	//서버에서 Session 검사해야함.
	if ('${user}' == '') {
		alert("로그인후이용가능");
		return;
	}
	
	//밸리데이션 검사후 Ajax요청으로 User 검증 및 주문등록
	checkColor = $("input[name=color]:checked").val();
	checkSize = $("#sizeSelector").val();
	checkCount = $("#countInput").val();
	if(checkColor==null || checkSize==null || checkCount ==''){
		alert("주문정보를 입력해주세요");
		return;
	}
	if(modeType=="purchaseRequest"){
		var onePrice = removeCurrencyMark($("#productPrice").html());
		var popUpPrice = onePrice*checkCount;
		$("#popUpPrice").html(addCurrencyMark(popUpPrice));
		$("#popUpTotalPrice").html(addCurrencyMark(popUpPrice+2500));
		$("#pAmnt").val(popUpPrice+2500);
		$("#deliveryPopUp").show();
	}else{
		purchaseRequest(checkColor,checkSize,checkCount,'cartRequest');
	}
	
}
function pgRequest(){
	payUserName =$("#userName").val();
	deliveryAddress=$("#address1").val();
	deliveryAddressDetail=$("#address2").val();
	var actionUrl = $("#actionURL option:selected").val();
	if(actionUrl=='none'){
		alert("결제수단을 선택하세요");
		return;
	}
	$("#pgForm").attr("action",actionUrl);
	$("#pUname").val(payUserName);
	$("#pgForm").submit();
	/*
	purchaseRequest(checkColor,checkSize,checkCount,'purchaseRequest',payUserName,deliveryAddress,deliveryAddressDetail);
	if(confirm("주문이 성공적으로 접수되었습니다. 결제 샘플 페이지로 이동하시겠습니까?")==true){
		location = 'https://drmobile.inicis.com/smart/wcard/gateway.php';
	}
	*/
}
$(document).ready(function() {
	
	var query_string = window.location.search.substring(1);
	var queryArr = query_string.split("=");
	var pId = queryArr[1];
	$("#productId").val(pId);
	
	var checkColor;
	var checkSize;
	var checkCount;
	
	var payUserName;
	var deliveryAddress;
	var deliveryAddressDetail;
	
	$.ajax({
		  url: '/ifit/getProduct',
		  type:"POST",
		  dataType: "json",
		  data: {productId:pId},
		  success: function(obj){
			  $(".likeItem").attr("id",pId);
			  if(obj.isLikeItem != null){
				  $("#"+pId).attr("src","img/moreInfoPage/heart_like.png");
			  }
			  $("#adminSeq").val(obj.adminSeq);
			  $("#pageName").html(obj.productName);
			  $("#pGoods").val(obj.productName);
			  $("#likeCnt").html(obj.likeCount);
			  $("#productName").html(obj.productName);
			  $("#productPrice").html(addCurrencyMark(obj.productPrice));
			  
			  //Review처리
			  var reviewList = obj.reviewList;
			  for(var i in reviewList){
				  var htmlCode = '<div class="eachMoreInfoReplyWrap render" data-render="padding-left,padding-right,height,margin-bottom,border-top-width,border-bottom-width">';
				  htmlCode += '<div class="moreInfoReplyHeart render" data-render="top">';
				  var score = reviewList[i].score;
				  for(var j =1; j<=score; j++){
					  htmlCode += '<img src="img/moreInfoPage/heart_on.png" class="fl render" data-render="height">';
				  }
				  for(var j= 5-score;j>0;j--){
					  htmlCode += '<img src="img/moreInfoPage/heart_off.png" class="fl render" data-render="height">';
				  }
				  htmlCode += '</div><div class="moreInfoReplyWriter render" data-render="top,height,line-height">';
				  htmlCode += '<p class="font-medium font-size-13 render fl" data-render="font-size">'+reviewList[i].userId+'</p>';
				  htmlCode += '<p class="font-size-11 render fl" data-render="font-size">'+reviewList[i].regDate+'</p></div>';
				  htmlCode += '<div class="moreInfoReplyContent render" data-render="top,height,line-height,margin-right">';
				  htmlCode += '<p class="font-size-11 render" data-render="font-size">'+reviewList[i].comment+'</p></div></div>';
				  $("#moreInfoReply").append(htmlCode);
			  }
			  //Option 처리
			  var sizeList = obj.sizeList;
			  for(var i in sizeList){
				  var htmlCode = '<option value="'+sizeList[i].size_id+'">'+sizeList[i].size_val+'</option>';
				  $("#sizeSelector").append(htmlCode);
			  }
			  var colorList = obj.colorList;
			  for(var i in colorList){
				  var htmlCode = '<div class=" ui-radio"><input type="radio" name="color" value="'+colorList[i].colorId+'"></div>';
				  htmlCode += '<span class="colorValue">'+colorList[i].colorName+'</span><div class="colorCircle render" data-render="width,height" data-render-ratio="width,height" style="background-color: '+colorList[i].colorValue+';"></div>';
				  $("#colorSelector").append(htmlCode);
			  }
		  }
	});
	
});
</script>
<body>
	<div data-role="page" id="moreInfoPage" class="eachPage render" data-render="padding-left,padding-right,padding-top">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" id="backheader" class="render" data-render="height" data-render-ratio="height">
			<span id="backBtn" data-rel="back" class="render" data-render="width,height,left,background-size" data-render-ratio="height"></span>
			<span id="pageName" class="font-size-16 render" data-render="line-height,font-size" data-render-ratio="height">페이크 레더 점퍼</span>
			<span class="headerMargin render" data-render="height,border-top-width" data-render-ratio="height"></span>
		</div>
		<div id="purchaseContent" class="render" data-render="margin-top,margin-bottom">
			<div id="sumurryInfo" class="moreInfoEachDivWrap">
				<div class="photoAreaMore">
					<div class="iconArea render" data-render="padding-top,padding-left,padding-right">
						<img src="img/moreInfoPage/hanger.png" class="render" data-render="width">
						<img src="img/moreInfoPage/3d_fit.png" class="fr render" data-render="width">
					</div>					
					<!-- 이미지 슬라이더 시작 -->
					<div id="jssor_1" class="slider_image">
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
				<div id="shareWrap" class="render" data-render="height,margin-top,margin-bottom,line-height">
					<span id="othersLikeNo" class="render" data-render="height,line-height,font-size">
						<img src="img/moreInfoPage/heart.png" class="fl render likeItem" data-render="height">
						<p id="likeCnt" class="fl render" data-render="margin-left">231</p>
					</span>
					<span class="font-size-10 render" id="purchaseName" data-render="height,line-height,font-size">
						<p id="productName">페이크 레더 점퍼</p>
					</span>
					<div class="clear"></div>
					<span class="font-size-10 render" id="purchasePrice" data-render="height,line-height,font-size">
						<p id="productPrice">￦36,000</p> 
					</span>						
				</div>
				<div class="clear"></div>
			</div>
			
			<div id="sampleMoreImgs">
			</div>
		
			<div id="moreInfoReply" class="render" data-render="margin-bottom">
				<div id="imageArea" class ="centerImage render" data-render="height">
					<img src="img/moreInfoPage/reply.png" class="render" data-render="height" />
				</div>
			</div>
			
			<div class="mainpage_mainBox">
				<p class="mainpage_boxTitle font-light font-size-16 render" data-render="font-size,height,margin-top,margin-bottom,line-height">MD 추천상품</p>
				<div class="mainpage_boxContents">
				
					<div class="mainpage_productDiv">
						<div class="mainpage_imgDiv">
						<div class="fitLogo"></div>
							<img src="img/mainHome/item_1.png">
						</div>
						<div class="mainpage_infoDiv">
							<p>베이직 가디건</p>
						</div>
					</div>
					
					<div class="mainpage_productDiv">
						<div class="mainpage_imgDiv">
							<img src="img/mainHome/item_2.png">
						</div>
						<div class="mainpage_infoDiv">
							<p>베이직 가디건</p>
						</div>
					</div>
					
					<div class="mainpage_productDiv">
						<div class="mainpage_imgDiv">
							<div class="fitLogo"></div>
							<img src="img/mainHome/item_1.png">
						</div>
						<div class="mainpage_infoDiv">
							<p>베이직 가디건</p>
						</div>
					</div>
					
					<div class="mainpage_productDiv">
						<div class="mainpage_imgDiv">
							<img src="img/mainHome/item_2.png">
						</div>
						<div class="mainpage_infoDiv">
							<p>베이직 가디건</p>
						</div>
					</div>
					
				</div>
			</div>
			<input id="productId" type="text" style="display: none;" data-role="none">
			<input id="adminSeq" type="text" style="display: none;" data-role="none">
			
			<div class="t-center">
				<img class="bottomAnchor render" src="img/anchor.png" data-render="width,margin-top,margin-bottom" onclick="window.scrollTo(0,0);" />
			</div>
			<div class="footerMargin render" data-render="margin-bottom" data-render-ratio="height"></div>
			
			<div id="purchaseFooter" class="render" data-render="">
				<form id="purchaseFrom" method="post" action="purchaseRequest">
						
	 			<div id="optionSlideControl" style="display:none;" onclick="removeSelectOption(event)">
	 				<span id="optionIcon" class="glyphicon glyphicon-chevron-up"></span>
	 			</div>
	 			<div id="optionSelectorWrap" style="display: none;" class="render" data-render="padding-top,padding-bottom,padding-left,padding-right" onclick="optionSelectorWrapClickHandler(event)">
	 				<div id="colorSelector" class="optionSelector mb14 render" data-render="margin-bottom" data-render-ratio="height" style="text-align: right;">
	 				</div>			
	 				<div class="optionSelector mb14 render" data-render="margin-bottom" data-render-ratio="height">
	 					<select id="sizeSelector" data-role="none" class="render" data-render="height,padding-left,font-size" data-render-ratio="height" name="size">
	 						<option value="" disabled selected>상품 사이즈</option>
	 						
	 					</select>
	 				</div>			
	 				<div class="optionSelector">
	 					<div id="itemQuantity">
	 						<img src="img/moreInfoPage/select_arrow_down.png" onclick="minusCount()" class="middle render" data-render="width" data-render-ratio="height" />
	 						<span id="itemCountSpan" class="middle render" data-render="height,margin-left,margin-right" data-render-ratio="height">
	 							<input data-role="none" type="number" value="" placeholder="상품수량" id="countInput" class="middle render" data-render="width,border-width" data-render-ratio="height" name="amount">
	 						</span>
	 						<img src="img/moreInfoPage/select_arrow_up.png" onclick="plusCount()" class="middle render" data-render="width" data-render-ratio="height" />
	 					</div>
	 				</div>			
	 			</div>	
	 			<div id="myShoppingCart" class="purchaseFooterBtn render"  data-render="height,line-height" data-render-ratio="height" onclick="selectOption(event)">구매하기</div>
	 			<div id="myShoppingCart2" class="purchaseFooterBtn render hide"  data-render="height,line-height" data-render-ratio="height" >
	 				<div id="addCartBtn" class="dib" onclick='cartClickFunc("cartRequest")'>장바구니로</div>
					<div id="purchaseBtn" class="dib" onclick='cartClickFunc("purchaseRequest")'>구매하기</div>
	 			</div>
	 			</form>
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
						<span class="right">￦2,500</span>
					</p>
					<div class="clear line" style="margin-bottom: 5px; border-bottom: 2px solid;" ></div>
					<p class="clear bold" style="margin: 20px 0px;">
						<span class="left">총 결제금액</span>
						<span id="popUpTotalPrice" class="right">￦0</span>
					</p>
					<div class="clear line" style="margin-bottom: 5px; border-bottom: 2px solid;" ></div>
					<form id="pgForm" action="https://mobile.inicis.com/smart/wcard/" method="post" >
						<input type="hidden" name="P_MID" value="dobeweddin">
						<input id="pAmnt" type="hidden" name="P_AMT" value="">
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
						<div class="btnDiv f15" onclick="pgRequest()">결제하기</div>
					</div>
	 		</div>

		</div>
	</div>
</body>
</html>