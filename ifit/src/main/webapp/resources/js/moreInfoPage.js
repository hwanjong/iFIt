
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
	var i = parseInt($("#countInput").val()==""?0:$("#countInput").val());
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
		if(animateSyncFlag){
			animateSyncFlag=false;
			var target = event.target.id;
			
			if(handlerType == 0){
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
var realSize="";
function selectOption(event){
	if(isWhileEventHandle) return;
	if(event.target.tagName !="DIV") return;
	event.stopPropagation();
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
			if(realSize==""){
				realSize = $("#optionSelectorWrap").css("height");
			}
			$("#optionSelectorWrap").css({"display":"block", "height":"0"});
			$("#optionSlideControl").css("display","block");
			$("#optionSelectorWrap").animate({height:realSize},{duration:"slow",complete:
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

/**
 * 
 * @param checkColor
 * @param checkSize
 * @param checkCount
 * @param modeType :장바구니로 이동과 구매하기를 ModeType으로 구별하여 다른테이블에 Insert함.
 */
function purchaseRequest(checkColor,checkSize,checkCount,modeType,payUserName,deliveryAddress,deliveryAddressDetail){
	var pId = $("#productId").val();
	var adminSeq = $("#adminSeq").val();
	$.ajax({
		  url: '/ifit/Users/purchaseRequest',
		  type:"POST",
		  dataType: "json",
		  data: {color:checkColor,size:checkSize,amount:checkCount,productId:pId,adminSeq:adminSeq,modeType:modeType,
			  payUserName:payUserName,deliveryAddress:deliveryAddress,deliveryAddressDetail:deliveryAddressDetail},
		  success: function(obj){
			  if(obj.result=='fail'){
				  alert("시간초과");
				  location ='index.html#myPage';
			  }else if(obj.result=='Success_cart'){
				  if(confirm("장바구니에 담았습니다. 장바구니 페이지로 이동하시겠습니까?")==true){
					  location = 'index.html#cartPage';
				  }
			  }else if(obj.result=='Success_order'){
				  if(confirm("주문이 성공적으로 접수되었습니다. 주문조회 페이지로 이동하시겠습니까?")==true){
					  location = 'orderTracking.html';
				  }
			  }
		  }
	});
}

function moreRepleRequestHandler(e){
	alert("댓글 더보기 요청");
}

//16.03.20추가 작업
$("#selectSize li").click(function(){
	$("#selectSize li").each(function(){
		$(this).removeClass("btnOn");
	});
	$(this).addClass("btnOn");
});
