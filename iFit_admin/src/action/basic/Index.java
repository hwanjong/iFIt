package action.basic;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import util.config.*;
import util.system.AESCrypto;
import util.system.MySqlFunction;
import util.system.StringUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.AdminDAO;
import dto.AdminDTO;
import lombok.Data;

@Data
public class Index extends ActionSupport  {
	private Map session;
	private ActionContext context;
	private WebApplicationContext wac;
	private ActionConfig actionConfig = new ActionConfig();
	private FormValidate formValidate = new FormValidate();
	private AdminDAO adminDAO;
	private AdminDTO adminDTO;
	private Map<String, Object> paramMap = new HashMap<String, Object>();
	private Map<String, Object> validateMsgMap = new HashMap<String, Object>();
	
	private String admin_id;		//	관리자 아이디
	private String admin_pw;		//	관리자 비밀번호
	private String nextActionNamespace;
	private String nextActionName;
	
	public Index() {
		ServletContext servletContext = ServletActionContext.getServletContext();
	    this.wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	}

	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
	
	//	요소 초기화 및 세팅
	public void init(){
		this.adminDAO = (AdminDAO)this.wac.getBean("admin");
		this.adminDTO = new AdminDTO();
		this.context = ActionContext.getContext();	//session을 생성하기 위해
		this.session = this.context.getSession();		// Map 사용시
	}
	
	//	로그인 체크
	public String loginAction() throws Exception {	
		init();
		this.admin_id = StringUtil.isNullOrSpace(this.admin_id,"").trim();
		this.admin_pw = StringUtil.isNullOrSpace(this.admin_pw,"").trim();
		paramMap.put("id", this.admin_id);
		paramMap.put("pw", this.admin_pw);
		validateMsgMap = formValidate.loginForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			return "validation";
		}
		String passwordEncode = MySqlFunction.password(AESCrypto.encryptPassword(this.admin_pw));
		paramMap.put("searchCol", "id");
		paramMap.put("searchVal", this.admin_id);
		this.adminDTO = this.adminDAO.getRow(paramMap);
		paramMap.clear();
		if(this.adminDTO == null){
			//아이디 불일치
			validateMsgMap = formValidate.loginAuthError();
			return "validation";
		}else if(!this.adminDTO.getPw().equals(passwordEncode)){
			//비밀번호 불일치
			validateMsgMap = formValidate.loginAuthError();
			return "validation";
		}

		this.nextActionNamespace = (session.get("nextActionNamespace")==null) ? "/" : session.get("nextActionNamespace").toString();
		
		if (session.get("nextActionName")!=null) {
			this.nextActionName = session.get("nextActionName").toString();
		}else{
			this.nextActionName = "index";
		}
		
		session.remove("nextActionNamespace");
		session.remove("nextActionName");
		
		session.put("admin_seq", this.adminDTO.getSeq());
		this.session.put("isAdmin", "true");
		this.context.setSession(this.session);
		
		return SUCCESS;
	}
	
	public String logoutAction(){
		init();
		this.session.clear();
		this.context.setSession(this.session);
		return SUCCESS;		
	}
}
