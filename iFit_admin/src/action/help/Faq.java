package action.help;

import java.util.HashMap;
import java.util.List;
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

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.FaqDAO;
import dto.FaqDTO;
import lombok.Data;

@Data
public class Faq extends ActionSupport  {
	private Map session;
	private ActionContext context;
	private WebApplicationContext wac;
	private FormValidate formValidate = new FormValidate();
	private Code code = new Code();
	private AlertMessage alertMessage = new AlertMessage();
	private FaqDAO faqDAO;
	private FaqDTO faqDTO;
	private List<FaqDTO> dataList;
	private Paging paging = new Paging();
	private Map<String, Object> paramMap = new HashMap<String, Object>();
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
	
	private String faq_title;				//	제목
	private String faq_content;		//	내용
	private int seq;
	
	public Faq() {
		ServletContext servletContext = ServletActionContext.getServletContext();
	    this.wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	}

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
	
	//	요소 초기화 및 세팅
	public void init(){
		this.faqDAO = (FaqDAO)this.wac.getBean("faq");
		this.faqDTO = new FaqDTO();
		this.context = ActionContext.getContext();	//session을 생성하기 위해
		this.session = this.context.getSession();		// Map 사용시
		this.rtnString = "";
	}
	
	// faq 목록
	public String getList() throws Exception{
		init();
		paramMap.put("isCount",true);
		int totalCount = (int)this.faqDAO.getList(paramMap);
		this.pageNum = this.pageNum == 0 || (this.pageNum*this.countPerPage>totalCount && this.pageNum*this.countPerPage-totalCount >= this.countPerPage)  ? 1  : this.pageNum;
		
		paramMap.put("isCount",false);
		paramMap.put("pageNum",this.pageNum);
		paramMap.put("countPerPage",this.countPerPage);
		this.dataList = (List<FaqDTO>)this.faqDAO.getList(paramMap);
		
		this.pagingHTML = paging.getPaging(totalCount, this.pageNum, this.countPerPage);
		
		return SUCCESS;
	}
	
	// faq 조회
	public FaqDTO getData(Map<String, Object> paramMap){
		init();
		
		if(paramMap.containsKey("seq")){
			this.whereMap.put("seq", paramMap.get("seq"));
			this.paramMap.put("whereMap", this.whereMap);
		}

		return this.faqDAO.getOneRow(this.paramMap);
	}
	
	//	faq 등록
	public String writeAction() throws Exception {	
		init();
		
		Gson gson = new Gson();
		this.faq_title = StringUtil.isNullOrSpace(this.faq_title,"").trim();
		this.faq_content = StringUtil.isNullOrSpace(this.faq_content,"").trim();
		paramMap.put("faq_title", this.faq_title);
		paramMap.put("faq_content", this.faq_content);
		
		this.validateMsgMap = formValidate.faqWriteForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}
		
		this.faqDTO.setTitle(this.faq_title);
		this.faqDTO.setContent(this.faq_content);
		
		this.faqDAO.write(this.faqDTO);
		
		this.session.put("alertMsg", this.alertMessage.getFaqWriteOK());
		this.context.setSession(this.session);
		
		return SUCCESS;
	}
	
	//	FAQ 수정
	public String editAction() throws Exception {	
		init();

		Gson gson = new Gson();
		this.faq_title = StringUtil.isNullOrSpace(this.faq_title,"").trim();
		this.faq_content = StringUtil.isNullOrSpace(this.faq_content,"").trim();
		paramMap.put("faq_title", this.faq_title);
		paramMap.put("faq_content", this.faq_content);
		
		this.validateMsgMap = formValidate.faqEditForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}
		
		this.faqDTO.setTitle(this.faq_title);
		this.faqDTO.setContent(this.faq_content);
		this.faqDTO.setSeq(this.seq);
		
		this.faqDAO.edit(this.faqDTO);
		
		this.session.put("alertMsg", this.alertMessage.getShopEditOK());
		this.context.setSession(this.session);

		return SUCCESS;
	}
	
	public String deleteAction(){
		init();

		this.faqDAO.delete(this.seq);
		this.session.put("alertMsg", this.alertMessage.getDeleteOK());
		this.context.setSession(this.session);
		
		return SUCCESS;	
	}

}
