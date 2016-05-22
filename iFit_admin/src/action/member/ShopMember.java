package action.member;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import util.config.*;
import util.system.AESCrypto;
import util.system.MySqlFunction;
import util.system.StringUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.IfitDAO;
import dto.AdminDTO;
import lombok.Data;

@Data
public class ShopMember extends ActionSupport  {
	private Map session;
	private ActionContext context;
	private WebApplicationContext wac;
	private FormValidate formValidate = new FormValidate();
	private Code code = new Code();
	private AlertMessage alertMessage = new AlertMessage();
	private IfitDAO shopMemberDAO;
	private AdminDTO adminDTO;
	private List<AdminDTO> dataList;
	private Paging paging = new Paging();
	private Map<String, Object> paramMap = new HashMap<String, Object>();
	private Map<String, Object> searchMap = new HashMap<String, Object>();
	private Map<String, Object> whereMap = new HashMap<String, Object>();
	private Map<String, Object> validateMsgMap = new HashMap<String, Object>();
	private String rtnString;
	
	private int pageNum;				//	페이지번호
	private String pagingHTML = "";
	
	private int searchCol = 0;			// 	검색분류
    private String searchVal = "";		// 	검색어
    private int sortCol = 0;											// 	정렬 컬럼
    private String sortVal = "";										// 	정렬 내용
    private int countPerPage = Code.deFaultcountPerPage;		//	한페이지에 보일 리스트 수
    
    private HttpServletRequest request = ServletActionContext.getRequest();
    private String queryIncode;						//	쿼리스트링(인코딩)
    private String queryDecode;						//	쿼리스트링(디코딩)
    
    private LinkedHashMap searchColKindMap = new LinkedHashMap() {{	// 검색 가능한 종류
    	// db상의 name과 매칭 
    	put(0,"id");		// 기본값
    	put(1,"id");		// 아이디 검색	
    	put(2,"name");	// 이름(업체명) 검색
    }};
    
    private LinkedHashMap sortColKindMap = new LinkedHashMap() {{	// 정렬항목 정의
    	// db상의 name과 매칭
		put(0,"regdate");			// 기본값 정렬
		put(1,"id"); 				// 아이디 정렬
		put(2,"name");	 		// 입점 업체명 정렬
		put(3,"regdate");	 		// 등록일 정렬
	}};
	
	private String shop_name;		//	업체명
	private String shop_id;				//	업체 아이디
	private String shop_pw;			//	업체 비밀번호
	private String shop_tel1;			//	업체 연락처1
	private String shop_tel2;			//	업체 연락처2
	private String shop_tel3;			//	업체 연락처3
	private int seq;						//	선택된 업체 seq
	
	public ShopMember() {
		ServletContext servletContext = ServletActionContext.getServletContext();
	    this.wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	}

	public void setServletRequest(HttpServletRequest request) { 
		this.request = request; 
	}
	
	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
	
	//	요소 초기화 및 세팅
	public void init(){
		this.shopMemberDAO = (IfitDAO)this.wac.getBean("admin");
		this.adminDTO = new AdminDTO();
		this.context = ActionContext.getContext();	//session을 생성하기 위해
		this.session = this.context.getSession();		// Map 사용시
		this.rtnString = "";
	}
	
	// 입점회원 목록
	public String getList() throws Exception{
		init();
		
		if(this.searchColKindMap.containsKey(this.searchCol)){
			this.searchMap.put(this.searchColKindMap.get(this.searchCol).toString(), this.searchVal);
		}
		this.whereMap.put("isAdmin", false);
		this.paramMap.put("searchMap", this.searchMap);
		this.paramMap.put("whereMap", this.whereMap);
		this.paramMap.put("isCount",true);
		int totalCount = (int)this.shopMemberDAO.getList(paramMap);
		
		this.pageNum = this.pageNum == 0 || (this.pageNum*this.countPerPage>totalCount && this.pageNum*this.countPerPage-totalCount >= this.countPerPage)  ? 1  : this.pageNum;
		this.sortCol = this.sortColKindMap.containsKey(this.sortCol) ? this.sortCol : 0;
		this.sortVal = this.sortVal.equals("ASC") ? "ASC" : "DESC";
		
		this.paramMap.put("isCount",false);
		this.paramMap.put("pageNum",this.pageNum);
		this.paramMap.put("countPerPage",this.countPerPage);
		this.paramMap.put("sortCol", this.sortColKindMap.get(this.sortCol));
		this.paramMap.put("sortVal", this.sortVal);
		this.dataList = (List<AdminDTO>)this.shopMemberDAO.getList(paramMap);
		
		this.queryIncode = StringUtil.stringToHex(this.request.getQueryString()==null ? "" : this.request.getQueryString());
		this.pagingHTML = paging.getPaging(totalCount, this.pageNum, this.countPerPage);
		
		return SUCCESS;
	}
	
	// 입점회원 조회
	public Object getData(Map<String, Object> paramMap){
		init();
		String queryMode = paramMap.containsKey("queryMode") ? paramMap.get("queryMode").toString() : "one";
		if(queryMode.equals("one")){
			if(paramMap.containsKey("seq")){
				this.whereMap.put("isAdmin", false);
				this.whereMap.put("seq", paramMap.get("seq"));
				this.paramMap.put("whereMap", this.whereMap);
			}else if(paramMap.containsKey("shop_id")){
				this.whereMap.put("isAdmin", false);
				this.whereMap.put("id", StringUtil.isNullOrSpace(paramMap.get("shop_id").toString(),"").trim());
				this.paramMap.put("whereMap", this.whereMap);
			}
			return this.shopMemberDAO.getOneRow(this.paramMap);
		}else if(queryMode.equals("list")){
			if(!paramMap.containsKey("id")){
				return null;
			}
			this.whereMap.put("isAdmin", false);
			this.searchMap.put("id", StringUtil.isNullOrSpace(paramMap.get("id").toString(),"").trim());
			this.paramMap.put("whereMap", this.whereMap);
			paramMap.put("whereMap", this.whereMap);
			paramMap.put("searchMap", this.searchMap);
			paramMap.put("isCount",false);
			return (List<AdminDTO>)this.shopMemberDAO.getList(paramMap);
		}
		return null;
	}
	
	//	입점회원 등록
	public String writeAction() throws Exception {	
		init();
		
		Gson gson = new Gson();
		this.shop_id = StringUtil.isNullOrSpace(this.shop_id,"").trim();
		this.shop_pw = StringUtil.isNullOrSpace(this.shop_pw,"").trim();
		this.shop_name = StringUtil.isNullOrSpace(this.shop_name,"").trim();
		this.shop_tel1 = StringUtil.isNullOrSpace(this.shop_tel1,"").trim();
		this.shop_tel2 = StringUtil.isNullOrSpace(this.shop_tel2,"").trim();
		this.shop_tel3 = StringUtil.isNullOrSpace(this.shop_tel3,"").trim();
		paramMap.put("shop_id", this.shop_id);
		paramMap.put("shop_pw", this.shop_pw);
		paramMap.put("shop_name", this.shop_name);
		paramMap.put("shop_tel1", this.shop_tel1);
		paramMap.put("shop_tel2", this.shop_tel2);
		paramMap.put("shop_tel3", this.shop_tel3);
		
		this.validateMsgMap = formValidate.shopMemberWriteForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}
		
		this.adminDTO.setId(this.shop_id);
		this.adminDTO.setPw(MySqlFunction.password(AESCrypto.encryptPassword(this.shop_pw)));
		this.adminDTO.setName(this.shop_name);
		this.adminDTO.setTel1(this.shop_tel1);
		this.adminDTO.setTel2(this.shop_tel2);
		this.adminDTO.setTel3(this.shop_tel3);
		
		this.shopMemberDAO.write(this.adminDTO);
		
		this.session.put("alertMsg", this.alertMessage.getShopWriteOK());
		this.context.setSession(this.session);
		
		return SUCCESS;
	}
	
	//	입점회원 수정
	public String editAction() throws Exception {	
		init();

		Gson gson = new Gson();
		this.shop_name = StringUtil.isNullOrSpace(this.shop_name,"").trim();
		this.shop_tel1 = StringUtil.isNullOrSpace(this.shop_tel1,"").trim();
		this.shop_tel2 = StringUtil.isNullOrSpace(this.shop_tel2,"").trim();
		this.shop_tel3 = StringUtil.isNullOrSpace(this.shop_tel3,"").trim();
		paramMap.put("shop_name", this.shop_name);
		paramMap.put("shop_tel1", this.shop_tel1);
		paramMap.put("shop_tel2", this.shop_tel2);
		paramMap.put("shop_tel3", this.shop_tel3);
		
		this.validateMsgMap = formValidate.shopMemberEditForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}
		
		this.adminDTO.setName(this.shop_name);
		this.adminDTO.setTel1(this.shop_tel1);
		this.adminDTO.setTel2(this.shop_tel2);
		this.adminDTO.setTel3(this.shop_tel3);
		this.adminDTO.setSeq(this.seq);
		
		this.shopMemberDAO.edit(this.adminDTO);
		
		this.session.put("alertMsg", this.alertMessage.getShopEditOK());
		this.context.setSession(this.session);

		return SUCCESS;
	}
	
	public String deleteAction(){
		init();

		if(this.seq!=0 && this.seq!=1){
			this.shopMemberDAO.delete(this.seq);
		}
		this.session.put("alertMsg", this.alertMessage.getDeleteOK());
		this.context.setSession(this.session);
		
		return SUCCESS;	
	}

}
