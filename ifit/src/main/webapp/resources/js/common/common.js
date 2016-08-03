function init_header() {
	$(".headerIcon").each(function(index) {
		switch (index) {
		case 0:
			$(this).attr("src", " img/header/likeItem.png");
			break;
		case 1:
			$(this).attr("src", " img/header/shoppingCart.png");
			break;
		default:
			break;
		}
	});
	$("#searchBar").attr("value", "");
}
function init_footer() {
	$(".footerIcon").each(function(index) {
		switch (index) {
		case 0:
			$(this).attr("src", " img/footer/home.png");
			break;
		case 1:
			$(this).attr("src", " img/footer/category.png");
			break;
		case 2:
			$(this).attr("src", " img/footer/threeD.png");
			break;
		case 3:
			$(this).attr("src", " img/footer/hotDeal.png");
			break;
		case 4:
			$(this).attr("src", " img/footer/myPage.png");
			break;
		default:
			break;
		}
	});
	$("#searchBar").attr("value", "");
}
function homeBtn_Handler(e) {
	init_header();
	init_footer();
	$("#homeBtn").attr("src", " img/footer/homeClick.png");
	$.mobile.changePage("#main_home");
}
function categoryBtn_Handler(e) {
//	localStorage.setItem("isCategory", "true");
	$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
	$.mobile.changePage("#categoryPage");
}
function threeDBtn_Handler(e) {
	init_header();
	init_footer();
	$("#threeDBtn").attr("src", " img/footer/threeDClick.png");
	$.mobile.changePage("#threeDPage");
}

function hotDealBtn_Handler(e) {
	init_header();
	init_footer();
	$("#hotDealBtn").attr("src", " img/footer/hotDealClick.png");
	$.mobile.changePage("#hotDealPage");
}
function myPageBtn_Handler(e) {
	init_header();
	init_footer();
	$("#myPageBtn").attr("src", " img/footer/myPageClick.png");
	$.mobile.changePage("#myPage");
}

function headBar_handler(select){
	init_header();
	init_footer();
	stopSearchBar();
	if(select=="closet"){
		saveScroll();
		location = "codiPage.html";
//		location = "closetGallerySample.html";
		//$.mobile.changePage("#codiPage");
	}else if(select=="zzim"){
		//$("#menuBar").hide(); 일단보류. 백헤더관련 확정되면 적용
		$("#likeItem").attr("src", " img/header/likeItemClick.png");
		$.mobile.changePage("#zzimPage");
	}else if(select=="cart"){
		$("#shoppingCart").attr("src", " img/header/shoppingCartClick.png");
		$.mobile.changePage("#cartPage");
	}
}

function searchTag_Handler(inputValue){
	init_footer();
	stopSearchBar();
	searchRequest(null, inputValue,null);
}
function detailOption(isBtn){
	if(isBtn || event.keyCode==13){
		var inputValue = $("#searchBar").val();
		init_footer();
		stopSearchBar();
		searchRequest(null, inputValue,null);
	}
}
function stopSearchBar() {
	$("#tagDiv").hide();
	$("#footBalckDiv").hide();
	$("#searchBarClickView").hide();
}

function getOption(){
	var selectedCategoryOption = $("#selectedCategoryOption").val();
	var inputValue = $("#selectedInputValue").html();
	var option = $("input[name=sort]:radio:checked").val();
	searchRequest(selectedCategoryOption, inputValue, option);
	optionCancel();
}
function searchRequest(selectedCategory, inputValue,orderOption){
	$.ajax({
		  url: '/ifit/getItems',
		  type:"POST",
		  data: {selectedCategory:selectedCategory,inputValue:inputValue,orderOption:orderOption},
		  dataType: "json",
		  success: function(obj){
			  $.mobile.changePage("#productList");
			  var requestValue = obj.requestValue;
			  $("#selectedCategory").html("");
			  $("#selectedInputValue").html("");
			  //0번이카테 1번이 inputVal
			  if(requestValue[0].productName!=""){
				  var categoryName = $("#categoryOption #"+requestValue[0].productName).html();
				  $("#selectedCategory").append(categoryName);
			  }
			  $("#selectedInputValue").append(requestValue[1].productName);
			  
			  var productList = obj.productList;
			  $("#searchProductList").html("");
			  for(var i in productList){
				  var htmlCode = '<div class="product" onclick="getMoreInfo('+productList[i].productId+')">';
				  htmlCode += '<div class="productList_imgDiv">';
				  if(productList[i].catRef!="")
					  	htmlCode+= '<div class="fitLogo"></div>';
				  htmlCode += '<img src="http://'+productList[i].productMainURL+'"></div>';
				  htmlCode += '<div class="productInfo font-size-10"><div class="moreInfo">';
				  htmlCode += '<img src="img/header/likeItem.png" class="left likeItem">';
				  htmlCode += '<p class="left">'+productList[i].likeCount+'</p>';
				  htmlCode += '<p class="right">'+productList[i].productName+'</p></div>';
				  htmlCode += '<p class="price clear right">&#8361 '+productList[i].productPrice+'<p></div></div>';
				  
				  $("#searchProductList").append(htmlCode);
			  }
			  
		  }
	});
}
function getMoreInfo(productId){
	window.open("moreInfoPage.html?prId="+productId, '_self');
}
function zzimDelete(zzimSeq){
	if(confirm("IFIT : 정말 삭제하시겠습니까??")!=true){
		return;
	}
	$.ajax({
		  url: '/ifit/Users/deleteLikeItem.ap',
		  type:"POST",
		  data: {zzimSeq:zzimSeq},
		  dataType: "json",
		  success: function(obj){
			  if(obj.result == 'success'){
				  $("#zzimPage").find("#"+zzimSeq).remove();
			  }else if(obj.result == 'noUser'){
				  alert("다시로그인해주세요.");
				  window.location.reload(true);
			  }
		  }
	});
}
$(document).on("click",".likeItem",function(e){
	var likeItemNo = $(e.target).attr("id");
	$.ajax({
		  url: '/ifit/Users/likeItem.ap',
		  type:"POST",
		  data: {likeItemNo:likeItemNo},
		  dataType: "json",
		  success: function(obj){
			  var likeCnt = $("#likeCnt").html();
			  likeCnt *=1;
			  if(obj.result == 'success'){
				  alert("찜상품 등록되었습니다.");
				  $(".likeItem").attr("src","img/moreInfoPage/heart_like.png");
				  $("#likeCnt").html(likeCnt+1);
			  }else if(obj.result == 'alreadyLike'){
				  alert("찜삭제되었습니다.");
				  $(".likeItem").attr("src","img/moreInfoPage/heart.png");
				  $("#likeCnt").html(likeCnt-1);
			  }else
				  alert("로그인 후 이용하세요.");
		  }
	});
});

$(function() {
	//일단은 홈이랑 다적용되지만 홈은따로빼야함
	$("#categoryPage .middleEach").click(function() {
		var selectedCategory = $(this).attr("id");
		searchRequest(selectedCategory, null,null);
	});
	$("#ffitingMiddleBar").click(function(){
		location = 'index.html#threeDPage';
	});
	
	$("#weddingMiddleBar").click(function() {
		var selectedCategory = 6;
		searchRequest(selectedCategory, null,null);
	});
	$("#eventMiddleBar").click(function(){
		location = 'index.html#hotDealPage';
	});
	
	$("#bestMiddleBar").click(function(){
		$.mobile.changePage("#productList");
		showLoading();
		$.ajax({
			  url: '/ifit/getBestCategory',
			  type:"get",
			  dataType: "json",
			  success: function(obj){
				  hideLoading();
				  var productList = obj.bestList;
				  $("#searchProductList").html("");
				  for(var i in productList){
					  var htmlCode = '<div class="product" onclick="getMoreInfo('+productList[i].productId+')">';
					  htmlCode += '<div class="productList_imgDiv">';
					  if(productList[i].catRef!="")
						  	htmlCode+= '<div class="fitLogo"></div>';
					  htmlCode += '<img src="http://'+productList[i].productMainURL+'"></div>';
					  htmlCode += '<div class="productInfo font-size-10"><div class="moreInfo">';
					  htmlCode += '<img src="img/header/likeItem.png" class="left likeItem">';
					  htmlCode += '<p class="left">'+productList[i].likeCount+'</p>';
					  htmlCode += '<p class="right">'+productList[i].productName+'</p></div>';
					  htmlCode += '<p class="price clear right">&#8361 '+productList[i].productPrice+'<p></div></div>';
					  
					  $("#searchProductList").append(htmlCode);
				  }
			  }
		});
	});
	
	$(".optionCategory").click(function(){
		$("#selectedCategoryOption").val($(this).attr("id"));
	})
	
	$("[data-role='header'], [data-role='footer']").toolbar();
	$("#searchBar").click(function(){
		$("#searchBarClickView").show();
		$("#tagDiv").show();
		$("#footBalckDiv").show();
	});

	$("#hashRecommandWrapDiv").click(function(e) {
		e.stopPropagation();
	});
	$("#menuBar").click(function(e) {
		e.stopPropagation();
	});
	$(".recommandItems").click(function(e) {
		$("#searchBar").attr("value", $(this).text());
		e.stopPropagation();
	});
	$(".eachPage").on("pagebeforehide", function(event) {
		$("#adWrap").hide();
	});
	
	$(".haveADContent").on("pagebeforeshow", function(event) {
		$("#adWrap").fadeIn();
	});

	if (!($(".ui-page-active").hasClass("haveADContent"))) {
		$("#adWrap").hide();
	}
	
	$(document).on("pageshow",function(e){
		var pageName = $($(window.location.href.split("/")).last()[0].split(".html")).last()[0].replace("&","");
		init_header();
		init_footer();
		stopSearchBar();
		switch(pageName){
			case "":
				$(homeBtn).attr("src", " img/footer/homeClick.png");
				break;
			case "#categoryPage":
				$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
				showLoading();
				$.ajax({
					  url: '/ifit/getBestCategory',
					  dataType: "json",
					  success: function(obj){
						  $("#categoryPage .mainpage_boxContents").html("");
						  var bestList = obj.bestList;
						  for(var i in bestList){
							  var locationId = '#'+bestList[i].category;
							  var htmlCode = '<div class="mainpage_productDiv" onclick="getMoreInfo('+bestList[i].productId+')">';
							  htmlCode += '<div class="mainpage_imgDiv">';
							  if(bestList[i].catRef!="")
								  	htmlCode+= '<div class="fitLogo"></div>';
							  htmlCode += '<img src="http://'+bestList[i].productMainURL+'" alt="DB에러:잘못된사진URL">';
							  htmlCode += '</div><div class="mainpage_infoDiv">';
							  htmlCode += '<p>'+bestList[i].productName+'</p></div></div>';
							  $("#categoryContents").find(locationId).append(htmlCode);
						  }
						  hideLoading();
					  }
				});
				
				break;
			case "#threeDPage":
				$("#threeDBtn").attr("src", " img/footer/threeDClick.png");
				break;
			case "#hotDealPage":
				$("#hotDealBtn").attr("src", " img/footer/hotDealClick.png");
				showLoading();
				$.ajax({
					  url: '/ifit/getPromotionList',
					  dataType: "json",
					  success: function(obj){
						  $("#promotions").html("");
						  var promotionList = obj.promotionList;
						  for(var i in promotionList){
							  var htmlCode = '<div class="hotContents" onclick="getSubPromotion('+promotionList[i].proSeq+')">';
							  htmlCode+= '<p id="'+promotionList[i].proSeq+'" class="mainpage_boxTitle">'+promotionList[i].promotionName+'</p>';
							  htmlCode+= '<img src="http://'+promotionList[i].promotionURL+'"></div>';
							  $("#promotions").append(htmlCode);
						  }
						  hideLoading();
					  }
				});
				
				break;
			case "#myPage":
				$("#myPageBtn").attr("src", " img/footer/myPageClick.png");
				break;
			case "#cartPage":
				$("#shoppingCart").attr("src", " img/header/shoppingCartClick.png");
				
				showLoading();
				
				$.ajax({
					  url: '/ifit/Users/getCartItems',
					  dataType: "json",
					  success: function(obj){
						  $("#cartListView").html('');
						  for(var i in obj){
							  var htmlCode = '<div class="cart_item itemOn render" data-render="width,height,margin-bottom" data-admin-seq="'+obj[i].adminSeq+'" data-price="'+obj[i].productPrice+'" data-product_id="'+obj[i].productId+'" data-cart_seq="'+obj[i].cartSeq+'">';
							  htmlCode += '<div class="itemPhotoArea center render" data-render="width,height,line-height">';
							  htmlCode += '<img class="cart_photo" src="http://'+obj[i].productMainURL+'"></div>';
							  htmlCode += '<div class="itemOptionArea render" data-render="width,height,padding-top,padding-bottom,padding-left">';
							  htmlCode += '<div class="font-size-13 mb10 render" data-render="width,height,margin-bottom,font-size,line-height">';
							  htmlCode += '<p class="font-size-13 render dib" data-render="font-size">'+obj[i].productName+'</p>';
							  htmlCode += '<div class="itemDeleteBtn right mr10 render" data-render="width,height,margin-right" onclick="cartDelte(this)" data-cart-seq="'+obj[i].cartSeq+'"></div>';
							  htmlCode += '<div class="itemOptionCheckBtn right mr10 render" data-render="width,height,margin-right" onclick="itemSelectClick(this)"></div></div>';
							  htmlCode += '<div class="mb10 render" data-render="width,height,line-height,margin-bottom">';
							  htmlCode += '<ul class="selectSize font-size-13 render" data-render="font-size">';
							  var sizeList = obj[i].sizeList; 
							  for(var j in sizeList){
								  if(obj[i].selectedSizeId==sizeList[j].size_id){
									  htmlCode += '<li class="render btnOn" data-render="height,margin-right,line-height" data-size_id="'+sizeList[j].size_id+'" onclick="sizeClick(this)">'+sizeList[j].size_val+'</li>';  
								  }else{
									  htmlCode += '<li class="render" data-render="height,margin-right,line-height" data-size_id="'+sizeList[j].size_id+'" onclick="sizeClick(this)">'+sizeList[j].size_val+'</li>';
								  }
							  }
							  htmlCode += '</ul></div>';
							  htmlCode += '<div class="font-size-13 mb10 render" data-render="width,height,margin-bottom">';
							  var colorList = obj[i].colorList;
							  for(var j in colorList){
								  if(obj[i].selectedColorId==colorList[j].colorId){
									  htmlCode +='<div class="colorWrap colorOn dib render" data-render="width,height,margin-right" data-color_id="'+colorList[j].colorId+'" onclick="colorClick(this)"><p class="colorValue dib render mr10" data-render="width,height,margin-right" data-render-ratio="width,height" style="background-color: '+colorList[j].colorValue+';" ></p></div>';
								  }else{
									  htmlCode +='<div class="colorWrap dib render" data-render="width,height,margin-right" data-color_id="'+colorList[j].colorId+'" onclick="colorClick(this)"><p class="colorValue dib render mr10" data-render="width,height,margin-right" data-render-ratio="width,height" style="background-color: '+colorList[j].colorValue+';" ></p></div>';
								  }
							  }
							  htmlCode += '</div><div class="font-size-13 render" data-render="width,height,font-size">';
							  htmlCode += '<img src="img/select_count_down.png" class="select_count_btn render mr10 numDown" data-render="height,margin-right" onclick="numDown(this)">';
							  htmlCode += '<p class="font-size-13 render dib cartAmount" data-render="font-size">1</p>';
							  htmlCode += '<img src="img/select_count_up.png" class="select_count_btn render ml10 numUp" data-render="height,margin-left" onclick="numUp(this)">';
							  htmlCode += '<p class="itemPrice right render" data-render="margin-right">'+addCurrencyMark(obj[i].productPrice)+'</p>';
							  htmlCode += '</div></div>';
							  htmlCode += '<hr class="cart_item_separate clear render" data-render="width,border-top-width,margin-top" /></div>';
							  $("#cartListView").append(htmlCode);
						  }
						  calculateAll();
						  renderStart("#cartListView .render");
						  hideLoading();
					  },
					  error:function(obj){
						  hideLoading();
						  alert("로그인후 이용하세요.");
						  location = "index.html#myPage";
					  }
				});
				break;
			case "#zzimPage":
				$("#likeItem").attr("src", " img/header/likeItemClick.png");
				
				showLoading();
				$.ajax({
					  url: '/ifit/Users/getLikeList',
					  dataType: "json",
					  success: function(obj){
						  $("#zzimItemListView").html('');
						  for(var i in obj){
							  var htmlCode = '<div id="'+obj[i].zzimSeq+'" class="cart_item itemOn render" data-render="width,height">'; 
							  htmlCode += '<hr class="cart_item_separate clear render" data-render="width" />';
							  htmlCode += '<div class="itemPhotoArea center render" data-render="width,height,line-height" onclick="getMoreInfo('+obj[i].productId+')">';
							  htmlCode += '<img class="cart_photo" src="http://'+obj[i].productMainURL+'"></div>';
							  htmlCode += '<div class="itemOptionArea render" data-render="width,height,padding-top,padding-bottom,padding-left">';
							  htmlCode += '<div class="font-size-13 mb10 render" data-render="width,height,margin-bottom,font-size,line-height">';
							  htmlCode += '<p class="font-size-13 render dib" data-render="font-size">'+obj[i].productName+'</p>';
							  htmlCode += '<div class="itemDeleteBtn right mr10 render" data-render="width,height,margin-right" onclick="zzimDelete('+obj[i].zzimSeq+')"></div></div>';
							  htmlCode += '<div class="font-size-13 mb10 render" data-render="width,height,margin-bottom">';
							  htmlCode += '<img src="img/header/shoppingCart.png" class="item_cart_btn render ml10 mr10 right" data-render="height,margin-left,margin-right" onclick="goCart('+obj[i].zzimSeq+','+obj[i].productId+')">';
							  htmlCode += '<p class="font-size-13 render dib middle cartText right" data-render="font-size" onclick="goCart('+obj[i].zzimSeq+','+obj[i].productId+')">장바구니</p></div>';
							  htmlCode += '<div class="font-size-13 render" data-render="width,height,font-size">';
							  htmlCode += '<p class="itemPrice right render" data-render="margin-right">'+addCurrencyMark(obj[i].productPrice)+'</p>';
							  htmlCode += '</div></div></div>';
							  $("#zzimItemListView").append(htmlCode);
						  }
						  renderStart("#zzimPage .render");
						  hideLoading();
					  },
					  error:function(obj){
						  hideLoading();
						  alert("로그인후 이용하세요.");
						  location = "index.html#myPage";
					  }
				});
				
				break;
			case "#productList":
				$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
				
//				var prePageName = localStorage.getItem("isCategory");
//				if(prePageName == "true"){
//					init_footer();
//					$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
//				}
				
				break;
			case "#codiPage":
				break;
			default :
				init_footer();
				break;
		}
	});
});
function saveScroll(){
//	console.log("saveScroll");
//	console.log($($(window.location.href.split("/")).last()[0].split(".html")).last()[0].replace("&",""));
//	if($($(window.location.href.split("/")).last()[0].split(".html")).last()[0].replace("&","") =="#categoryPage")
//		localStorage.setItem("prepageName", "category");
}

$.urlParam = function(name){
	var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	return results[1] || 0;
};

function showLoading(){
	$("#loadingDiv").show();
}

function hideLoading(){
	$("#loadingDiv").hide();
}
function addCurrencyMark(price){
	return "￦"+price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCurrencyMark(price){
	return parseInt(price.replace(/[^0-9]/g,""));
}