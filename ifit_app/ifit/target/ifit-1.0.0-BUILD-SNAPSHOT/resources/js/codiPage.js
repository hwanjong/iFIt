function addCurrencyMark(price){
	return "￦"+price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
var selectNum = 0;
//옷장부르는 function
function closetCall() {
	//전체 div Change
	$("#closetSelector").animate({
		"bottom" : "0px"
	}, "slow", function() {
		$("#closetSelector").css("position", "relative");

		//푸터 change
		if (selectNum >= 2) {
			$("#cloCoFooter").show();
			$("#closetFooter").show();
		} else {
			$("#cloCoFooter").hide();
			$("#closetFooter").hide();
		}

		$("#codiFooter").hide();
		$("#pageName").html("옷장");

	});

}

function refresh(){
	$("#imgListDiv").html('');
	$(".codiSelect").each(
		function() {
			var srcLocation = $(this).find(".eachImg").attr("src");
			var htmlCode = '<div class="selectItem"  style="position: absolute; left: '
				+ randomRange(0, 75) + '%; top: '
				+ randomRange(0, 35) + '%;"><img src="' + srcLocation + '"></div>';
			$("#imgListDiv").append(htmlCode);
		});
}

function randomRange(n1, n2) {
	n2*=10000;
	var delaySum=0;
	return Math.floor((Math.random() * (n2 - n1 + 1)) + n1) *0.0001;
}
//가상 codi페이지 부르는 버튼 누를때 function
function codiCall() {
	var htmlCode = '';
	$("#imgListDiv").html('');
	//전체를 랜덤하게 뿌려줌.
	refresh();
	var totalPrice =0;
	//가격계산
	$("#order").html("");
	var htmlCode = '';
	$(".codiSelect").each(function() {
		var price = $(this).attr("data-price");
		
		price*=1;
		var productName =$(this).attr("data-product_name");
		htmlCode += '<div class="font-size-13 mb10" style="height: 20px; margin-bottom: 10px;">';
		htmlCode += '<p class="font-size-13 render dib" data-render="font-size" style="font-size: 13px;">'+productName+'</p>';
		htmlCode += '<p class="font-size-13 render dib fr" data-render="font-size" style="font-size: 13px;">'+addCurrencyMark(price)+'</p></div>';
		totalPrice += price;
	});
	$("#order").html(htmlCode);
	$("#totalPrice").html(addCurrencyMark(totalPrice));

	//전체 div Change
	$("#closetSelector").css("position", "fixed");
	$("#closetSelector").animate({
		"bottom" : "1000px"
	}, "slow", function() {
		//$("#closetSelector").hide();
	});

	//푸터 change
	$("#closetFooter").hide();
	$("#codiFooter").show();

	$("#pageName").html("코디하기");

}
function showLoading(){
	$("#loadingDiv").show();
}

function hideLoading(){
	$("#loadingDiv").hide();
}
$(document).ready(function() {
	$('.container').carousel({
		num : 5,
		maxWidth : 120,
		maxHeight : 150,
		scale : 0.9,
		distance : 40,
		autoPlay : false
	});

	$(".container li").click(function() {
		var clickZIndex = $(this).css('width');
		if (clickZIndex != '120px') {
			return;
		}
		//취소
		if ($(this).attr('class') == 'codiSelect') {
			selectNum--;
			$(this).attr('class', ' ');
			$(this).css("background-color", "black");
			$(this).find(".eachImg").css("opacity", "1")
			$(this).find(".cancelImg").remove();
		} else {
			//추가

			if (selectNum == 4) {
				$(this).css("background-color", "red");
				$(this).find(".eachImg").css("opacity", "0.5");
				$(this).animate({
					"opacity" : "1"
				}, "slow", function() {
					$(this).find(".eachImg").css("opacity", "1")
					$(this).css("background-color", "black");
				});
				return;
			}
			selectNum++;
			$(this).attr('class', 'codiSelect');
			$(this).css("background-color", "#A5FFEB");
			$(this).find(".eachImg").css("opacity", "0.5")
			$(this).append($("#codiHidDiv").html());
		}
		if (selectNum >= 2) {
			$("#cloCoFooter").show();
			$("#closetFooter").show();
		} else {
			$("#cloCoFooter").hide();
			$("#closetFooter").hide();
		}
	});
});