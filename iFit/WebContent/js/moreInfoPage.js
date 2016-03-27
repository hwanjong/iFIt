$(document).ready(function(e){
	var jssor_1_SlideshowTransitions = [{$Duration:1200,$Opacity:2}];
	                                  
	var jssor_1_options = {
		$AutoPlay: true,
		$SlideshowOptions: {
			$Class: $JssorSlideshowRunner$,
			$Transitions: jssor_1_SlideshowTransitions,
			$TransitionsOrder: 1
		},
		$ArrowNavigatorOptions: {
			$Class: $JssorArrowNavigator$
		},
		$BulletNavigatorOptions: {
			$Class: $JssorBulletNavigator$
		}
	};
	
	var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);
	
	//responsive code begin
	//you can remove responsive code if you don't want the slider scales while window resizing
	function ScaleSlider() {
		var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
		if (refSize) {
			refSize = Math.min(refSize, 600);
			jssor_1_slider.$ScaleWidth(refSize);
		}else {
			window.setTimeout(ScaleSlider, 30);
		}
	}
	ScaleSlider();
	$(window).bind("load", ScaleSlider);
	$(window).bind("resize", ScaleSlider);
	$(window).bind("orientationchange", ScaleSlider);
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
				//$("#myShoppingCart").css("width","50%");
				//$("#myPurchase").css("width","50%");
				//$("#myShoppingCart").html('<img src="img/moreInfoPage/shoppingCart.png">'+"장바구니");
				$("#myShoppingCart2").addClass("hide");
				$("#myShoppingCart").removeClass("hide");
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
	if(event.target.tagName !="DIV") return;
	event.stopPropagation();
	console.log("enter select SelectOption");
	try{
		isWhileEventHandle = true;
		if(!animateSyncFlag){
			animateSyncFlag=true;
			var target = event.target.id;
			
			
			if(target == "myShoppingCart"){
				handlerType = 0;
				$("#myPurchase").css("width","0%");
				$("#myShoppingCart").addClass("hide");
				$("#myShoppingCart2").removeClass("hide");
				$("#myShoppingCart").bind("click",registItem);
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





//16.03.20추가 작업

$(function(){
	$("#selectSize li").click(function(){
		$("#selectSize li").each(function(){
			$(this).removeClass("btnOn");
		});
		$(this).addClass("btnOn");
	});
})