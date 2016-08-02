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
	saveScroll();
	window.open("loginPage.html", '_self'); 
});