$(function(){
	$("#loginBtn").click(function(){
		$("#adminLoginForm").submit();
	});
	$("#logoutBtn").click(function(){
		$(location).attr("href","/");
	});
	$("#productWriteBtn").click(function(){
		$(location).attr("href","/product/productWrite.html");
	});
});