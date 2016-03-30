$(document).on("click","#requestOrder",function(e){
	saveScroll();
	window.open("orderTracking.html", '_self'); 
});
$(document).on("click","#requestManyQnA",function(e){
	saveScroll();
	window.open("manyQuestion.html", '_self'); 
});
$(document).on("click","#requestOneByOne",function(e){
	saveScroll();
	window.open("oneByoneQnA.html", '_self'); 
});
$(document).on("click","#requestUsingApp",function(e){
	saveScroll();
	alert("이용안내 준비중"); 
});
$(document).on("click","#loginBtn",function(e){
	$(this).hide();
	$(this).siblings().hide();
	$(this).siblings("p#loginLabel2").show();
	$("#userImage").show();
});
$(document).on("click","#logoutBtn",function(e){
	$("#loginBtn").show();
	$("#loginBtn").siblings().show();
	$("#loginLabel2").hide();
	$("#userImage").hide();
});