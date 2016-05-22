package util.config;

import java.util.HashMap;
import java.util.Map;

import util.system.StringUtil;

import lombok.Data;
import lombok.Setter;
import lombok.AccessLevel;

import action.member.ShopMember;

@Data
public class FormValidate{
	
	private AlertMessage alertMessage = new AlertMessage();
	private Map<String, Object> rtnMap = new HashMap<String, Object>();
	private StringUtil stringUtil = new StringUtil();
	private Code code = new Code();
	
	public FormValidate(){
		this.rtnMap.put("res", false);		// validation결과
		this.rtnMap.put("msg", "");			// 페이지 전달 메세지
		this.rtnMap.put("elementID", "");		// form요소 id명
	}
	
	// 첨부파일 에러
	public Map<String, Object> fileUploadError(){
		this.rtnMap.put("res", false);
		this.rtnMap.put("msg", alertMessage.getFileUploadError());	
		this.rtnMap.put("elementID", "");
		return this.rtnMap;
	}
	
	// 로그인 체크(DB값)
	public Map<String, Object> loginAuthError(){
		this.rtnMap.put("res", false);
		this.rtnMap.put("msg", alertMessage.getLoginError());	
		this.rtnMap.put("elementID", "admin_id");
		return this.rtnMap;
	}
	
	// 로그인 체크(validation)
	public Map<String, Object> loginForm(Map<String, Object> paramMap){
		if(!paramMap.containsKey("admin_id") || paramMap.get("admin_id").equals("")){
			// 아이디 체크
			this.rtnMap.put("msg", alertMessage.getLoginError());
			this.rtnMap.put("elementID", "admin_id");
		}else if(!paramMap.containsKey("admin_pw") || paramMap.get("admin_pw").equals("")){
			// 비밀번호 체크
			this.rtnMap.put("msg", alertMessage.getLoginError());
			this.rtnMap.put("elementID", "admin_pw");
		}else if(false){
			// 아이디/비밀번호 자리수 체크 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}
		
		return this.rtnMap;
	}
	
	// 입점회원 등록 체크(validation)
	public Map<String, Object> shopMemberWriteForm(Map<String, Object> paramMap){
		ShopMember shop = new ShopMember();
		if(!paramMap.containsKey("shop_id") || paramMap.get("shop_id").equals("") || !stringUtil.id_validation(paramMap.get("shop_id").toString())){
			// 업체아이디 체크
			this.rtnMap.put("msg", alertMessage.getShopIdError());
			this.rtnMap.put("elementID", "shop_id");
		}else if(shop.getData(paramMap)!=null){
			// 업체아이디 중복 체크
			this.rtnMap.put("msg", alertMessage.getShopDuplicateError());
			this.rtnMap.put("elementID", "shop_id");
		}else if(!paramMap.containsKey("shop_pw") || paramMap.get("shop_pw").equals("") || !stringUtil.pw_validation(paramMap.get("shop_pw").toString())){
			// 업체비밀번호 체크
			this.rtnMap.put("msg", alertMessage.getShopPwError());
			this.rtnMap.put("elementID", "shop_pw");
		}else if(!paramMap.containsKey("shop_name") || paramMap.get("shop_name").equals("")){
			// 업체명 체크
			this.rtnMap.put("msg", alertMessage.getShopNameError());
			this.rtnMap.put("elementID", "shop_name");
		}else if(!paramMap.containsKey("shop_tel1") || paramMap.get("shop_tel1").equals("")){
			// 업체번호 앞자리 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel1");
		}else if(!paramMap.containsKey("shop_tel2") || paramMap.get("shop_tel2").equals("")){
			// 업체번호 중간자리 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel2");
		}else if(!paramMap.containsKey("shop_tel3") || paramMap.get("shop_tel3").equals("")){
			// 업체번호 뒷자리 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel3");
		}else if(!stringUtil.mobileNumber_validation(paramMap.get("shop_tel1").toString(), paramMap.get("shop_tel2").toString(), paramMap.get("shop_tel3").toString(), code.getTelNumberMap())){
			// 업체번호 전체 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel1");
		}else if(false){
			// 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}
		
		return this.rtnMap;
	}
	
	// 입점회원 수정 체크(validation)
	public Map<String, Object> shopMemberEditForm(Map<String, Object> paramMap){
		ShopMember shop = new ShopMember();
		if(!paramMap.containsKey("shop_name") || paramMap.get("shop_name").equals("")){
			// 업체명 체크
			this.rtnMap.put("msg", alertMessage.getShopNameError());
			this.rtnMap.put("elementID", "shop_name");
		}else if(!paramMap.containsKey("shop_tel1") || paramMap.get("shop_tel1").equals("")){
			// 업체번호 앞자리 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel1");
		}else if(!paramMap.containsKey("shop_tel2") || paramMap.get("shop_tel2").equals("")){
			// 업체번호 중간자리 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel2");
		}else if(!paramMap.containsKey("shop_tel3") || paramMap.get("shop_tel3").equals("")){
			// 업체번호 뒷자리 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel3");
		}else if(!stringUtil.mobileNumber_validation(paramMap.get("shop_tel1").toString(), paramMap.get("shop_tel2").toString(), paramMap.get("shop_tel3").toString(), code.getTelNumberMap())){
			// 업체번호 전체 체크
			this.rtnMap.put("msg", alertMessage.getShopTelError());
			this.rtnMap.put("elementID", "shop_tel1");
		}else if(false){
			// 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}
		
		return this.rtnMap;
	}
	
	// FAQ 등록 체크(validation)
	public Map<String, Object> faqWriteForm(Map<String, Object> paramMap){
		if(!paramMap.containsKey("faq_title") || paramMap.get("faq_title").equals("")){
			// FAQ 제목 체크
			this.rtnMap.put("msg", alertMessage.getFaqTitleError());
			this.rtnMap.put("elementID", "faq_title");
		}else if(!paramMap.containsKey("faq_content") || paramMap.get("faq_content").equals("")){
			// FAQ 내용 체크
			this.rtnMap.put("msg", alertMessage.getFaqContentError());
			this.rtnMap.put("elementID", "faq_content");
		}else if(false){
			// 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}
		
		return this.rtnMap;
	}
	
	// FAQ 수정 체크(validation)
	public Map<String, Object> faqEditForm(Map<String, Object> paramMap){
		if(!paramMap.containsKey("faq_title") || paramMap.get("faq_title").equals("")){
			// FAQ 제목 체크
			this.rtnMap.put("msg", alertMessage.getFaqTitleError());
			this.rtnMap.put("elementID", "faq_title");
		}else if(!paramMap.containsKey("faq_content") || paramMap.get("faq_content").equals("")){
			// FAQ 내용 체크
			this.rtnMap.put("msg", alertMessage.getFaqContentError());
			this.rtnMap.put("elementID", "faq_content");
		}else if(false){
			// 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}
		
		return this.rtnMap;
	}
	
	// 일반상품 등록 체크(validation)
	public Map<String, Object> generalProductWriteForm(Map<String, Object> paramMap){
		ShopMember shop = new ShopMember();
		paramMap.put("seq", paramMap.get("admin_seq"));
		if(!paramMap.containsKey("admin_seq") || paramMap.get("admin_seq").equals("") || shop.getData(paramMap)==null){
			// 일반상품 업체 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductShopError());
			this.rtnMap.put("elementID", "admin_seq_check");
		}else if(!paramMap.containsKey("p_name") || paramMap.get("p_name").equals("")){
			// 일반상품명 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductNameError());
			this.rtnMap.put("elementID", "p_name_check");
		}else if(!paramMap.containsKey("category") || paramMap.get("category").equals("")){
			// 일반상품 분류 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductCategoryError());
			this.rtnMap.put("elementID", "category_check");
		}else if(!paramMap.containsKey("p_price") || paramMap.get("p_price").equals("")){
			// 일반상품 가격 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductPriceError());
			this.rtnMap.put("elementID", "p_price_check");
//		}else if(!paramMap.containsKey("generalProduct_color") || paramMap.get("generalProduct_color").equals("") || !stringUtil.colorHex_validation(paramMap.get("generalProduct_color").toString())){
//			// 일반상품 색상 체크
//			this.rtnMap.put("msg", alertMessage.getGeneralProductColorError());
//			this.rtnMap.put("elementID", "p_color_check");
//		}else if(!paramMap.containsKey("generalProduct_size1") || paramMap.get("generalProduct_size1").equals("")){
//			// 일반상품 사이즈 체크
//			this.rtnMap.put("msg", alertMessage.getGeneralProductSizeError());
//			this.rtnMap.put("elementID", "generalProduct_size1");
		}else if(!paramMap.containsKey("p_main_url") || Integer.parseInt(paramMap.get("p_main_url").toString()) <= 0 ){
			// 일반상품 메인 이미지 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductMainImageError());
			this.rtnMap.put("elementID", "p_main_url_check");
		}else if(!paramMap.containsKey("detail_url") || Integer.parseInt(paramMap.get("detail_url").toString()) <= 0 ){
			// 일반상품 상세 이미지 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductDetailImageError());
			this.rtnMap.put("elementID", "detail_url_check");
		}else if(!paramMap.containsKey("lookup_url") || Integer.parseInt(paramMap.get("lookup_url").toString()) <= 0 ){
			// 일반상품 코디 이미지 체크
			this.rtnMap.put("msg", alertMessage.getGeneralProductCodiImageError());
			this.rtnMap.put("elementID", "lookup_url_check");
//		}else if(!paramMap.containsKey("generalProduct_topImage") || Integer.parseInt(paramMap.get("generalProduct_topImage").toString()) <= 0 ){
//			// 일반상품 상품 이미지 체크
//			this.rtnMap.put("msg", alertMessage.getGeneralProductTopImageError());
//			this.rtnMap.put("elementID", "topImageArea");
//		}else if(!paramMap.containsKey("generalProduct_codiImage") || Integer.parseInt(paramMap.get("generalProduct_codiImage").toString()) <= 0 ){
//			// 3D코드 체크
//			this.rtnMap.put("msg", alertMessage.getGeneralProductCodiImageError());
//			this.rtnMap.put("elementID", "codiImageArea");
		}else if(false){
			// 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}		
		return this.rtnMap;
	}
	
}