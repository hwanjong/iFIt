
$(document).on("click","#cancelBtn",function(e){
	$("#registPopup").popup("close");
});

$(document).on("click","#writeBtn",function(e){
	var title = $("#questionTitle").val();
	var content = $("#questionContent").val();
	showLoading();
	$.ajax({
		  url: '/ifit/Users/registQuestion.ap',
		  dataType: "json",
		  type:"POST",
		  data: {title:title,content:content},
		  success: function(obj){
			  if(obj.result=='noUser'){
				  alert("로그인후 이용하세요");
				  location = 'index.html#myPage';
				  return;
			  }
			  hideLoading();
			  window.location.reload(true);
		  }
	});
	
	
	$("#registPopup").popup("close");
});