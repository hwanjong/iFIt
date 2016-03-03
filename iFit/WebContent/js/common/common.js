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
function createBlackEffect() {
	$("#blackEffect").show();
	$("#footerBlackEffectDiv").show();
}
function removeBlackEffect() {
	$("#blackEffect").hide();
	$("#footerBlackEffectDiv").hide();
}

function homeBtn_Handler(e) {
	init_footer();
	$("#homeBtn").attr("src", " img/footer/homeClick.png");
	$.mobile.changePage("#main_home");
}
function categoryBtn_Handler(e) {
	init_footer();
//	localStorage.setItem("isCategory", "true");
	$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
	$.mobile.changePage("#categoryPage");
}
function threeDBtn_Handler(e) {
	init_footer();
	$("#threeDBtn").attr("src", " img/footer/threeDClick.png");
	$.mobile.changePage("#threeDPage");
}
function hotDealBtn_Handler(e) {
	init_footer();
	$("#hotDealBtn").attr("src", " img/footer/hotDealClick.png");
	$.mobile.changePage("#hotDealPage");
}
function myPageBtn_Handler(e) {
	init_footer();
	$("#myPageBtn").attr("src", " img/footer/myPageClick.png");
	$.mobile.changePage("#myPage");
}
function closetBtn_Handler(e) {
	init_footer();
	$.mobile.changePage("#codiPage");
}
function likeItemBtn_Handler(e) {
	init_footer();
	$.mobile.changePage("#zzimPage");
}
function shoppingCartBtn_Handler(e) {
	init_footer();
	$.mobile.changePage("#cartPage");
}
function searchInputBtn_Handler(e) {
	$("#hashRecommandWrapDiv").css("display", "block");
	$("#searchBarDefaultView").css("display", "none");
	$("#searchBarClickView").css("display", "inline");
	createBlackEffect();
	e.stopPropagation();
}
function searchBarBtn_Handler(e) {
	var queryValue = $("#searchBar").attr("value");
	init_footer();
	stopSearchBar_Handler(e);
	console.log("검색 질의어 : " + queryValue);
//	localStorage.setItem("isCategory", "false");
	$.mobile.changePage("#productList");
}
function stopSearchBar_Handler(e) {
	removeBlackEffect();
	if ($("#hashRecommandWrapDiv").css("display") == "block") {
		$("#hashRecommandWrapDiv").css("display", "none");
		$("#searchBarDefaultView").css("display", "inline");
		$("#searchBarClickView").css("display", "none");
	}
	e.stopPropagation();
}


$(function() {
	$("[data-role='header'], [data-role='footer']").toolbar();
	$("#searchBar").click(searchInputBtn_Handler);

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
	$("#blackEffect").click(stopSearchBar_Handler);
	$(".carousel-inner>.item").on("swipeleft", function(e) {
		$("#myCarousel").carousel("next");
	});
	$(".carousel-inner>.item").on("swiperight", function(e) {
		$("#myCarousel").carousel("prev");
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
		console.log(pageName);
		switch(pageName){
			case "":
			init_footer();
			$(homeBtn).attr("src", " img/footer/homeClick.png");
			break;
			case "#categoryPage":
				init_footer();
				$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
				break;
			case "#threeDPage":
				init_footer();
				$("#threeDBtn").attr("src", " img/footer/threeDClick.png");
				break;
			case "#hotDealPage":
				init_footer();
				$("#hotDealBtn").attr("src", " img/footer/hotDealClick.png");
				break;
			case "#myPage":
				init_footer();
				$("#myPageBtn").attr("src", " img/footer/myPageClick.png");
				break;
			case "#cartPage":
				break;
			case "#zzimPage":
				break;
			case "#productList":
				init_footer();
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
}