<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css" />
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>

<!--  Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/updateUserInfo.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">

<script type="text/javascript" src="js/common/common.js"></script>
<script src="js/bootstrap.min.js"></script>
<!--  <script src="js/updateUserInfo.js"></script>-->
<script src="js/common/backHeader.js"></script>
<script src="js/deviceRender.js"></script>
</head>
<script type="text/javascript">
function updateRequest(){
	var input_pw= $("#input_pw").val();
	var input_pw_re = $("#input_pw_re").val();
	var tel1=$("#tel1").val();
	var tel2=$("#tel2").val();
	var tel3=$("#tel3").val();
	var input_email = $("#input_email").val();
	var changePw = 0;
	if(input_pw_re!=''){
		if(input_pw != input_pw_re){
			alert("변경하신 비밀번호가 일치하지 않습니다.");
			return;
		}
		changePw = 1;
	}
	showLoading();
	$.ajax({
		  url: '/ifit/Users/updateInfo.ap',
		  type:"POST",
		  dataType: "json",
		  data: {userPw:input_pw, tel1:tel1, tel2:tel2, tel3:tel3, email:input_email,changePw : changePw},
		  success: function(obj){
			  if(obj.result=="fail"){
				  alert("시간초과");
			  }
			  location='index.html#myPage';
		  }
	});
	
}
$(function() {
	var result = '${msg}';
	if(result=='noUser'){
		alert("로그인 후 이용하세요.");
		location = 'index.html#myPage';
	}else if(result =='fail'){
		alert("비밀번호가 일치하지 않습니다.");
		location = 'index.html#myPage';
	}
});
</script>
<body>
	<div data-role="page" id="updateUserInfoPage" class="eachPage render" data-render="padding-left,padding-right,padding-top">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" id="backheader" class="render" data-render="height" data-render-ratio="height">
			<span id="backBtn" data-rel="back" class="render" data-render="width,height,left,background-size" data-render-ratio="height"></span>
			<span id="pageName" class="font-size-16 render" data-render="line-height,font-size" data-render-ratio="height">회원정보 수정</span>
			<span class="headerMargin render" data-render="height,border-top-width" data-render-ratio="height"></span>
			<div id="loadingDiv">
				<img src="img/ajax-loader.gif">
			</div>
		</div>
		
		<form class="render" data-render="margin-top,padding-bottom">
			<div id="input_box" class="render" data-render="padding-left,padding-right">
				<label class="render" data-render="font-size,margin-left">아이디</label>
				<div class="readOnlyDiv font-size-11 render" data-render="height,font-size,margin-bottom,line-height">${curUser.userId }</div>
				<label class="render" data-render="font-size,margin-left">패스워드</label>
				<input type="password" id="input_pw" class="font-size-11 render" data-render="height,font-size,margin-bottom" placeholder="비밀번호 변경시에만 입력"/>
				<label class="render" data-render="font-size,margin-left">패스워드 확인</label>
				<input type="password" id="input_pw_re" class="font-size-11 render" data-render="height,font-size,margin-bottom" placeholder="비밀번호 변경시에만 입력"/>
				<label class="render" data-render="font-size,margin-left">핸드폰번호</label>
				<input type="number" id="tel1" name="phoneNumber" class="font-size-11 render" data-render="height,font-size,margin-bottom" value="${curUser.tel1 }" placeholder="핸드폰 번호 입력"/>
				<input type="number" id="tel2" name="phoneNumber" class="font-size-11 render" data-render="height,font-size,margin-bottom" value="${curUser.tel2 }" placeholder="핸드폰 번호 입력"/>
				<input type="number" id="tel3" name="phoneNumber" class="font-size-11 render" data-render="height,font-size,margin-bottom" value="${curUser.tel3 }" placeholder="핸드폰 번호 입력"/>
				<label class="render" data-render="font-size,margin-left">이메일</label>
				<input type="text" id="input_email" class="font-size-11 render" data-render="height,font-size,margin-bottom" value="${curUser.email }" placeholder="이메일 입력"/>
				<label class="render" data-render="font-size,margin-left" style="font-size: 11px;"># ID/PW 찾기 및 주문정보가 발송되는 이메일이므로 정확한 이메일을 입력해주세요.</label>
			</div>
		</form>
		
		<div id="updateBtn" class="font-size-13 mb20 regist render" data-render="width,height,font-size,margin-bottom">
			<div class="dib fr render" data-render="height,line-height" onclick="updateRequest()">확인</div>
		</div>
		
	</div>	
</body>
</html>