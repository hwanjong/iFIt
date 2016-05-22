package dao;

import java.util.List;
import java.util.Map;

import dto.FaqDTO;

public interface FaqDAO {
	public FaqDTO getOneRow(Map<String, Object> paramMap);		//	one row
	public Object getList(Map<String, Object> paramMap);				//	List
	public int write(FaqDTO faqDTO);										//	Write
	public int edit(FaqDTO faqDTO);											//	Edit
	public int delete(int seq);													//	Delete
}
