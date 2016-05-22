package util.file;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;

import util.config.Code;
import util.system.GetDate;
import util.system.StringUtil;

public class FileUploader {

	private Code code = new Code();
	private String FilePath_full; 		// 파일 전체 경로
	private String FilePath_basic = StringUtil.getPropertiesValue("path.properties",StringUtil.getPropertiesValue("struts.properties","struts.devMode").equals("true") ? "testFileServerPath" : "realFileServerPath");	// 저장경로
	private String FilePath_detail; 		// 파일 전체 경로
	private int maxSize = 10;			// MB단위

	public FileUploader(String mode){
		this.FilePath_detail = "/" + mode + "/";
	}
	
	public String fileUpload(List<String> fileName, List<File> getUploads, int idx, int option) throws IOException{

		FilePath_full = FilePath_basic + FilePath_detail;
		GetDate yymmkk = new GetDate();
		String yyyyMMddHHmmss = yymmkk.yyyyMMddHHmmss();
		String saveFileName = yyyyMMddHHmmss + idx + option + fileName.get(idx).substring(fileName.get(idx).lastIndexOf("."));
		File destFile = new File(FilePath_full + yyyyMMddHHmmss + idx + option + fileName.get(idx).substring(fileName.get(idx).lastIndexOf(".")));			       
		FileUtils.copyFile(getUploads.get(idx), destFile);
		return FilePath_detail + saveFileName;
	}
	
	public boolean fileValidation(List<File> getUploads, List<String> fileName, List<File> uploads) throws IOException{			// 파일validation
		long size_byte = maxSize*1024*1024;
		int fileExtIdx = 0;
		String chkExt = "";
		for(int i=0; i<uploads.size(); i++){
			fileExtIdx = fileName.get(i).lastIndexOf(".");
			chkExt = fileName.get(i).substring(fileExtIdx+1);
			
			// 확장자 체크
			if(!code.getAttachImageFileExtMap().containsKey(chkExt.toLowerCase())){
				return false;
			}

			// 크기 체크
			if(getUploads.get(i).length() > size_byte){
				return false;
			}
		}

		return true;
	}
}
