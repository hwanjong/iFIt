$(document).on("click","#requestOrder",function(e){
	saveScroll();
	window.open("orderTracking.html", '_self');
	hideLoading();
});
$(document).on("click","#requestManyQnA",function(e){
	saveScroll();
	showLoading();
	window.open("manyQuestion.html", '_self');
	hideLoading();
});
$(document).on("click","#requestOneByOne",function(e){
	saveScroll();
	showLoading();
	window.open("oneByoneQnA.html", '_self');
	hideLoading();
});
$(document).on("click","#requestUsingApp",function(e){
	$("#useInfo").show();
});
$(document).on("click touchstart","#joinBtn",function(e){
	saveScroll();
	window.open("join.html", '_self');
	hideLoading();
});
$(document).on("click","#loginBtn",function(e){
	var userId= $("#input_id").val();
	var userPw = $("#input_pw").val();
	showLoading();
	$.ajax({
		  url: '/ifit/Users/loginRequest',
		  type:"POST",
		  dataType: "json",
		  data: {userId:userId, userPw:userPw},
		  success: function(obj){
			  var result = obj.result;
			  if(result=='fail'){
				  alert("로그인정보를 확인하세요.");
			  }else{
				  window.location.reload(true);
			  }
			  hideLoading();
		  }
	});
});
$(document).on("click","#logoutBtn",function(e){
	$.ajax({
		 url: '/ifit/Users/logout.ap',
		  type:"GET",
		  dataType: "json",
		  success: function(obj){
			  window.location.reload(true);
		  }
	});
});
function idSearchPopupHandlerRegist(){
	$(document).on("click touchstart","#idSearch",function(e){
		$("#idSearchPopup").popup("open");
		$("#idSearchPopup").bind({
			popupafterclose: function(event, ui) {
				$("#idSearchTitle").val("");
			}
		});
	});
}
function pwSearchPopupHandlerRegist(){
	$(document).on("click touchstart","#pwSearch",function(e){
		$("#pwSearchPopup").popup("open");
		$("#pwSearchPopup").bind({
			popupafterclose: function(event, ui) {
				$("#findId_id").val("");
				$("#findId_email").val("");
			}
		});
	});
}
function updateUserInfoPopupHandlerRegist(){
	$(document).on("click","#updateUserInfo",function(e){
		$("#updateUserInfoPopup").popup("open");
		$("#updateUserInfoPopup").bind({
			popupafterclose: function(event, ui) {
				$("#updateUserInfoTitle").val("");
			}
		});
	});
}
function updateRequest(){
	var inputPw = $("#updateUserInfoTitle").val();
	var f = $('<form method="post" action="/ifit/pageView/updateUserInfo.html"></form>');
	f.html('<input type="hidden" name="inputPw" value="'+inputPw+'" />');
	f.submit();
}
function findPwRequest(){
	var inputId = $("#findId_id").val();
	var inputEmail = $("#findId_email").val();;
	$("#pwSearchPopup").popup("close");
	showLoading();
	$.ajax({
		  url: '/ifit/Users/findPw',
		  type:"POST",
		  dataType: "json",
		  data: {userId:inputId, email:inputEmail},
		  success: function(obj){
			  if(obj.result == "success"){
				  alert("임시비밀번호가 가입하신 메일로 발급되었습니다.");
				  
			  }else{
				  alert("일치하는 회원정보가 없습니다.");
			  }
			  hideLoading();
		  }
	});
}


//$(document).on("click","#updateUserInfoConfirm",function(e){
//	$("#updateUserInfoPopup").popup("close");
////	saveScroll();
//	window.open("updateUserInfo.html", '_self'); 
//});
var curImgNumber =1 ;
function closeUseInfo(){
	curImgNumber =1;
	$("#use1").show();
	$("#useInfo").hide();
	
}
function useInfoLeft(){
	if(curImgNumber!=1){
		curImgNumber--;
	}
	var targetId = 'use'+curImgNumber;
	$("#useInfoImgDiv").find("img").hide();
	$('#'+targetId).show();
	
}
function useInfoRight(){
	if(curImgNumber!=5){
		curImgNumber++;
	}
	var targetId = 'use'+curImgNumber;
	$("#useInfoImgDiv").find("img").hide();
	$('#'+targetId).show();
	
}
idSearchPopupHandlerRegist();
pwSearchPopupHandlerRegist();
updateUserInfoPopupHandlerRegist();