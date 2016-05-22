package dao;

import java.util.Map;

public interface IfitDAO {
	public Object getOneRow(Map<String, Object> paramMap);	//	one row
	public Object getList(Map<String, Object> paramMap);			//	List
	public int write(Object adminDTO);									//	Write
	public int edit(Object adminDTO);									//	edit
	public int delete(int seq);												//	Delete
}
