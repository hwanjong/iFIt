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
var isCalledNewPage = "false";
var isInit = "";

$(document).on("unload",function(e){
	eraseCookie("isInit");
	eraseCookie("isCalledNewPage");
	eraseCookie("scollPos");
});

$(function() {
	if(isInit=="")
		isInit=getCookie("isInit");
	console.log(isInit);
	if(isInit == "false"){		
		if (navigator.onLine == false) {
			alert("인터넷 연결이 되지 않음..");
		} else {
			$.mobile.changePage("#main_home");
		}
		isInit="true";
		setCookie("isInit",isInit,1);
	}
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
	$(".eachPage").on("pageshow", function(event) {
		initPage();
		switch ($(".ui-page-active").attr("id")) {
		case "main_home":
			homeBtn_Handler();
			break;
		case "categoryPage":
			categoryBtn_Handler();
			break;
		case "productList":
			init_footer();
			$("#categoryBtn").attr("src", " img/footer/categoryClick.png");
			break;
		case "threeDPage":
			threeDBtn_Handler();
			break;
		case "hotDealPage":
			hotDealBtn_Handler();
			break;
		case "myPage":
			myPageBtn_Handler();
			break;
		default:
			init_footer();
			break;
		}
	});
	$(".haveADContent").on("pagebeforeshow", function(event) {
		$("#adWrap").fadeIn();
	});

	if (!($(".ui-page-active").hasClass("haveADContent"))) {
		$("#adWrap").hide();
	}	
});



function initPage() {
	isCalledNewPage = getCookie("isCalledNewPage");
	eraseCookie("isCalledNewPage");
	if (isCalledNewPage == "true") {
		var varScroll = getCookie('scollPos');
		window.scrollTo(0, varScroll);
		setCookie('isCalledNewPage', "false", 1);
		isCalledNewPage = "false";
	}
}

function saveScroll() {
	setCookie('scollPos', document.body.scrollTop, 1);
	setCookie('isCalledNewPage', true, 1);

}
function eraseCookie(name) {
	setCookie(name, "", -1);
}
function setCookie(cname, cvalue, hour) {
	var d = new Date();
	d.setTime(d.getTime() + (hour  * 60 * 60 * 1000));
	var expires = "expires=" + d.toUTCString();
	document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ')
			c = c.substring(1);
		if (c.indexOf(name) == 0)
			return c.substring(name.length, c.length);
	}
	return "";
}