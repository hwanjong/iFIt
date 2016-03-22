$(document).ready(function(){
	var design_width = 375;
	var design_height = 667;
	
	var device_width = $(window).width();
	var device_height = $(window).height();
	
	var width_ratio = device_width / design_width;
	var height_ratio = device_height / design_height;
	
	$(".render").each(function(){
		console.log($(this));
		var renderData = $(this).attr("data-render").split(",");
		for(var i=0; i<renderData.length; i++){
			switch(renderData[i]){
//				case "width": 
//					$(this).css("width", (($(this).css("width").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
//				case "height":
//					$(this).css("height", (($(this).css("height").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "padding-top":
//					$(this).css("padding-top", (($(this).css("padding-top").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "padding-right":
//					$(this).css("padding-right", (($(this).css("padding-right").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
//				case "padding-bottom":
//					$(this).css("padding-bottom", (($(this).css("padding-bottom").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "padding-left":
//					$(this).css("padding-left", (($(this).css("padding-left").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
//				case "margin-top":
//					$(this).css("margin-top", (($(this).css("margin-top").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "margin-right":
//					$(this).css("margin-right", (($(this).css("margin-right").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
//				case "margin-bottom":
//					$(this).css("margin-bottom", (($(this).css("margin-bottom").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "margin-left":
//					$(this).css("margin-left", (($(this).css("margin-left").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
//				case "line-height":
//					$(this).css("line-height", (($(this).css("line-height").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "background-size":
//					$(this).css("background-size", (($(this).css("background-size").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "font-size":
//					$(this).css("font-size", (($(this).css("font-size").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "top":
//					$(this).css("top", (($(this).css("top").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "right":
//					$(this).css("right", (($(this).css("right").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
//				case "bottom":
//					$(this).css("bottom", (($(this).css("bottom").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
//					break;
//				case "left":
//					$(this).css("left", (($(this).css("left").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
//					break;
			
			
			// width 기준으로만 조절 - 일단 test용도
				case "width": 
					$(this).css("width", (($(this).css("width").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "height":
					$(this).css("height", (($(this).css("height").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "padding-top":
					$(this).css("padding-top", (($(this).css("padding-top").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "padding-right":
					$(this).css("padding-right", (($(this).css("padding-right").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "padding-bottom":
					$(this).css("padding-bottom", (($(this).css("padding-bottom").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "padding-left":
					$(this).css("padding-left", (($(this).css("padding-left").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "margin-top":
					$(this).css("margin-top", (($(this).css("margin-top").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "margin-right":
					$(this).css("margin-right", (($(this).css("margin-right").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "margin-bottom":
					$(this).css("margin-bottom", (($(this).css("margin-bottom").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "margin-left":
					$(this).css("margin-left", (($(this).css("margin-left").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "line-height":
					$(this).css("line-height", (($(this).css("line-height").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "background-size":
					$(this).css("background-size", (($(this).css("background-size").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "font-size":
					$(this).css("font-size", (($(this).css("font-size").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "top":
					$(this).css("top", (($(this).css("top").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "right":
					$(this).css("right", (($(this).css("right").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "bottom":
					$(this).css("bottom", (($(this).css("bottom").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "left":
					$(this).css("left", (($(this).css("left").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				/***************************************************************/
					
					
				case "diagonal-width":
					$(this).css("width", (($(this).css("width").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					$(this).css("height", (($(this).css("height").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "diagonal-height":
					$(this).css("width", (($(this).css("width").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
					$(this).css("height", (($(this).css("height").replace(/[^-\d\.]/g, ''))*height_ratio)+"px");
					break;
				case "width-basic-height":
					$(this).css("height", (($(this).css("height").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "width-basic-line-height":
					$(this).css("line-height", (($(this).css("line-height").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "width-basic-margin-top":
					$(this).css("margin-top", (($(this).css("margin-top").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "width-basic-margin-bottom":
					$(this).css("margin-bottom", (($(this).css("margin-bottom").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
				case "width-basic-font-size":
					$(this).css("font-size", (($(this).css("font-size").replace(/[^-\d\.]/g, ''))*width_ratio)+"px");
					break;
			}
		}
	});

});