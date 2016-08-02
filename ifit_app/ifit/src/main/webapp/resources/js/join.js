$(document).on("click","#joinBtn",function(e){
	//saveScroll();
	var userId = $("#input_id").val();
	var tel1=$("#tel1").val();
	var tel2=$("#tel2").val();
	var tel3=$("#tel3").val();
	var input_captcha = $("#input_captcha").val();
	var userPw = $("#input_pw").val();
	var userPwRe = $("#input_pw_re").val();
	var email = $("#email").val();
	
	if($('.btnOn').html()!=''){
		alert("이용약관에 동의해주세요.");
		return;
	}
	if(input_captcha ==''){
		alert("보안문자를 정확히 입력해주세요.");
		return;
	}
	if(userId == '' || tel1== '' ||  tel2== '' ||  tel3== '' || userPw == '' || userPwRe =='' ){
		alert("모든 정보를 입력해주세요.");
		return;
	}
	
	if(userPw != userPwRe){
		alert("비밀정보가 일치히지 않습니다.");
		$("#input_pw").focus();
		return;
	}
	if(phoneSuccess==false){
		alert("핸드폰 번호를 인증해주세요.")
		return;
	}
	showLoading();
	$.ajax({
		  url: '/ifit/Users/joinRequest',
		  type:"POST",
		  dataType: "json",
		  data: {userId:userId, userPw:userPw, tel1:tel1,tel2:tel2,tel3:tel3,email:email},
		  success: function(obj){
			  hideLoading();
			  if(obj.result == 'success'){
				  location = 'index.html';
			  }else{
				  alert(obj.result);
			  }
			  
		  }
	});
//	
//	alert("회원가입이 완료되었습니다.");
//	window.open("index.html", '_self');
});

$(function(){
	$(".agreeCheckBtn").parent("div").click(function(){
		if($(".agreeCheckBtn").hasClass("btnOn") === true){
			$(".agreeCheckBtn").removeClass("btnOn");
		}else{
			$(".agreeCheckBtn").addClass("btnOn");
		}
	});
});
var timeLoading = true;
var phoneSuccess = false;
function smsAccess(){
	if(timeLoading==false){
		alert("요청 후 30초가 경과하지 않았습니다.\n잠시 후 요청하세요.");
		return;
	}
	var tel1=$("#tel1").val();
	var tel2=$("#tel2").val();
	var tel3=$("#tel3").val();
	
	if(tel1== '' ||  tel2== '' ||  tel3== '' ){
		alert("핸드폰번호를 입력해주세요");
		return;
	}
	timeLoading=false;
	var phoneNumStr = tel1+'-'+tel2+'-'+tel3;
	setTimeout(function() {
		timeLoading=true;
	}, 30000);
	showLoading();
	$.ajax({
		  url: '/ifit/phoneConfirm',
		  type:"POST",
		  dataType: "json",
		  data: {phoneNumber:phoneNumStr},
		  success: function(obj){
			  hideLoading();
			  alert(phoneNumStr+"로 인증번호가 발송되었습니다.");
		  }
	});
	
}

function smsConfirm(){
	var confirmNum = $("#confirmNum").val();
	if(confirmNum==''){
		alert("인증번호를 입력해주세요");
		return;
	}
	var tel1=$("#tel1").val();
	var tel2=$("#tel2").val();
	var tel3=$("#tel3").val();
	
	if(tel1== '' ||  tel2== '' ||  tel3== '' ){
		alert("핸드폰번호를 입력해주세요");
		return;
	}
	var phoneNumStr = tel1+'-'+tel2+'-'+tel3;
	showLoading();
	$.ajax({
		  url: '/ifit/codeConfirm',
		  type:"POST",
		  dataType: "json",
		  data: {phoneNumber:phoneNumStr,code:confirmNum},
		  success: function(obj){
			  hideLoading();
			  if(obj.result=="success"){
				  alert("인증성공");
				  phoneSuccess=true;
			  }else{
				  alert("인증번호가 바르지 않습니다.");
			  }
		  }
	});
}