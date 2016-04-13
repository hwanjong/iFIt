package dto;

import lombok.Data;
import lombok.Setter;
import lombok.AccessLevel;

@Data
public class AdminDTO {
	private int seq;					//	관리자 시퀀스
	private String id;				//	관리자 아이디
	private String pw;				//	관리자 비밀번호
	private String name;			//	관리자 이름
	private String regdate;			//	관리자 등록일
}
