$(document).on("click",".cart_btnDiv>img",function(e){
	var prID = 0; // $(e.target).class() == "hotDeal_Item"    --> prID = $(e.target).id(); e.stopPropagation(); 
	// id에 고유 상품 번호를 넣어서... 
	alert("바로구매 & 장바구니");
	
});
var adminList;
var deliveryFee;
var sum = 0;
function itemPriceSum(){
	sum=0;
	$(".dynamic_price").each(function(){
		sum += removeCurrencyMark($(this).children("p:last-child").html());
	});
	deliveryFee = adminList.length*2500;
	$("#deleveryFee").html(addCurrencyMark(deliveryFee));
	sum+= deliveryFee;
	
	$("#item_price_sum").html(addCurrencyMark(sum));
	
}

function calculateAll(){
	var itemName;
	var itemCnt;
	var itemPrice;
	var itemNo;
	adminList = new Array();
	$(".dynamic_price").remove();
	$(".basicItem .itemOn").each(function(){
		var nowAdminSeq = $(this).attr("data-admin-seq");
		if(adminList.indexOf(nowAdminSeq)==-1){
			adminList.push(nowAdminSeq);
		}
		var calculateHtml="";
		itemName = $(this).children(".itemOptionArea").children("div:first-child").children("p").html();
		itemCnt = $(this).children(".itemOptionArea").children("div:last-child").children("p:first").html();
		itemPrice = $(this).children(".itemOptionArea").children("div:last-child").children("p:last").html();
		//itemNo = $(this).attr("data-item-idx");
		calculateHtml += '<div  class="dynamic_price item_price_list font-size-13 mb10 render" data-render="width,height,margin-bottom">';
		calculateHtml += '<p class="font-size-13 render dib" data-render="font-size">' + itemName;
		if(itemCnt>1){
			calculateHtml += '<span> x</span><span>' + itemCnt + '</span></p>';
			itemPrice = addCurrencyMark(itemCnt * removeCurrencyMark(itemPrice));
		}
		calculateHtml += '<p class="font-size-13 render dib fr" data-render="font-size">' + itemPrice + '</p>';
		calculateHtml += '</div>';
		
		$("#priceInfo .itemOptionArea #delivery_price").before(calculateHtml);
	});
	
	itemPriceSum();
	renderStart("#priceInfo .dynamic_price");
}

function addCurrencyMark(price){
	return "￦"+price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeCurrencyMark(price){
	return parseInt(price.replace(/[^0-9]/g,""));
}

function numUp(item){
	if($(item).parents(".cart_item").hasClass("itemOn") === true) {
		var amount = $(item).parents().children(".cartAmount");
		var count = $(amount).text();
		$(amount).text(parseInt(count)+1);
		calculateAll();
	}
}
function numDown(item){
	if($(item).parents(".cart_item").hasClass("itemOn") === true) {
		var amount = $(item).parents().children(".cartAmount");
		var count = $(amount).text();
		if(parseInt(count)>1)	$(amount).text(parseInt(count)-1);
		calculateAll();
	}
}

function sizeClick(item){
	if($(item).parents(".cart_item").hasClass("itemOn") === true) {
		$(item).parents().children("li").each(function(){
			$(this).removeClass("btnOn");
		});
		$(item).addClass("btnOn");
	}
}
function colorClick(item){
	if($(item).parents().parents(".cart_item").hasClass("itemOn") === true) {
		$(item).parents().children("div").each(function(){
			$(this).removeClass("colorOn");
		});
		$(item).addClass("colorOn");
	}
}

function itemSelectClick(item){
	if($(item).parents(".cart_item").hasClass("itemOn") === true) {
		$(item).parents(".cart_item").removeClass("itemOn");
		$(item).parents(".cart_item").addClass("itemOff");
		calculateAll();
	}else if($(item).parents(".cart_item").hasClass("itemOff") === true) {
		$(item).parents(".cart_item").removeClass("itemOff");
		$(item).parents(".cart_item").addClass("itemOn");
		calculateAll();
	}
}
function cartDelte(item){
	//서버검증 : 해당Session user와  Seq를 검증 후 삭제
	console.log(item);
	if(!confirm("장바구니 상품을 삭제하시겠습니까?")){
		return;
	}
	var cartSeq = $(item).attr("data-cart-seq");
	$.ajax({
		  url: '/ifit/Users/deleteCart.ap',
		  type:"POST",
		  data: {cartSeq:cartSeq},
		  dataType: "json",
		  success: function(obj){
			  if(obj.result=='success'){
				  alert("삭제되었습니다.");
				  window.location.reload(true);
			  }else{
				  alert("로그인 후 이용하세요");
				  location = "index.html#myPage"
			  }
		  }
	});
	
//	$(item).parents(".cart_item").remove();
//	calculateAll();
}
function cartToBuyBtn(){
	//validation 검사
	var canNext=0;
	$(".basicItem .itemOn").each(function(){
		if($(this).find('.colorOn').length+$(this).find('.btnOn').length!=2){
			canNext++;
		}
	});
	if(canNext!=0){
		alert("선택되지 않은 옵션이 있습니다.");
		return;
	}
	$("#popUpPrice").html(addCurrencyMark(sum-deliveryFee));
	$("#deliveryFee").html(addCurrencyMark(deliveryFee));
	$("#popUpTotalPrice").html(addCurrencyMark(sum));
	$("#deliveryPopUp").show();
}
function closePopUp(){
	$("#deliveryPopUp").hide();
}
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
function pgRequest(){
	var payUserName =$("#userName").val();
	var deliveryAddress=$("#address1").val();
	var deliveryAddressDetail=$("#address2").val();
	var totalPrice = removeCurrencyMark($("#popUpTotalPrice").html());
	showLoading();
	var actionUrl = $("#actionURL option:selected").val();
	if(actionUrl=='none'){
		alert("결제수단을 선택하세요");
		return;
	}
	
	//pay동작과 순서 잘생각해봐야함.
	$("#pgForm").attr("action",actionUrl);
	$("#pAmnt").val(totalPrice);
	$("#pGoods").val(payUserName+"님의 결제묶음");
	
	$("#pUname").val(payUserName);
	$("#pgForm").submit();
	/*구매완료시동작
	$.ajax({
		  url: '/ifit/Users/cartPurchaseRequest.ap',
		  type:"POST",
		  data: {payUserName:payUserName,deliveryAddress:deliveryAddress,deliveryAddressDetail:deliveryAddressDetail,totalPrice:totalPrice},
		  dataType: "json",
		  success: function(obj){
			  hideLoading();
			  if(obj.result =="fail"){
				  alert("로그인 시간초과");
				  window.location.reload(true);
			  }
			  $("#paySeq").val(paySeq);
			  var paySeq = obj.paySeq; 
			  
			  $(".basicItem .itemOn").each(function(){
				  var nowAdminSeq = $(this).attr("data-admin-seq");
				  var productId = $(this).attr("data-product_id");
				  var sizeId = $(this).find(".btnOn").attr("data-size_id");
				  var colorId = $(this).find(".colorOn").attr("data-color_id");
				  var amount = $(this).find(".cartAmount").html();
				  var price = $(this).attr("data-price");
				  var cartSeq = $(this).attr("data-cart_seq");
				  $.ajax({
					  url: '/ifit/Users/insertEachOrder.ap',
					  type:"POST",
					  data: {pay_seq:paySeq,productId:productId,color:colorId,size:sizeId,amount:amount,price:price,adminSeq:nowAdminSeq,cartSeq:cartSeq},
					  dataType: "json",
					  success: function(obj){
						  if(obj.result=='fail'){
							  alert("중도실패건발생!");
						  }
					  }
				  });
				  
			  });
			  if(confirm("주문이 성공적으로 접수되었습니다. 결제 샘플 페이지로 이동하시겠습니까?")==true){
				  location = 'https://drmobile.inicis.com/smart/wcard/gateway.php';
			  }else{
				  window.location.reload(true);
			  }
		  }
	});
	
	*/
//	purchaseRequest(checkColor,checkSize,checkCount,'purchaseRequest',payUserName,deliveryAddress,deliveryAddressDetail);
	
}

function goCart(zzimSeq,productId){
	$.ajax({
		  url: '/ifit/Users/transferCart.ap',
		  type:"POST",
		  data: {zzimSeq:zzimSeq,productId:productId},
		  dataType: "json",
		  success: function(obj){
			  if(obj.result=='success'){
				  alert("장바구니에 등록되었습니다.");
				  window.location.reload(true);
			  }else{
				  alert("로그인 후 이용하세요");
				  location = "index.html#myPage"
			  }
		  }
	});
}