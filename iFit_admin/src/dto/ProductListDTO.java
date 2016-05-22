package dto;

import lombok.Data;
import lombok.Setter;
import lombok.AccessLevel;

@Data
public class ProductListDTO {
	private int p_id;					
	private String p_name;			
	private String p_main_url;	
	private String lookup_url;			
	private int p_price;				
	private String color_list;			
	private String detail_info;
	private int category;
	private int like_cnt;
	private String cat_ref;
	private int admin_seq;
	private String regdate;
	
	// join data
	private String admin_name;
}
