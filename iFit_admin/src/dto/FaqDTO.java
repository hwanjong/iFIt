package dto;

import lombok.Data;
import lombok.Setter;
import lombok.AccessLevel;

@Data
public class FaqDTO {
	private int seq;					//	관리자 시퀀스
	private String title;				//	관리자 아이디
	private String content;			//	관리자 비밀번호
	private String regdate;			//	관리자 등록일
}
