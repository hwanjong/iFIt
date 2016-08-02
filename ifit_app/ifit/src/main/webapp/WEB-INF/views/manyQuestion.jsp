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
<link href="css/manyQuestion.css" rel="stylesheet">
<link href="css/backHeader.css" rel="stylesheet">

<script src="js/bootstrap.min.js"></script>
<script src="js/common/backHeader.js"></script>
<script src="js/deviceRender.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
		  url: '/ifit/getManyQuestion',
		  dataType: "json",
		  success: function(obj){
			  var faqList = obj.faqList;
			  for(var i in faqList){
				  var htmlCode = '<div class="panel panel-default"><div class="panel-heading">';
				  htmlCode+='<h4 class="panel-title font-bold font-size-13 render" data-render="font-size,line-height">';
				  htmlCode+='<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#'+i+'">';
				  htmlCode+= faqList[i].title + '<i class="indicator glyphicon glyphicon-menu-right pull-right render" data-render="line-height"></i></a></h4></div>';
				  htmlCode+='<div id="'+i+'" class="panel-collapse collapse"><div class="panel-body font-size-13 font-demilight render" data-render="font-size">';
				  htmlCode+= faqList[i].content+'</div></div></div>';
				  $("#accordion").append(htmlCode);
			  }
			  renderStart("#accordion .render");
		  }
		});
	
});
</script>

</head>
<body>
	<div data-role="page" id="manyQuestionPage" class="eachPage render" data-render="padding-left,padding-right,padding-top">
		<div data-role="header" data-position="fixed" data-tap-toggle="false" id="backheader" class="render" data-render="height" data-render-ratio="height">
			<span id="backBtn" data-rel="back" class="render" data-render="width,height,left,background-size" data-render-ratio="height"></span>
			<span id="pageName" class="font-size-16 render" data-render="line-height,font-size" data-render-ratio="height">자주하는질문</span>
			<span class="headerMargin render" data-render="height,border-top-width" data-render-ratio="height"></span>
		</div>
		<div class="panel-group" id="accordion" >
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