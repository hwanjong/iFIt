package util.config;

import java.util.HashMap;
import java.util.Map;

import lombok.Data;
import lombok.Setter;
import lombok.AccessLevel;

@Data
public class FormValidate{
	
	private AlertMessage alertMessage = new AlertMessage();
	private Map<String, Object> rtnMap = new HashMap<String, Object>();
	
	public FormValidate(){
		this.rtnMap.put("res", false);		// validation결과
		this.rtnMap.put("msg", "");			// 페이지 전달 메세지
		this.rtnMap.put("formID", "");		// form요소 id명
	}
	
	public void useAjax(){
	}
	public Map<String, Object> loginAuthError(){
		this.rtnMap.put("res", false);
		this.rtnMap.put("msg", alertMessage.getLoginError());	
		this.rtnMap.put("formID", "admin_id");
		return this.rtnMap;
	}
	// 로그인 체크
	public Map<String, Object> loginForm(Map<String, Object> paramMap){
		if(paramMap.get("id").equals("")){
			// 아이디 체크
			this.rtnMap.put("msg", alertMessage.getLoginError());
			this.rtnMap.put("formID", "admin_id");
		}else if(paramMap.get("pw").equals("")){
			// 비밀번호 체크
			this.rtnMap.put("msg", alertMessage.getLoginError());
			this.rtnMap.put("formID", "admin_pw");
		}else if(false){
			// 아이디/비밀번호 자리수 체크 추가 가능
		}else{
			this.rtnMap.put("res", true);
		}
		
		return this.rtnMap;
	}
	
}