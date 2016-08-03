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
<link href="css/oneByoneQnA.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">

<script src="js/bootstrap.min.js"></script>
<script src="js/oneByoneQnA.js"></script>
<script src="js/common/backHeader.js"></script>
<script src="js/common/common.js"></script>
<script src="js/deviceRender.js"></script>
<script type="text/javascript">
$(document).on("click",".regist",function(e){
	if('${user}'==''){
		alert("로그인 후 이용하세요.");
		location = 'index.html#myPage';
		return;
	}
	$("#registPopup").popup("open");
});
</script>
</head>
<body>
	<div data-role="page" id="oneByoneQna" class="eachPage render" data-render="padding-left,padding-right,padding-top">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" id="backheader" class="render" data-render="height" data-render-ratio="height">
			<span id="backBtn" data-rel="back" class="render" data-render="width,height,left,background-size" data-render-ratio="height"></span>
			<span id="pageName" class="font-size-16 render" data-render="line-height,font-size" data-render-ratio="height">1:1 문의</span>
			<span class="headerMargin render" data-render="height,border-top-width" data-render-ratio="height"></span>
			<div id="loadingDiv">
				<img src="img/ajax-loader.gif">
			</div>
		</div>
		<div class="panel-group render" id="accordion" data-render="padding-bottom">
		<c:forEach var="question" items="${questionList}">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title font-bold font-size-13 render" data-render="font-size,line-height">
						<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#${question.questSeq}">
							${question.title }
							<span class="ml10 font-regular font-size-11 render" data-render="margin-left,font-size">${question.questDate}</span>
							<c:if test="${question.state == 2}">
							<span class="ml10 font-regular font-size-11 render" data-render="margin-left,font-size">(완료)</span>
							</c:if>
							<i class="indicator glyphicon glyphicon-menu-right pull-right render" data-render="line-height"></i>
						</a>
					</h4>
				</div>
				
				<div id="${question.questSeq }" class="panel-collapse collapse">
					<div class="panel-body font-size-13 font-demilight render" data-render="font-size,width,padding-top,padding-bottom,padding-left,padding-right">${question.content}</div>
					<c:if test="${question.state == 2}">
					<div class="panel-body answer font-size-13 font-demilight render" data-render="font-size,width,padding-top,padding-bottom">
						<div class="font-bold">문의에 답변드립니다.(관리자)<span class="ml10 font-regular font-size-11 render" data-render="margin-left,font-size">${question.replyDate}</span></div>
						<div class="answer_content render" data-render="padding-top,padding-left,padding-right">${question.reply}</div>
					</div>
					</c:if>
				</div>
				
			</div>
		</c:forEach>
		</div>
		<div class="questionBtn font-size-13 mb20 regist render" data-render="width,height,font-size,margin-bottom">
			<div class="dib fr render" data-render="height,line-height">문의하기</div>
		</div>
		<div data-role="popup" id="registPopup" data-history="false" data-overlay-theme="d" class="font-size-13 render" data-render="font-size">
			<div data-role="content">
				<div id="popupHead" class="font-size-16 render mb10" data-render="margin-bottom,font-size">
					1:1 문의
				</div>
				<div id="popupBody" class="mb10 render" data-render="margin-bottom">
					<div id="questionWrap" class="render" data-render="height,width,line-height,padding-left,padding-right">
						<input id="questionTitle" class="render" data-render="width,height,padding-left,padding-right,font-size" data-role="none" type="text" placeholder="제목을 입력 해 주세요(200자)">
					</div>
					<input id="questionContent" class="render" data-render="width,height,padding-left,padding-right,font-size" data-role="none" type="text" placeholder="내용을 입력 해 주세요(200자)">
				</div>
				<div id="pupupFoot" class="render" data-render="width,height" >
					<div id="cancelBtn" class="dib fl render" data-render="height,line-height">취소</div>
					<div id="writeBtn" class="dib fr render" data-render="height,line-height">완료</div>
				</div>				
			</div>
		</div>
	</div>	
	<script>
		function toggleChevron(e) {
			$(e.target).prev('.panel-heading').find("i.indicator").toggleClass(
					'glyphicon-menu-down glyphicon-menu-right');
		}
		$('#accordion').on('hidden.bs.collapse', toggleChevron);
		$('#accordion').on('shown.bs.collapse', toggleChevron);
	</script>
</body>
</html>