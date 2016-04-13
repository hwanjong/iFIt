<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<title>iFit 관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="/jsp/common/plugin/jquery/jquery-ui-1.11.2.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="/jsp/common/plugin/font-awesome-4.5.0/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/jsp/common/css/general.css" />
<script type="text/javascript" src='/jsp/common/plugin/jquery/jquery-1.11.1.min.js'></script>
<script type="text/javascript" src="/jsp/common/plugin/jquery/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src='/jsp/common/js/admin.js'></script>
<script type="text/javascript">
	<!--
	window.onload = function(){
		var validateMsgMap = {
			res : "${validateMsgMap.res}",
			formID : "${validateMsgMap.formID}",
			msg : "${validateMsgMap.msg}"
		};
		if(validateMsgMap.res == "false"){
			alert(validateMsgMap.msg);
			$("#"+validateMsgMap.formID).focus();
		}
	}
	//-->
</script>
<%
String pageName = request.getParameter("pageName")==null || request.getParameter("pageName").equals("") ? "error" : request.getParameter("pageName");

//	게시판 글작성
if(pageName.equals("hireWrite")){
%>
<!--<script type="text/javascript" src="/jsp/js/address_search.js"></script>-->
<%
}
%>
