package com.hwan.ifit;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.hwan.dao.ProductDAO;
import com.hwan.dao.UserDAO;
import com.hwan.model.EachQuestion;
import com.hwan.model.Order;
import com.hwan.model.Pay;
import com.hwan.model.PgAccessResult;
import com.hwan.model.Product;
import com.hwan.model.User;
import com.hwan.service.WebConnector;

@Controller
@RequestMapping("/pageView/*")
public class ViewController {
	@Inject
	UserDAO userDao;
	@Inject
	ProductDAO productDao;
	@Autowired
	WebConnector connector;

	@RequestMapping("/index.html")
	ModelAndView getIndexPage(){
		ModelAndView mv = new ModelAndView("index");
		return mv;
	}

	@RequestMapping("/codiPage.html")
	ModelAndView getCodiPage(HttpSession session){
		ModelAndView mv = new ModelAndView("codiPage");
		ArrayList<Product> bestList = productDao.getBestCategory();
		User user = (User) session.getAttribute("user");
		if(user != null){
			ArrayList<Product> cartList = productDao.getCartItem(user);
			ArrayList<Product> zzimList = userDao.getLikeItemList(user);
			mv.addObject("cartList",cartList);
			mv.addObject("zzimList",zzimList);
		}
		mv.addObject("bestList", bestList);
		return mv;
	}

	@RequestMapping("/join.html")
	ModelAndView getJoinPage(){
		ModelAndView mv = new ModelAndView("join");
		return mv;
	}

	@RequestMapping("/manyQuestion.html")
	ModelAndView getManyQuestionPage(){
		ModelAndView mv = new ModelAndView("manyQuestion");
		return mv;
	}

	@RequestMapping("/moreInfoPage.html")
	ModelAndView getMoreInfoPagePage(){
		ModelAndView mv = new ModelAndView("moreInfoPage");
		return mv;
	}

	@RequestMapping("/oneByoneQnA.html")
	ModelAndView getOneByoneQnAPage(HttpSession session){
		ModelAndView mv = new ModelAndView("oneByoneQnA");
		User user = (User) session.getAttribute("user");
		ArrayList<EachQuestion> questionList = null;
		if(user!=null){
			questionList = userDao.getUserQuestion(user);
			mv.addObject("questionList", questionList);
		}
		return mv;
	}

	@RequestMapping("/orderTracking.html")
	ModelAndView getorderTrackingPage(HttpSession session){
		ModelAndView mv = new ModelAndView("orderTracking");
		User user = (User) session.getAttribute("user");
		ArrayList<Order> orderList =null;
		if(user!=null){
			orderList = userDao.getOrderList(user);
			mv.addObject("orderList", orderList);
		}
		return mv;
	}

	@RequestMapping(value="/updateUserInfo.html",method=RequestMethod.POST)
	ModelAndView getupdateUserInfoPage(HttpSession session, @RequestParam("inputPw")String inputPw,
			RedirectAttributes rttr){
		ModelAndView mv = new ModelAndView("updateUserInfo");
		User user = (User) session.getAttribute("user");
		if(user !=null){

			if(user.getUserPw()==null){
				mv.addObject("curUser",user);
				mv.addObject("msg","sns");
			}else if(user.getUserPw().equals(inputPw)){
				mv.addObject("curUser",user);
				return mv;
			}else{
				mv.addObject("msg","fail");
			}
		}else{
			mv.addObject("msg","noUser");
		}
		return mv;
	}
	
	@RequestMapping(value="/requestPayPg.ap",method=RequestMethod.GET)
	String requestPayPgGET(PgAccessResult pgResult){
		System.out.println("PG에서응답받음 GET");
		pgResult.getAllInfo();
		return "redirect:/pageView/orderTracking.html";
	}
	
	@RequestMapping(value="/requestPayPg.ap",method=RequestMethod.POST)
	String requestPayPgPOST(PgAccessResult pgResult, HttpSession session){
		System.out.println("PG에서응답받음 POST");
		pgResult.getAllInfo();
		
		Map<String, String> rtnMap = new HashMap<String, String>();
		
		Gson gson = new Gson();
		
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("result", "fail");
			return "redirect:/pageView/index.html";
		}
		
		try {
			rtnMap = connector.sendPOST(pgResult.getP_REQ_URL(), pgResult.getP_TID());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		if((rtnMap.get("P_STATUS").toString()).equals("00")){
			Pay pay = gson.fromJson(pgResult.getP_NOTI(), Pay.class);
			
			pay.setUserId(user.getUserId());
			pay.setPgSuccessNumber((rtnMap.get("P_TID").toString()).replaceAll("[^0-9]", ""));
			pay.setTotalPrice(rtnMap.get("P_AMT").toString());
			
			productDao.insertPayAndOrder(pay);
			
			for(Order orderData : pay.getOrderList()){
				if(!orderData.getCartSeq().equals("0")){
					userDao.deleteCart(user.getUserId(),orderData.getCartSeq());
				}
			}
			System.out.println("결제성공");
		}else{
			System.out.println("결제실패");
		}
		
		return "redirect:/pageView/orderTracking.html";
		
	}
}
