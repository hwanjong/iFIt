package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import util.system.StringUtil;

import dto.ProductListDTO;

@Repository
public class ProductListDAOImp implements IfitDAO {

	private ProductListDTO productListDTO; 
	private NamedParameterJdbcTemplate jdbcTemplate;
	private String table_name = " product_list  ";
	
	@Autowired
	public void setDataSource(DataSource dataSource){ 
		this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}
	
	public ProductListDAOImp(){
	
	}
	
	//	조건에 맞는 목록
	public Object getOneRow(Map<String, Object> paramMap) {	
		Map<String,Object> sqlMap = new HashMap<String,Object>();
		List<ProductListDTO> list = new ArrayList<ProductListDTO>();
		Map<String, Object> whereMap = (Map<String, Object>) (paramMap.containsKey("whereMap") ? paramMap.get("whereMap") : null);
		String sql = "";
		
		sqlMap.put("one", 1);
		
        sql = "	SELECT PL.*, A.name AS admin_name FROM "+ table_name + " PL JOIN ADMIN A ON PL.admin_seq = A.seq WHERE :one = :one	\n";
        if(whereMap!=null && !whereMap.isEmpty()){
            for( String key : whereMap.keySet() ){
            	sqlMap.put(key, whereMap.get(key));
            	sql += " and " + key + " = :"+key+"		\n";
            }
        }
        
        list  = this.jdbcTemplate.query(sql,sqlMap,new BeanPropertyRowMapper(ProductListDTO.class));
        this.productListDTO = (list.size() == 1) ? list.get(0) : null;
        return this.productListDTO;
	}
	
//	LIST
	public Object getList(Map<String, Object> paramMap) {
		Map<String,Object> sqlMap = new HashMap<String,Object>();
		List<ProductListDTO> list = new ArrayList<ProductListDTO>();
		boolean isCount = paramMap.containsKey("isCount") ? (boolean)paramMap.get("isCount") : false;
		Map<String, Object> whereMap = (Map<String, Object>) (paramMap.containsKey("whereMap") ? paramMap.get("whereMap") : null);
		int pageNum = paramMap.containsKey("pageNum") ? (int)paramMap.get("pageNum") : 0;
		int countPerPage = paramMap.containsKey("countPerPage") ? (int)paramMap.get("countPerPage") : 0;
		int startNum = (pageNum-1)*countPerPage;
		
		String sql = "";
		
		sqlMap.put("one", 1);
		sqlMap.put("startNum", startNum);
		sqlMap.put("countPerPage", countPerPage);
		
		if(isCount){
			sql += "	SELECT COUNT(*)	\n";
		}else{
			sql += "	SELECT PL.admin_seq, A.name AS ADMIN_NAME, PL.p_name, PL.p_price, PL.color_list, PL.detail_info, 	\n";
			sql += "	PL.p_id,	\n";
			sql += "	DATE_FORMAT(PL.regdate, '%Y-%m-%d') AS REGDATE		\n";
		}
        sql += " FROM "+ table_name + " PL JOIN ADMIN A ON PL.admin_seq = A.seq WHERE :one = :one \n";
        if(whereMap!=null && !whereMap.isEmpty()){
            for( String key : whereMap.keySet() ){
            	sqlMap.put(key, whereMap.get(key));
            	sql += " and " + key + " = :"+key+"		\n";
            }
        }
        
        sql += " ORDER BY PL.p_id DESC		\n";
        
        if(isCount || pageNum==0){
		}else{
			sql += " LIMIT :startNum, :countPerPage	\n";
		}
        
        System.out.println("sql:::"+sql);
        
        if(isCount){
        	return this.jdbcTemplate.queryForInt(sql,sqlMap);
		}else{
			list  = this.jdbcTemplate.query(sql, sqlMap, new BeanPropertyRowMapper(ProductListDTO.class));
	        return list;
		}
	}
	
	//	Write
	public int write(Object dto) {
		String sql = "";
		sql += "	INSERT INTO " + table_name + "	\n";
		sql += "	(p_name, p_main_url, lookup_url, p_price, color_list, detail_info, category, cat_ref, admin_seq)	\n";
		sql += "	values(:p_name, :p_main_url, :lookup_url, :p_price, :color_list, :detail_info, :category, :cat_ref, :admin_seq)	\n";

		MapSqlParameterSource paramSource = new MapSqlParameterSource();
		paramSource.addValue("p_name", ((ProductListDTO) dto).getP_name(), Types.VARCHAR);
		paramSource.addValue("p_main_url", ((ProductListDTO) dto).getP_main_url(), Types.VARCHAR);
		paramSource.addValue("lookup_url", ((ProductListDTO) dto).getLookup_url(), Types.VARCHAR);
		paramSource.addValue("p_price", ((ProductListDTO) dto).getP_price(), Types.NUMERIC);
		paramSource.addValue("color_list", ((ProductListDTO) dto).getColor_list(), Types.VARCHAR);
		paramSource.addValue("detail_info", ((ProductListDTO) dto).getDetail_info(), Types.VARCHAR);
		paramSource.addValue("category", ((ProductListDTO) dto).getCategory(), Types.NUMERIC);
		paramSource.addValue("cat_ref", ((ProductListDTO) dto).getCat_ref(), Types.VARCHAR);
		paramSource.addValue("admin_seq", ((ProductListDTO) dto).getAdmin_seq(), Types.NUMERIC);
		
		int rtnInt = 0;
		
		KeyHolder keyHolder = new GeneratedKeyHolder(); 
		try{
			rtnInt = this.jdbcTemplate.update(sql, paramSource, keyHolder);
		}catch(Exception e){
			System.out.println("error::::"+e);
		}
		
		long longKey = keyHolder.getKey().longValue();
		
		if(rtnInt > 0){
			return StringUtil.longToInt(longKey);
		}else{
			return 0;
		}
	}
//	
//	//	Edit
	public int edit(Object dto) {
//		String sql = "";
//		sql += "	UPDATE " + table_name + " SET	\n";
//		sql += "	admin_seq = :admin_seq, name = :name, price = :price, color = :color, detailExplain = :detailExplain	\n";
//		sql += "	where seq = :seq	\n";
//		
//		MapSqlParameterSource paramSource = new MapSqlParameterSource();
//		paramSource.addValue("admin_seq", dto.getAdmin_seq(), Types.NUMERIC);
//		paramSource.addValue("name", dto.getName(), Types.VARCHAR);
//		paramSource.addValue("price", dto.getPrice(), Types.NUMERIC);
//		paramSource.addValue("color", dto.getColor(), Types.VARCHAR);
//		paramSource.addValue("detailExplain", dto.getDetailExplain(), Types.VARCHAR);
//		paramSource.addValue("seq", dto.getSeq(), Types.NUMERIC);
//		
//		if(this.jdbcTemplate.update(sql, paramSource) > 0){
//			return dto.getSeq();
//		}else{
			return 0;
//		}
	}
	
	//	DELETE
	public int delete(int seq) {
//		int next_seq = getMaxSeq();
//		if(next_seq == 0){
//			next_seq = 1;
//		}
		String sql = "";
		sql += "	DELETE FROM " + table_name + "	\n";
		sql += "	WHERE p_id = :p_id	\n";

//		SqlLobValue lobValue = new SqlLobValue(dto.getBbs_content(), lobHandler);

		MapSqlParameterSource paramSource = new MapSqlParameterSource();
		paramSource.addValue("p_id", seq, Types.NUMERIC);
		int rtnInt = this.jdbcTemplate.update(sql, paramSource);
		if(rtnInt > 0){
			return rtnInt;
		}else{
			return 0;
		}
	}
}
