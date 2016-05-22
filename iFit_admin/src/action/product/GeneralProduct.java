package action.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import util.config.*;
import util.file.FileUploader;
import util.system.StringUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.IfitDAO;
import dto.ProductListDTO;
import dto.SubPhotoDTO;
import dto.SizeListDTO;
import dto.SizeMapDTO;
import lombok.Data;

@Data
public class GeneralProduct extends ActionSupport  {
	private Map session;
	private ActionContext context;
	private WebApplicationContext wac;
	private FormValidate formValidate = new FormValidate();
	private Code code = new Code();
	private AlertMessage alertMessage = new AlertMessage();
	private IfitDAO productListDAO;
	private IfitDAO sizeListDAO;
	private IfitDAO sizeMapDAO;
	private IfitDAO subPhotoDAO;
	private ProductListDTO productListDTO;
	private SizeMapDTO sizeMapDTO;
	private SubPhotoDTO subPhotoDTO;
	private List<ProductListDTO> dataList;
	private List<SizeListDTO> sizeList;
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
    private String queryIncode = "";						//	쿼리스트링(인코딩)
    private String queryDecode = "";						//	쿼리스트링(디코딩)
    
    private LinkedHashMap searchColKindMap = new LinkedHashMap() {{	// 검색 가능한 종류
    	// db상의 name과 매칭 
    	put(0,"id");					// 기본값
    	put(1,"p_name");				// 상품 검색	
    	put(2,"ADMIN_NAME");		// 업체명 검색
    }};
    
    private LinkedHashMap sortColKindMap = new LinkedHashMap() {{	// 정렬항목 정의
    	// db상의 name과 매칭
		put(0,"regdate");				// 기본값 정렬
		put(1,"p_name");				// 상품명 정렬
		put(2,"ADMIN_NAME");	 	// 입점 업체명 정렬
		put(3,"regdate");	 			// 등록일 정렬
	}};
    
	private int admin_seq;												//	업체seq
	private String p_name;												//	상품명
	private int category;												//	상품 분류
	private int p_price;													//	가격
	private String color_list;											//	상품색상
	private List<Integer> sizeArray = new ArrayList<Integer>();	//	상품사이즈
	private String cat_ref;												//	3D코드
	private String detail_info;											//	상품상세설명
	private int seq;
	
	// 첨부파일 영역
	private List<File> p_main_url = new ArrayList<File>();											//	상품 메인이미지
	private List<String> p_main_urlContentType = new ArrayList<String>(); 						//	상품 메인이미지 첨부파일 종류
	private List<String> p_main_urlFileName = new ArrayList<String>(); 							//	상품 메인이미지 첨부파일명
	private List<File> generalProduct_topImage = new ArrayList<File>();							//	상품이미지
	private List<String> generalProduct_topImageContentType = new ArrayList<String>(); 	//	상품이미지 첨부파일 종류
	private List<String> generalProduct_topImageFileName = new ArrayList<String>(); 		//	상품이미지 첨부파일명
	private List<File> detail_url = new ArrayList<File>();												//	상품상세이미지
	private List<String> detail_urlContentType = new ArrayList<String>(); 	//	상품상세이미지 첨부파일 종류
	private List<String> detail_urlFileName = new ArrayList<String>(); 		//	상품상세이미지 첨부파일명
	private List<File> lookup_url = new ArrayList<File>();											//	상품코디이미지
	private List<String> lookup_urlContentType = new ArrayList<String>(); 						//	상품코디이미지 첨부파일 종류
	private List<String> lookup_urlFileName = new ArrayList<String>(); 							//	상품코디이미지 첨부파일명
	
	public GeneralProduct() {
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
		this.productListDAO = (IfitDAO)this.wac.getBean("productList");
		this.sizeListDAO = (IfitDAO)this.wac.getBean("sizeList");
		this.sizeMapDAO = (IfitDAO)this.wac.getBean("sizeMap");
		this.subPhotoDAO = (IfitDAO)this.wac.getBean("subPhoto");
		
		this.productListDTO = new ProductListDTO();
		this.sizeMapDTO = new SizeMapDTO();
		this.subPhotoDTO = new SubPhotoDTO();
		this.context = ActionContext.getContext();	//session을 생성하기 위해
		this.session = this.context.getSession();		// Map 사용시
		this.rtnString = "";
	}
	
	public String getList() throws Exception{
		init();
		if(this.searchColKindMap.containsKey(this.searchCol)){
			this.searchMap.put(this.searchColKindMap.get(this.searchCol).toString(), this.searchVal);
		}
		if(!StringUtil.stringToBool(StringUtil.isNullOrSpace((String)session.get("isAdmin"),"").trim())){
			// 업체 접근시
			this.whereMap.put("PL.admin_seq", session.get("admin_seq"));
		}
		this.paramMap.put("searchMap", this.searchMap);
		this.paramMap.put("whereMap", this.whereMap);
		this.paramMap.put("isCount",true);
		int totalCount = (int)this.productListDAO.getList(paramMap);
		
		this.pageNum = this.pageNum == 0 || (this.pageNum*this.countPerPage>totalCount && this.pageNum*this.countPerPage-totalCount >= this.countPerPage)  ? 1  : this.pageNum;
		this.sortCol = this.sortColKindMap.containsKey(this.sortCol) ? this.sortCol : 0;
		this.sortVal = this.sortVal.equals("ASC") ? "ASC" : "DESC";
		this.paramMap.put("isCount",false);
		this.paramMap.put("pageNum",this.pageNum);
		this.paramMap.put("countPerPage",this.countPerPage);
		this.paramMap.put("sortCol", this.sortColKindMap.get(this.sortCol));
		this.paramMap.put("sortVal", this.sortVal);
		this.dataList = (List<ProductListDTO>)this.productListDAO.getList(paramMap);
		
		this.queryIncode = StringUtil.stringToHex(this.request.getQueryString()==null ? "" : this.request.getQueryString());
		this.pagingHTML = paging.getPaging(totalCount, this.pageNum, this.countPerPage);
		
		return SUCCESS;
	}
	
	public void setSizeList() throws Exception{
		init();
		
		this.paramMap.put("isCount",false);
		this.sizeList = (List<SizeListDTO>)this.sizeListDAO.getList(paramMap);
	}
	
	// 일반상품 조회
	public ProductListDTO getData(Map<String, Object> paramMap){
		init();
		if(!StringUtil.stringToBool(StringUtil.isNullOrSpace((String)session.get("isAdmin"),"").trim())){
			this.whereMap.put("PL.admin_seq", session.get("admin_seq"));
		}
		if(paramMap.containsKey("seq")){
			this.whereMap.put("PL.p_id", paramMap.get("seq"));
			this.paramMap.put("whereMap", this.whereMap);
		}

		return (ProductListDTO) this.productListDAO.getOneRow(this.paramMap);
	}
	
	// 일반상품 조회
	public SizeMapDTO getSizeMapData(Map<String, Object> paramMap){
		init();
		
		if(paramMap.containsKey("product_seq")){
			this.whereMap.clear();
			this.whereMap.put("product_seq", paramMap.get("product_seq"));
			this.paramMap.put("whereMap", this.whereMap);
		}

		return (SizeMapDTO) this.sizeMapDAO.getOneRow(this.paramMap);
	}
	
	public SubPhotoDTO getSubPhotoData(Map<String, Object> paramMap){
		init();
		
		if(paramMap.containsKey("product_seq")){
			this.whereMap.clear();
			this.whereMap.put("product_seq", paramMap.get("product_seq"));
			this.paramMap.put("whereMap", this.whereMap);
		}

		return (SubPhotoDTO) this.subPhotoDAO.getOneRow(this.paramMap);
	}
	
	public String getEditor() throws Exception{
		init();
		setSizeList();
		this.queryDecode = StringUtil.hexToString(this.queryIncode);
		
		return SUCCESS;
	}
	
	public String writeAction() throws Exception {	
		init();
		
		FileUploader fileUploader = new FileUploader("generalProduct");
		
		int product_seq=0;
		Gson gson = new Gson();
		
		if(!StringUtil.stringToBool(StringUtil.isNullOrSpace((String)session.get("isAdmin"),"").trim())){
			// 업체 접근시
			this.admin_seq = (int) session.get("admin_seq");
		}

		this.p_name = StringUtil.isNullOrSpace(this.p_name,"").trim();
		this.color_list = StringUtil.isNullOrSpace(this.color_list,"").trim();
		paramMap.put("admin_seq", this.admin_seq);
		paramMap.put("p_name", this.p_name);
		paramMap.put("category", this.category);
		paramMap.put("p_price", this.p_price);
		paramMap.put("color_list", this.color_list);
		paramMap.put("cat_ref", this.cat_ref);
		paramMap.put("detail_info", this.detail_info);
		paramMap.put("p_main_url", this.p_main_url.size());
		paramMap.put("detail_url", this.detail_url.size());
		paramMap.put("lookup_url", this.lookup_url.size());
//		paramMap.put("generalProduct_topImage", this.generalProduct_topImage.size());
		this.validateMsgMap = formValidate.generalProductWriteForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}else if(!fileUploader.fileValidation(getP_main_url(), getP_main_urlFileName(), this.p_main_url)){
			validateMsgMap = formValidate.fileUploadError();
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}else if(!fileUploader.fileValidation(getDetail_url(), getDetail_urlFileName(), this.detail_url)){
			validateMsgMap = formValidate.fileUploadError();
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}else if(!fileUploader.fileValidation(getLookup_url(), getLookup_urlFileName(), this.lookup_url)){
			validateMsgMap = formValidate.fileUploadError();
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}
//		}else if(!fileUploader.fileValidation(getGeneralProduct_topImage(), getGeneralProduct_topImageFileName(), this.generalProduct_topImage)){
//			validateMsgMap = formValidate.fileUploadError();
//			this.rtnString = gson.toJson(validateMsgMap);
//			return "validation";

		this.productListDTO.setAdmin_seq(this.admin_seq);
		this.productListDTO.setP_name(this.p_name);
		this.productListDTO.setCategory(this.category);
		this.productListDTO.setP_price(this.p_price);
		this.productListDTO.setDetail_info(this.detail_info);
		this.productListDTO.setCat_ref(this.cat_ref);
		this.productListDTO.setColor_list(this.color_list);

		String saveFileName = "";
		
		// 메인이미지 업로드
		for (int i = 0; i < this.p_main_url.size(); i++) { 
			saveFileName = fileUploader.fileUpload(getP_main_urlFileName(), getP_main_url(), i, 0);	//파일업로드
			saveFileName = request.getServerName()+":"+request.getServerPort()+"/upload"+ saveFileName;
			this.productListDTO.setP_main_url(saveFileName);
		}
		// 코디이미지 업로드
		for (int i = 0; i < this.lookup_url.size(); i++) { 
			saveFileName = fileUploader.fileUpload(getLookup_urlFileName(), getLookup_url(), i, 0);	//파일업로드
			saveFileName = request.getServerName()+":"+request.getServerPort()+"/upload"+ saveFileName;
			this.productListDTO.setLookup_url(saveFileName);
		}		
		product_seq = this.productListDAO.write(this.productListDTO);
		
		this.sizeMapDTO.setP_id(product_seq);
		for(int i=0; i<this.sizeArray.size(); i++){
			if(!this.sizeArray.get(i).equals("")){
				this.sizeMapDTO.setSize_id(this.sizeArray.get(i));
				this.sizeMapDAO.write(this.sizeMapDTO);
			}
		}
		
		// 파일 여러장 업로드 시작
		this.subPhotoDTO.setP_id(product_seq);
		
		// 상품이미지 업로드
//		for (int i = 0; i < this.generalProduct_topImage.size(); i++) { 
//			saveFileName = fileUploader.fileUpload(getGeneralProduct_topImageFileName(), getGeneralProduct_topImage(), i, 0);	//파일업로드
//			this.imageMapDTO.setImage_kind(2);
//			this.imageMapDTO.setOriginal_name(getGeneralProduct_topImageFileName().get(i));
//			this.imageMapDTO.setReal_name(saveFileName);
//			this.imageMapDTO.setSize(StringUtil.longToInt(getGeneralProduct_topImage().get(i).length()));
//			this.imageMapDAO.write(this.imageMapDTO);
//		}
//		
		// 상품상세이미지 업로드
		for (int i = 0; i < this.detail_url.size(); i++) { 
			saveFileName = fileUploader.fileUpload(getDetail_urlFileName(), getDetail_url(), i, 0);	//파일업로드
			saveFileName = request.getServerName()+":"+request.getServerPort()+"/upload"+ saveFileName;
			this.subPhotoDTO.setPhoto_url(saveFileName);
			this.subPhotoDTO.setPhoto_type(2);
			this.subPhotoDAO.write(this.subPhotoDTO);
		}
//		
//		// 상품코디이미지 업로드
//		for (int i = 0; i < this.generalProduct_codiImage.size(); i++) { 
//			saveFileName = fileUploader.fileUpload(getGeneralProduct_codiImageFileName(), getGeneralProduct_codiImage(), i, 0);	//파일업로드
//			this.imageMapDTO.setImage_kind(4);
//			this.imageMapDTO.setOriginal_name(getGeneralProduct_codiImageFileName().get(i));
//			this.imageMapDTO.setReal_name(saveFileName);
//			this.imageMapDTO.setSize(StringUtil.longToInt(getGeneralProduct_codiImage().get(i).length()));
//			this.imageMapDAO.write(this.imageMapDTO);
//		}
		
		this.session.put("alertMsg", this.alertMessage.getGeneralProductWriteOK());
		this.context.setSession(this.session);
		
		return SUCCESS;
	}
	
	public String editAction() throws Exception {	
		init();
/*
		Gson gson = new Gson();
		this.generalProduct_name = StringUtil.isNullOrSpace(this.generalProduct_name,"").trim();
		this.generalProduct_price = this.generalProduct_price;
		paramMap.put("generalProduct_name", this.generalProduct_name);
		paramMap.put("generalProduct_price", this.generalProduct_price);
		
		this.validateMsgMap = formValidate.generalProductEditForm(paramMap);
		paramMap.clear();
		if(!(boolean)validateMsgMap.get("res")){
			this.rtnString = gson.toJson(validateMsgMap);
			return "validation";
		}
		
		this.generalProductDTO.setName(this.generalProduct_name);
		this.generalProductDTO.setPrice(this.generalProduct_price);
		this.generalProductDTO.setSeq(this.seq);
		
		this.generalProductDAO.edit(this.generalProductDTO);
		
		this.session.put("alertMsg", this.alertMessage.getShopEditOK());
		this.context.setSession(this.session);
*/
		return SUCCESS;
	}
	
	public String deleteAction(){
		init();

		this.productListDAO.delete(this.seq);
		this.session.put("alertMsg", this.alertMessage.getDeleteOK());
		this.context.setSession(this.session);
		
		return SUCCESS;	
	}

}
