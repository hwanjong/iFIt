var select_star=4;
var orderSeq;
var productId;
var comment;
function starEventhandlerRegist() {
	$(document).on("click",".starItem",
			function(e) {

				switch ($(e.target).attr("id")) {
				case "star_1":
					select_star = 1;
					break;
				case "star_2":
					select_star = 2;
					break;
				case "star_3":
					select_star = 3;
					break;
				case "star_4":
					select_star = 4;
					break;
				case "star_5":
					select_star = 5;
					break;
				}
				$(".starItem").attr("src", "img/mypage/emptyStar.png");
				$(".starItem").each(
						function(index) {
							if (index < select_star) {
								$($(".starItem")[index]).attr("src",
										"img/mypage/fullStar.png");
							}

						});
			});
}
function registPopupHandlerRegist(){
	$(document).on("click",".regist",function(e){
		$("#registPopup").popup("open");
		orderSeq = $(e.target).parent().attr("data-order_seq");
		productId = $(e.target).parent().attr("data-product_id");
	});
}

$(document).on("click","#cancelBtn",function(e){
	$("#registPopup").popup("close");
});

$(document).on("click","#writeBtn",function(e){
	comment =  $("#evaluation").val();
	$.ajax({
		  url: '/ifit/Users/registReview.ap',
		  type:"POST",
		  dataType: "json",
		  data: {productId:productId,orderSeq:orderSeq,score:select_star,comment:comment},
		  success: function(obj){
			  if(obj.result == 'success'){
				  alert("성공!");
				  location = 'orderTracking.html';
			  }else{
				  alert("실패, comment를 길게작성해주는예외처리해야하는데 아직안했다..");
			  }
		  }
		});
});

starEventhandlerRegist();
registPopupHandlerRegist();

function addCurrencyMark(price){
	return "￦"+price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
$(document).ready(function() {
	$(".priceInfo").each(function(){
		var curPrice =$(this).html();
		$(this).html(addCurrencyMark(curPrice));
	});
});
