<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript">
$(document).ready(function() {
	$( "#generalProduct_admin_id" ).autocomplete({
		minLength: 1,
		source: function( request, response ) {
			var data = {
					"dataKind":"shopList",
					"id":$("#generalProduct_admin_id").val()
			};
			$.ajax({
				url: "/ajaxGetData.ifit",
				type: "post",
				data: {"data":JSON.stringify(data)},
				dataType: "text",
				success: function( result ) {
					var jsonObj = JSON.parse(result);
					response( jsonObj );
				}
			});
		},
		select: function( event, ui ) {
			$("#generalProduct_admin_name").html(ui.item.name);
			$("#generalProduct_admin_seq").val(ui.item.seq);
			return false;
		}
	}).autocomplete( "instance" )._renderItem = function( ul, item ) {
		return $( "<li>" ).append( "<a>" + item.id + " - " + item.name + "</a>" ).appendTo( ul );
	};
	
	// 상품 메인 이미지
	$('#generalProduct_mainImage').filer({
	    limit: 1,
	    maxSize: 10,
	    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
	    showThumbs: true,
	    templates: FilerTemplate.edit,
	    addMore: true
	});
	
	// 상품 이미지(상단)
	$('#generalProduct_topImage').filer({
		limit: 5,
	    maxSize: 10,
	    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
	    showThumbs: true,
	    templates: FilerTemplate.edit,
	    addMore: true
	    /*
	    files: [
	        {
	            name: "appended_file.jpg",
	            size: 5453,
	            type: "image/jpg",
	            file: "http://dummyimage.com/720x480/f9f9f9/191a1a.jpg"
	        },
	        {
	            name: "appended_file_2.jpg",
	            size: 9453,
	            type: "image/jpg",
	            file: "http://dummyimage.com/640x480/f9f9f9/191a1a.jpg"
	        }
	    ]
	*/
	});
	
	// 상품 상세 이미지
	$('#generalProduct_detailImage').filer({
	    limit: 1,
	    maxSize: 10,
	    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
	    showThumbs: true,
	    templates: FilerTemplate.edit,
	    addMore: true
	});
	
	// 상품 코디 이미지
	$('#generalProduct_codiImage').filer({
	    limit: 1,
	    maxSize: 10,
	    extensions: ['jpeg', 'jpg', 'gif', 'bmp', 'png'],
	    showThumbs: true,
	    templates: FilerTemplate.edit,
	    addMore: true
	});
	
	$(document).on("click",".addSizeInput",function(e){
		var appendObj = $(this).parents("span");
		var dataIdx = parseInt(appendObj.find("input").attr("data-idx")) + 1;
		appendObj.after($(".sizeArea").first().clone().wrapAll("<span/>").parent().html());
		$(this).hide();
		$('.sizeArea').last().find("input").attr("id", "generalProduct_size"+dataIdx);
		$('.sizeArea').last().find("input").attr("data-idx", dataIdx);
		if($('.sizeArea').size()<10){
			$('.sizeArea').last().find("i").show();
		}
		$('.sizeArea').last().find("i").after('<i class="removeSizeInput fa fa-times-circle ml10" aria-hidden="true"></i>');
	});
	
	$(document).on("click",".removeSizeInput",function(e){
		$(this).parents("span").remove();
		$('.sizeArea').last().find("i").show();
	});
});
</script>
<div class="layer layer-generalProductWrite" data-close-answer="true" >
	<div class="bg"></div>
	<div id="popLayer" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<p id="pop-title" class="pop-title mb20 pb10">일반상품 등록</p>
				<form name="generalProductWriteForm" id="generalProductWriteForm" method="post" action="<s:url namespace="/product" action="generalProductWriteAction"/>" data-confirm-msg="상품을 등록하시겠습니까?" enctype="multipart/form-data">
					<div class="pl20 pr20">
						<s:if test = "#session.isAdmin">
							<div class="mb25">
								<p class="dib mr15 fl">업체명</p>
								<p class="dib ml57">
									<span class="dib pl5 validate" id="generalProduct_admin_name" data-default="업체를 검색해 주세요.">업체를 검색해 주세요.</span>
									<input type="hidden" id="generalProduct_admin_seq" class="validate" name="generalProduct_admin_seq" value="" />
									<input type="text" id="generalProduct_admin_id" class="validate" name="generalProduct_admin_id" autocomplete="off" value="" placeholder="업체 아이디 검색" />
								</p>
							</div>
						</s:if>
						<s:else>
							<input type="hidden" id="generalProduct_admin_seq" class="validate" name="generalProduct_admin_seq" value="<s:property value="#session.admin_seq" />" />
						</s:else>
						<div class="mb25">
							<p class="dib mr15 fl">상품명</p>
							<p class="dib ml57">
								<input type="text" id="generalProduct_name" class="validate" name="generalProduct_name" autocomplete="off" value="${generalProduct_name}" />
							</p>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl">가격</p>
							<p class="dib ml70">
								<input type="text" id="generalProduct_price" class="validate" name="generalProduct_price" autocomplete="off" value="" />
							</p>
						</div>
						<div class="mb25 color">
							<p class="dib mr15 fl">색상</p>
							<p class="dib ml70">
								<input type="text" id="generalProduct_color" class="validate" name="generalProduct_color" autocomplete="off" value="#000000"  readonly="readonly" />
							</p>
							<div class="ml50 dib" id="colorpicker"></div>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl">사이즈</p>
							<p class="dib ml55">
								<span class="sizeArea db mb10"><input type="text" class="validate" id="generalProduct_size1" name="generalProduct_size" data-idx="1" /><i class="addSizeInput fa fa-plus-circle ml10" aria-hidden="true"></i></span>
							</p>
						</div>
						<div class="mb25" id="mainImageArea" tabIndex="1">
							<p class="dib mr15 fl">메인이미지</p>
							<p class="dib ml28 fileArea">
								<input type="file" id="generalProduct_mainImage" class="validate generalProduct_mainImage" name="generalProduct_mainImage" autocomplete="off" multiple="multiple" />
							</p>
						</div>
						<div class="mb25" id="topImageArea" tabIndex="2">
							<p class="dib mr15 fl">상품이미지</p>
							<p class="dib ml28 fileArea">
								<input type="file" id="generalProduct_topImage" class="validate generalProduct_topImage" name="generalProduct_topImage" autocomplete="off" multiple="multiple" />
							</p>
						</div>
						<div class="mb25" id="detailImageArea" tabIndex="3">
							<p class="dib mr15 fl">상세정보이미지</p>
							<p class="dib fileArea">
								<input type="file" id="generalProduct_detailImage" class="validate generalProduct_detailImage" name="generalProduct_detailImage" autocomplete="off" multiple="multiple" />
							</p>
						</div>
						<div class="mb25" id="codiImageArea" tabIndex="4">
							<p class="dib mr15 fl">코디이미지</p>
							<p class="dib ml28 fileArea">
								<input type="file" id="generalProduct_codiImage" class="validate generalProduct_codiImage" name="generalProduct_codiImage" autocomplete="off" multiple="multiple" />
							</p>
						</div>
						<div class="mb25">
							<p class="dib mr15 fl">상세정보설명</p>
							<p class="dib ml14">
								<textarea id="generalProduct_detailExplain" name="generalProduct_detailExplain" class="validate">${generalProduct_detailExplain}</textarea>
							</p>
						</div>
					</div>
					<div class="tc mt10">
						<input type="submit" id="writeBtn" class="submitBtn" value="등록" />
					</div>
				</form>
				<div class="btn-r">
					<i class="layerClose fa fa-times fa-2x" aria-hidden="true" title="닫기"></i>
				</div>
			</div>
		</div>
	</div>
</div>