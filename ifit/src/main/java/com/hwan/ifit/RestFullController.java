package com.hwan.ifit;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.junit.runner.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hwan.dao.ProductDAO;
import com.hwan.dao.UserDAO;
import com.hwan.model.Banner;
import com.hwan.model.FaQ;
import com.hwan.model.MainModel;
import com.hwan.model.Product;
import com.hwan.model.Promotion;
import com.hwan.model.SearchModel;
import com.hwan.model.User;
import com.hwan.service.SMSUtil;

@RestController
@RequestMapping("/*")
public class RestFullController {
	@Inject
	UserDAO userDao;
	@Inject
	ProductDAO productDao;
	@Autowired
	SMSUtil smsUtil;
	
	@RequestMapping("/getMainProduct")
	MainModel getMain(){
		return productDao.getMainResource();
	}
	
	@RequestMapping("/getBanner")
	Map<String, ArrayList<Banner>> getBanner(){
		HashMap<String, ArrayList<Banner>> map = new HashMap<>();
		map.put("bannerList", productDao.getBannerList());
		return map;
	}
	
	@RequestMapping("/getPromotionList")
	Map<String, ArrayList<Promotion>> getPromotion(){
		HashMap<String, ArrayList<Promotion>> map = new HashMap<>();
		map.put("promotionList", productDao.getPromotionList());
		return map;
	}
	@RequestMapping(value = "/getSubPromotion", method=RequestMethod.POST)
	Map<String, ArrayList<Product>> getSubPromotion(int proSeq){
		HashMap<String, ArrayList<Product>> map = new HashMap<>();
		map.put("productList", productDao.getSubPromotion(proSeq));
		return map;
	}
	
	@RequestMapping(value="/getProduct", method=RequestMethod.POST)
	Product getProduct(String productId,HttpSession session){
		User user=(User) session.getAttribute("user");
		Product product= productDao.getProductByProductId(productId,user);
		return product;
	}
	
	@RequestMapping(value="/getSubPhoto", method=RequestMethod.POST)
	ArrayList<Banner> getProductSubPhoto(String productId){
		
		ArrayList<Banner> bannerList= productDao.getSubPhotoByProductId(productId);
		return bannerList;
	}
	
	@RequestMapping("/getBestCategory")
	Map<String,ArrayList<Product>> getCategory(){
		HashMap<String, ArrayList<Product>> map = new HashMap<>();
		map.put("bestList", productDao.getBestCategory());
		return map;
	}
	@RequestMapping(value="/getItems",method=RequestMethod.POST)
	Map<String,ArrayList<Product>> getItems(SearchModel data){
		HashMap<String, ArrayList<Product>> map = new HashMap<>();
		ArrayList<Product> productList = productDao.getSearchItems(data);
		map.put("productList", productList);
		ArrayList<Product> requestValue = new ArrayList<>();
		requestValue.add(new Product());
		requestValue.add(new Product());
		requestValue.get(0).setProductName(data.getSelectedCategory());
		requestValue.get(1).setProductName(data.getInputValue());
		map.put("requestValue", requestValue);
		return map;
	}	
	
	@RequestMapping("/getManyQuestion")
	Map<String,ArrayList<FaQ>> getManyQuestion(){
		HashMap<String, ArrayList<FaQ>> map = new HashMap<>();
		map.put("faqList", userDao.getFAQ());
		return map;
	}
	
	
	@RequestMapping("/phoneConfirm")
	Map<String,String> phoneConfirm(@RequestParam("phoneNumber") String phoneNumber){
		HashMap<String, String> map = new HashMap<>();
		String codeNum = smsUtil.randomNumber();
		try {
			System.out.println(smsUtil.send("인증번호 : "+codeNum, phoneNumber));
			map.put("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		userDao.insertPhoneConfirm(phoneNumber, codeNum);
		System.out.println(phoneNumber);
		
		return map;
	}
	
	@RequestMapping("/codeConfirm")
	Map<String,String> codeConfirm(@RequestParam("phoneNumber") String phoneNumber,@RequestParam("code") String code){
		HashMap<String, String> map = new HashMap<>();
		if(userDao.checkCodePhone(phoneNumber,code)){
			map.put("result", "success");
		}else{
			map.put("result", "fail");
		}
		return map;
	}
}