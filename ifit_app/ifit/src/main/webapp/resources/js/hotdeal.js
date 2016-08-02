function getSubPromotion(proSeq){
	var proSeq = proSeq;
	var promotionName = $("#promotions").find("#"+proSeq).html();
	$("#subPromotion").find("#promotionName").html(promotionName);
	showLoading();
	$.ajax({
		  url: '/ifit/getSubPromotion',
		  type:"POST",
		  dataType: "json",
		  data: {proSeq:proSeq},
		  success: function(obj){
			  $("#subPromotionBox").html('');
			  var productList = obj.productList;
			  for(var i in productList){
				  var htmlCode = '<div class="mainpage_productDiv" onclick="getMoreInfo('+productList[i].productId+')">';
				  htmlCode += '<div class="mainpage_imgDiv">';
				  if(productList[i].catRef!=null)
					  	htmlCode+= '<div class="fitLogo"></div>';
				  htmlCode += '<img src="http://'+productList[i].productMainURL+'"></div><div class="mainpage_infoDiv"><p class="right">'+productList[i].productName+'</p><p class="price clear right">&#8361 '+productList[i].productPrice+'</p>';
				  htmlCode += '</div></div>';
				  $("#subPromotionBox").append(htmlCode);
			  }
			  hideLoading();
		  }
	});
	$("#subPromotion").show();
}
function closeSubPromotion(){
	$("#subPromotion").hide();
	//$("#subPromotionBox").html('');
}