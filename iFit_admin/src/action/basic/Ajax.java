package action.basic;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import util.config.*;
import util.system.AESCrypto;
import util.system.MySqlFunction;
import util.system.StringUtil;

import action.help.Faq;
import action.member.ShopMember;
import action.product.GeneralProduct;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dto.ProductListDTO;

import lombok.Data;

@Data
public class Ajax extends ActionSupport  {
	private Map session;
	private ActionContext context;
	private WebApplicationContext wac;
	private FormValidate formValidate = new FormValidate();
	private Map<String, Object> validateMsgMap = new HashMap<String, Object>();
	private StringUtil stringUtil = new StringUtil();
	private boolean isAdmin;
	
	private String data;
	private String rtnString;
	
	public Ajax() {
		ServletContext servletContext = ServletActionContext.getServletContext();
	    this.wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	}

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
	
	//	요소 초기화 및 세팅
	public void init(){
		this.context = ActionContext.getContext();	//session을 생성하기 위해
		this.session = this.context.getSession();		// Map 사용시
		this.isAdmin = StringUtil.stringToBool(StringUtil.isNullOrSpace((String)session.get("isAdmin"),"").trim());
	}
	
	public String ajaxFormValidate(){
		init();
		JSONObject jsonObject = (JSONObject) JSONValue.parse(data);
		String formID = jsonObject.get("formID").toString();
		if(formID.equals("shopMemberWriteForm")){
			validateMsgMap = this.isAdmin ? formValidate.shopMemberWriteForm(jsonObject) : null;
		}else if(formID.equals("shopMemberEditForm")){
			validateMsgMap = this.isAdmin ? formValidate.shopMemberEditForm(jsonObject) : null;
		}else if(formID.equals("faqWriteForm")){
			validateMsgMap = this.isAdmin ? formValidate.faqWriteForm(jsonObject) : null;
		}else if(formID.equals("faqEditForm")){
			validateMsgMap = this.isAdmin ? formValidate.faqWriteForm(jsonObject) : null;
		}else if(formID.equals("generalProductWriteForm")){
			validateMsgMap = formValidate.generalProductWriteForm(jsonObject);
		}
		
		Gson gson = new Gson();
		this.rtnString = gson.toJson(validateMsgMap);
		
		return SUCCESS;		
	}
	
	public String ajaxGetData(){
		init();
		Gson gson = new Gson();
		JSONObject jsonObject = (JSONObject) JSONValue.parse(data);
		String dataKind = jsonObject.get("dataKind").toString();
		
		if(this.isAdmin && dataKind.equals("shop")){
			jsonObject.put("queryMode","one");
			ShopMember shopMember= new ShopMember();
			this.rtnString = gson.toJson(shopMember.getData(jsonObject));
		}else if(this.isAdmin && dataKind.equals("shopList")){
			jsonObject.put("queryMode","list");
			ShopMember shopMember= new ShopMember();
			this.rtnString = gson.toJson(shopMember.getData(jsonObject));
		}else if(this.isAdmin && dataKind.equals("faq")){
			Faq faq = new Faq();
			this.rtnString = gson.toJson(faq.getData(jsonObject));
		}else if(dataKind.equals("generalProduct")){
			GeneralProduct generalProduct = new GeneralProduct();
			ProductListDTO genralProductDTO = generalProduct.getData(jsonObject);
			String productStr = gson.toJson(genralProductDTO);
//			jsonObject.put("product_seq", genralProductDTO.getSeq());
			String sizeMapStr = gson.toJson(generalProduct.getSizeMapData(jsonObject).getAllSize());
			String imageMapStr = gson.toJson(generalProduct.getSubPhotoData(jsonObject).getPhoto_url());
			this.rtnString = stringUtil.addObjectGson(productStr, sizeMapStr, "sizeMap");
			this.rtnString = stringUtil.addObjectGson(this.rtnString, imageMapStr, "image");
		}
		
		System.out.println("AJAX!!!!!!!!!" + this.rtnString);
		return SUCCESS;		
	}
}
