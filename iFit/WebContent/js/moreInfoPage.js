$(document).ready(function(e){
	$(".carousel-inner>.item").on("swipeleft",function(e){ $("#myCarousel1").carousel("next");});
	$(".carousel-inner>.item").on("swiperight",function(e){ $("#myCarousel1").carousel("prev");});
});
function moreInfoClosetClickHandler(e){
	alert("옷장 이동");
}
function moreInfo3DClickHandler(e){
	alert("3d페이지 연동");
}


function likeItemRequestHandler(e){
	alert("찜 요청");
}

function shareRequestHandler(e){
	alert("공유하기 요청");
}


function minusCount(){
	var i = parseInt($("#countInput").val());
	
	if(i<=1) return;
	
	$("#countInput").val(i-1);
}

function plusCount(){
	var i = parseInt($("#countInput").val());
	$("#countInput").val(i+1);
}

var animateSyncFlag=false;
var handlerType = 0; //0 = 장바구니, 1 = 바로구매;
var isWhileEventHandle = false;



function optionSelectorWrapClickHandler(event){
	event.stopPropagation();
	isWhileEventHandle=false;
}
function registItem(){
	console.log("enter registItem");
	event.stopPropagation();
	var isCorrect = true;
	$(".optionSelector>select").each(function(index){
		if($(this).val()==null){
			isCorrect = false;
		}
	});
	
	if(isCorrect){
		if (handlerType == 0) {
			alert("장바구니 담기 확정");
		} else {
			alert("구매 시퀀스");
		}
	} else{
		alert("필수 정보 누락");
	}
	
}	

function removeSelectOption(e){
	if(isWhileEventHandle) return;
	try{
		isWhileEventHandle = true;
		event.stopPropagation();
		console.log("enter remove SelectOption");
		if(animateSyncFlag){
			animateSyncFlag=false;
			var target = event.target.id;
			
			if(handlerType == 0){
				$("#myShoppingCart").css("width","50%");
				$("#myPurchase").css("width","50%");
				$("#myShoppingCart").html('<img src="img/moreInfoPage/shoppingCart.png">'+"장바구니");
			}else{
				$("#myShoppingCart").css("width","50%");
				$("#myPurchase").css("width","50%");
				$("#myPurchase").html('<img src="img/moreInfoPage/myPurchase.png">'+"바로 구매");
			}
			
			
			
			$("#optionIcon").removeClass("glyphicon-chevron-down");
			$("#optionSelectorWrap").animate({height:"0"},{duration:"slow",complete:
					function(e){
						try{
							$("#optionSelectorWrap").css({"display":"none"});
							$("#optionSlideControl").css("display","none");
							$("#optionIcon").addClass("glyphicon-chevron-up");
							$("#myShoppingCart").unbind("click",registItem);
							$("#myPurchase").unbind("click",registItem);
						}catch(e){
							console.log(e);
						}finally{
							isWhileEventHandle=false;
						}
					}
				}
			);
		}
	} catch(e){
		console.log("err");
	}
}
function selectOption(event){
	if(isWhileEventHandle) return;
	if(event.target.tagName !="SPAN") return;
	event.stopPropagation();
	console.log("enter select SelectOption");
	try{
		isWhileEventHandle = true;
		if(!animateSyncFlag){
			animateSyncFlag=true;
			var target = event.target.id;
			
			
			if(target == "myShoppingCart"){
				handlerType = 0;
				$("#myShoppingCart").css("width","100%");
				$("#myPurchase").css("width","0%");
				$("#myShoppingCart").html('<img src="img/moreInfoPage/shoppingCart.png">'+"장바구니 담기");
				$("#myShoppingCart").bind("click",registItem);
			}
			else{
				handlerType = 1;
				$("#myShoppingCart").css("width","0%");
				$("#myPurchase").css("width","100%");
				$("#myPurchase").html('<img src="img/moreInfoPage/myPurchase.png">'+"바로 구매 하기");
				$("#myPurchase").bind("click",registItem);
			}
			
			$("#optionIcon").addClass("glyphicon-chevron-up");
			$("#optionSelectorWrap").css({"display":"block", "height":"0"});
			$("#optionSlideControl").css("display","block");
			$("#optionSelectorWrap").animate({height:"+=13em"},{duration:"slow",complete:
					function(e){				
						$("#optionIcon").addClass("glyphicon-chevron-down");
						isWhileEventHandle = false;
					}
				}
			);
		}
	}catch(e){
		
	}
}


function moreRepleRequestHandler(e){
	alert("댓글 더보기 요청");
}