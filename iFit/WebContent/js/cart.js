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

function itemPriceSum(){
	var sum = 0;
	$(".item_price_list").each(function(){
		if($(this).css("display") != "none"){
			sum += parseInt(($(this).children("p:last-child").html()).replace(/[^0-9]/g,""));
		}
	});
	$("#item_price_sum").html("￦"+sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	
}
$(document).ready(function() {
//	reCal();
	
	$(".numUp").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			var amount = $(this).parents().children(".cartAmount");
			var count = $(amount).text();
			$(amount).text(parseInt(count)+1);
//			var itemObj = $("#item_price_"+$(this).parents(".cart_item").attr("data-item-idx")+" p:first-child");
//			if(parseInt(count)+1>1){
//				itemObj.children("span").show();
//			}else{
//				itemObj.children("span").hide();
//			}
//			itemObj.children("span:last-child").html(parseInt(count)+1);
//			var itemPrice = $(this).siblings(".itemPrice").html();
//			itemPrice = itemPrice.replace(/[^0-9]/g,"");
//			var calPriceString = "￦"+(itemPrice*(parseInt(count)+1)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//			itemObj.siblings().html(calPriceString);
//			itemPriceSum();
		}

	})
	
	$(".numDown").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			var amount = $(this).parents().children(".cartAmount");
			var count = $(amount).text();
			if(parseInt(count)>1)	$(amount).text(parseInt(count)-1);
			
//			var itemObj = $("#item_price_"+$(this).parents(".cart_item").attr("data-item-idx")+" p:first-child");
//			if(parseInt(count)-1>1){
//				itemObj.children("span").show();
//			}else{
//				itemObj.children("span").hide();
//			}
//			
//			if(parseInt(count)-1>0){
//				itemObj.children("span:last-child").html(parseInt(count)-1);
//				var itemPrice = $(this).siblings(".itemPrice").html();
//				itemPrice = itemPrice.replace(/[^0-9]/g,"");
//				var calPriceString = "￦"+(itemPrice*(parseInt(count)-1)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//				itemObj.siblings().html(calPriceString);
//				itemPriceSum();
//			}
		}
	})
	
	
	// 웨딩쪽 시연때문에 임시로
	$(".numUp_w").click(function(){
		if($(this).parents(".cart_item").hasClass("itemOn") === true) {
			var amount = $(this).parents().children(".cartAmount");
			var count = $(amount).text();
			$(amount).text(parseInt(count)+1);
		}
	})
	
	$(".numDown_w").click(function(){
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
			$("#item_price_"+$(this).parents(".cart_item").attr("data-item-idx")).hide();
			itemPriceSum();
		}else if($(this).parents(".cart_item").hasClass("itemOff") === true) {
			$(this).parents(".cart_item").removeClass("itemOff");
			$(this).parents(".cart_item").addClass("itemOn");
			$("#item_price_"+$(this).parents(".cart_item").attr("data-item-idx")).show();
			itemPriceSum();
		}
	});
	$(".itemDeleteBtn").click(function(){
		if($(this).parents("#cartPage").length>0){
			//	장바구니
			if(confirm("장바구니 상품을 삭제하시겠습니까?")){
				$(this).parents(".cart_item").remove();
				itemPriceSum();
			}
		}else if($(this).parents("#zzimPage").length>0){
			if(confirm("찜상품을 삭제하시겠습니까?")){
				$(this).parents(".cart_item").remove();
			}
		}
	});
})