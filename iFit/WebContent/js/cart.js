$(document).on("click",".cart_photo",function(e){
	var prID = 0; // $(e.target).class() == "hotDeal_Item"    --> prID = $(e.target).id(); e.stopPropagation(); 
	// id에 고유 상품 번호를 넣어서... 
	
	saveScroll();
	window.open("moreInfoPage.html?prId="+prID, '_self');
});

$(document).on("click",".cart_btnDiv>img",function(e){
	var prID = 0; // $(e.target).class() == "hotDeal_Item"    --> prID = $(e.target).id(); e.stopPropagation(); 
	// id에 고유 상품 번호를 넣어서... 
	alert("바로구매 & 장바구니");
	
});

function reCal(){
	var totalPrice=0;
	var num=0;
	$(".realPrice").each(function() {
		totalPrice+=parseInt($(this).text());
		num++;
	});
	var deliveryPrice =0;
	if(num>0){
		deliveryPrice = 15000;
	}
	$("#deliveryPrice").text(deliveryPrice);
	$("#sumPrice").text(totalPrice);
	totalPrice += deliveryPrice;
	$("#totalPrice").text(totalPrice);
}

function removeCart(productId){
	//ajax요청후
	$("#cartPage").find("#"+productId).remove();
	reCal();
}
$(document).ready(function() {
//	reCal();
	
	$(".numUp").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			var amount = $(this).parents().children(".cartAmount");
			var count = $(amount).text();
			$(amount).text(parseInt(count)+1);
		}
		alert($(this).parents("cart_item").attr("data-item-idx"));
	})
	
	$(".numDown").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			var amount = $(this).parents().children(".cartAmount");
			var count = $(amount).text();
			if(count!=0)	$(amount).text(parseInt(count)-1);
		}
	})
});


//16.03.22추가 작업

$(function(){
	$("#selectSize li").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			$("#selectSize li").each(function(){
				$(this).removeClass("btnOn");
			});
			$(this).addClass("btnOn");
		}
	});
	$(".itemOptionCheckBtn").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			$(this).parents(".cart_item").removeClass("itemOn");
			$(this).parents(".cart_item").addClass("itemOff");
		}else if($(this).parents(".cart_item").hasClass("itemOff") === true === true) {
			$(this).parents(".cart_item").removeClass("itemOff");
			$(this).parents(".cart_item").addClass("itemOn");
		}
	});
	$(".itemDeleteBtn").click(function(){
		if(confirm("찜상품을 삭제하시겠습니까?")){
			$(this).parents(".cart_item").remove();
		}
	});
})