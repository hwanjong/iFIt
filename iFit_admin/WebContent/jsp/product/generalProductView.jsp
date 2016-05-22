<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript">
	$(document).ready(function() {
		$(".viewBtn").click(function(){
			/*
			$("#generalProduct_price").html("￦"+$("#generalProduct_price").html());
			$("#generalProduct_color").css("background-color",$("#generalProduct_color").html());
			$("#generalProduct_color").html("");
			$("#main_image").attr("src","/upload/generalProduct/"+$("#generalProduct_image").html());
			*/
		});
	});
</script>
<div class="layer layer-generalProductView" data-close-answer="false">
	<div class="bg"></div>
	<div id="popLayer" class="pop-layer generalProductViewPop">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<p id="generalProduct_name" class="pop-title mb20 pb10"></p>
				<form name="generalProductViewForm" id="generalProductViewForm" method="post">
					<div class="pl20 pr20">
						<img id="main_image" src="" />
						<div class="mb25" style="display:none;">
							<p class="dib mr15 fl">가격</p>
							<p id="generalProduct_image" class="pop-content-box dib"></p>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl">가격</p>
							<p id="generalProduct_price" class="pop-content-box dib"></p>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl" >size</p>
							<p id="generalProduct_sizeMap" class="pop-content-box dib"></p>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl" >색상</p>
							<p id="generalProduct_color" class="pop-content-box dib" style="border:0;width:20px;height:30px;"></p>
						</div>
					</div>
				</form>
				<div class="btn-r">
					<i class="layerClose fa fa-times fa-2x" aria-hidden="true" title="닫기"></i>
				</div>
			</div>
		</div>
	</div>
</div>