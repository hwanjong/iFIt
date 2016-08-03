package com.hwan.ifit;

import java.io.IOException;
import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hwan.dao.ProductDAO;
import com.hwan.dao.UserDAO;
import com.hwan.model.EachQuestion;
import com.hwan.model.Order;
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
		return "redirect:/pageView/index.html";
	}
	
	@RequestMapping(value="/requestPayPg.ap",method=RequestMethod.POST)
	String requestPayPgPOST(PgAccessResult pgResult){
		System.out.println("PG에서응답받음 POST");
		pgResult.getAllInfo();
		try {
			connector.sendPOST(pgResult.getP_REQ_URL(), pgResult.getP_TID());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/pageView/index.html";
		
	}
}
