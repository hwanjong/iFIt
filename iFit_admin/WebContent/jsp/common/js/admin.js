$(function(){
	$.fn.wSelect.defaults.size = 6;
	$("select").wSelect();
	$("#loginBtn").click(function(){
		$("#loginForm").submit();
	});
	$("#logoutBtn").click(function(){
		$(location).attr("href","/logoutAction.ifit");
	});
	$(".yet").click(function(){
		alert("준비중 입니다.");
		return false;
	});
	
	$(".listSearchBtn").click(function(){
		$(this).parents("form").submit();
	});
	
	$(".listSort").click(function(){
		$(this).parents("form").find("#sortCol").val($(this).attr("data-sort-col"));
		var sortValObj = $(this).parents("form").find("#sortVal");
		sortValObj.val(sortValObj.val()=="DESC" ? "ASC" : "DESC");
		$(this).parents("form").find("#pageNum").val(1);
		$(this).parents("form").submit();
	});
	
	$("#countPerPage").change(function(){
		$(this).parents("form").submit();
	});
	
	$(".writeBtn").click(function(){
		var queryIncode = $(this).parents("form").find("#queryIncode").val();
		$(location).attr("href",$(this).parents("form").attr("id")+"Editor.ifit?queryIncode=" + queryIncode);
	});
	
	$(".deleteBtn").click(function(){
		var seq = $(this).attr("data-seq");
		var	 title = $(this).attr("data-title");
		if(confirm("[" + title + "] 항목을 삭제하시겠습니까?")){
			$(location).attr("href",$(this).parents("form").attr("id")+"DeleteAction.ifit?seq="+seq+"&pageNum=1");
		}
	});
	
	$(".listBtn").click(function(){
		var queryDecode = $(this).parents("form").find("#queryDecode").val();
		$(location).attr("href",$(this).parents("form").attr("id")+"List.ifit?" + queryDecode);
	});
	
	$(".writeActionBtn").click(function(){
//		var queryDecode = $(this).parents("form").find("#queryDecode").val();
//		$(location).attr("href",$(this).parents("form").attr("id")+"List.ifit?" + queryDecode);
		if(validateCheck($(this).parents("form"))){
			if(confirm($(this).parents("form").attr("data-confirm-msg"))){
				return true;
			}
		}
		return false;
	});
});

$(document).on("click",".paging ul li a.btnOff",function(e){
	e.preventDefault();
	var pageNum = $(this).attr("id");
	pageNum = pageNum.replace("page_","");
	$(this).parents("form").find("#pageNum").val(pageNum);
	$(this).parents("form").submit();
});

function getAjaxData(data){
	var rtnData = "";
	$.ajax({
		url: "/ajaxGetData.ifit",
		type: "post",
		data: {"data":JSON.stringify(data)},
		dataType:"text",
		async: false,
		success:function(result){
			rtnData = result;
		},
		error: function(xhr,status, error){
			alert("에러발생");
		}
	});
	return rtnData;
}

function validateCheck(obj){
	var rtn = false;
	var data = {"formID":obj.attr("id")+obj.attr("data-mode")};
	obj.find(".validate").each(function(){
		console.log($(this));
		if($(this).attr("type")=="checkbox"){
			data[$(this).attr("id")] = $(this).val();
		}else if($(this).attr("type")=="file"){
			data[$(this).attr("id")] = $("."+$(this).attr("id")).size()-1;
		}else if($(this).attr("id") == null){
			//$(this).attr("id")
		}else{
			data[$(this).attr("id")] = $(this).val();
		}
	});
	console.log(data);
	$.ajax({
		url: "/ajaxFormValidate.ifit",
		type: "post",
		data: {"data":JSON.stringify(data)},
		dataType:"text",
		async: false,
		success:function(result){
			var jsonObj = JSON.parse(result);
			if(!jsonObj.res){
				alert(jsonObj.msg);
				$("#"+jsonObj.elementID).focus();
			}else{
				rtn = true;
			}
		},
		error: function(xhr,status, error){
			alert("에러발생");
		}
	});
	return rtn;
}