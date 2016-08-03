var selectedCategory = 0;
$(document).ready(function(){
	$("#categoryOption p").click(function(){
		selectedCategory =  $(this).attr("id");
		
		$("#categoryOption p").css("text-indent","0px");
		$("#categoryOption p").css("font-weight","normal");
		
		$("#categoryOption #"+selectedCategory).css("text-indent","15px");
		$("#categoryOption #"+selectedCategory).css("font-weight","bold");
		
	});
});

function optionCancel(){
	$("#categoryOption p").css("text-indent","0px");
	$("#categoryOption p").css("font-weight","normal");
	$("#detailSearch").hide();
}
