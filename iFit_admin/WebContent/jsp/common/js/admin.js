$(function(){
	$(".adminGnbArea .logo").click(function(){
		$(location).attr("href","/index.ifit");
	});
	
	$('.number').trigger('keyup');
	
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
	
	$(".editBtn").click(function(){
		var queryIncode = $(this).parents("form").find("#queryIncode").val();
		
		$(location).attr("href",$(this).parents("form").attr("id")+"Editor.ifit?queryIncode=" + queryIncode + "&isUpdateMode=" + true + "&seq=" + $(this).attr("data-seq"));
	});
	
	$(".deleteBtn").click(function(){
		var seq = $(this).attr("data-seq");
		var	 title = $(this).attr("data-title");
		if(confirm("[" + title + "] 항목을 삭제하시겠습니까?")){
			$(location).attr("href",$(this).parents("form").attr("id")+"DeleteAction.ifit?seq="+seq);
		}
	});
	
	$(".listBtn").click(function(){
		var queryDecode = $(this).parents("form").find("#queryDecode").val();
		$(location).attr("href",$(this).parents("form").attr("id")+"List.ifit?" + queryDecode);
	});
	
	$(".writeActionBtn").click(function(){
		if(validateCheck($(this).parents("form"))){
			if(confirm($(this).parents("form").attr("data-confirm-msg"))){
				return true;
			}
		}
		return false;
	});
	
	$(".updateActionBtn").click(function(){
		if(validateCheck($(this).parents("form"))){
			if(confirm($(this).parents("form").attr("data-confirm-msg"))){
				return true;
			}
		}
		return false;
	});

});

//숫자 입력시
$(document).on("keyup",".number",function(e){
	$(this).val($(this).val().replace(/[^0-9]/gi,""));		// 숫자만 입력
	if($(this).val() > 1000000000){
		$(this).val("1000000000");
	}
	$(this).val($(this).val().replace(/(^0+)/,""));		// 앞의 0제거
	$(this).val($(this).val().replace(/\B(?=(\d{3})+(?!\d))/g, ","));	// 3자리마다 콤마 
});

$(document).on("click",".paging ul li a.btnOff",function(e){
	e.preventDefault();
	var pageNum = $(this).attr("id");
	pageNum = pageNum.replace("page_","");
	$(this).parents("form").find("#pageNum").val(pageNum);
	$(this).parents("form").submit();
});

function getAjaxData(data){
	console.log(data);
	var rtnData = "";
//	$("body").waitMe({
//		effect : 'bounce',
//		text : '데이터 처리중 입니다. 잠시만 기다려 주세요.',
//		bg : 'rgba(255,255,255,0.5)',
//		color : '#000'
//	});
	$.ajax({
		url: data.url,
		type: "post",
		data: {"data":JSON.stringify(data)},
		dataType:"text",
		async: false,
		success:function(result){
			console.log(result);
			rtnData = result;
		},
		error: function(xhr,status, error){
			alert("에러발생");
		}
	});
//	$("body").waitMe('hide');
	return rtnData;
}

function validateCheck(obj){
	var rtn = false;
	var data = {"formID":obj.attr("id")+obj.attr("data-mode")};
	
	obj.find("input[name!='']").each(function(){
		if($(this).attr("type")=="file"){
			data[$(this).attr("name")] = $(this)[0].jFiler.files_list.length;
		}else if($(this).attr("type")=="radio"){
			data[$(this).attr("name")] = $(':radio[name="banner_type"]:checked').val();
		}else{
			if($(this).attr("name") in data && $.isArray(data[$(this).attr("name")])){
				data[$(this).attr("name")].push($(this).val());
			}else{
				data[$(this).attr("name")] = data[$(this).attr("name")] = $(this).hasClass("arrayData") ?  [$(this).val()] : $(this).val();
			}
		}
	});
	obj.find("select[name!='']").each(function(){
		data[$(this).attr("name")] = $(this).val();
	});
	
	data.url = "/ajaxFormValidate.ifit";
	var jsonObj = JSON.parse(getAjaxData(data));
	if(!jsonObj.res){
		alert(jsonObj.msg);
		$("#"+jsonObj.elementID).focus();
	}else{
		rtn = true;
	}
	
	return rtn;
}