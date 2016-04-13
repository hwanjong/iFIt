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
	reCal();
	$(".cart_cancleBtn").on
});