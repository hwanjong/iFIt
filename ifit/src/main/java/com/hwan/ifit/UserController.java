package com.hwan.ifit;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hwan.dao.ProductDAO;
import com.hwan.dao.UserDAO;
import com.hwan.model.EachQuestion;
import com.hwan.model.Order;
import com.hwan.model.Pay;
import com.hwan.model.Product;
import com.hwan.model.Review;
import com.hwan.model.User;
import com.hwan.service.MyMailSender;
import com.hwan.service.RandomGenerator;

@RestController
@RequestMapping("/Users/*")
public class UserController {
	@Inject
	UserDAO userDao;
	@Inject
	ProductDAO productDao;
	@Inject
	MyMailSender mailSender;
	@Autowired
	RandomGenerator randomGenerator;

	@RequestMapping("/logout.ap")
	Map<String,String> logout(HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		map.put("result","success");
		session.invalidate();
		return map;
	}

	/**
	 * User/non-User's Request : regist LikeInfo after Check to target Item
	 * @param session : request can regist only registed Account 
	 * @param likeItemNo
	 * @return
	 */
	@RequestMapping(value = "/likeItem.ap",method=RequestMethod.POST)
	Map<String,String> likeItemRequest(HttpSession session,@RequestParam("likeItemNo")String likeItemNo){
		HashMap<String, String> map = new HashMap<>();
		User user = (User) session.getAttribute("user");
		if(user !=null){
			map.put("result",userDao.likeItem(likeItemNo,user.getUserId()));
		}else{
			map.put("result","noUser");
		}
		return map;
	}

	@RequestMapping(value = "/getLikeList")
	ArrayList<Product> likeItemJson(HttpSession session){
		User user = (User) session.getAttribute("user");
		ArrayList<Product> likeItemList = null;
		if(user !=null){
			likeItemList = userDao.getLikeItemList(user);
		}
		return likeItemList;
	}

	@RequestMapping(value = "/registQuestion.ap",method=RequestMethod.POST)
	Map<String,String> registQuestion(HttpSession session,EachQuestion question){
		HashMap<String, String> map = new HashMap<>();
		User user = (User) session.getAttribute("user");
		if(user !=null){
			userDao.registQuestion(question,user.getUserId());
			mailSender.sendMailToAdmin(user.getEmail(), "고객이 질문이 접수되었습니다. ["+question.getTitle()+"]", question.getContent());
			map.put("result","success");
		}else{
			map.put("result","noUser");
		}
		return map;
	}

	@RequestMapping(value = "/deleteLikeItem.ap", method=RequestMethod.POST)
	Map<String,String> deleteRequestLikeItem(HttpSession session,@RequestParam("zzimSeq") String zzimSeq){
		HashMap<String, String> map = new HashMap<>();
		User user = (User) session.getAttribute("user");
		if(user!=null){
			userDao.deleteLikeInfo(zzimSeq);
			map.put("result", "success");
		}else{
			map.put("result", "noUser");
		}
		return map;
	}

	@RequestMapping(value="/joinRequest", method=RequestMethod.POST)
	Map<String,String> joinUser(@ModelAttribute User user,HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		if(user.getUserId().length()<6){
			map.put("result", "ID는 6자 이상");
			return map;
		}else if(user.getUserPw().length()<8){
			map.put("result", "비밀번호는 8자 이상");
			return map;
		}

		map.put("result", userDao.joinUser(user,session));
		mailSender.sendMailToUser(user.getEmail(), "아이핏 가입을 환영합니다.", user.getUserId()+"님의 이메일이 등록되었습니다.");;
		mailSender.sendMailToAdmin("dobepartners@gmail.com", user.getUserId()+"님이 가입하셨습니다.", user.getEmail()+"님의 이메일이 등록되었습니다.");;
		return map;
	}

	@RequestMapping(value="/snsLogin", method=RequestMethod.POST)
	Map<String,String> snsLogin(@ModelAttribute User user,HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		userDao.checkSNSLogin(user);
		User getUser = userDao.getUserInfoById(user);
		getUser.setProfileImage(user.getProfileImage());
		session.setAttribute("user", getUser);
		map.put("result", "success");
		return map;
	}

	@RequestMapping(value="/loginRequest",method=RequestMethod.POST)
	HashMap<String, String> loginUser(@ModelAttribute User user,HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		User resultUser = userDao.getUser(user);

		if(resultUser==null){
			map.put("result", "fail");
		}else{
			session.setAttribute("user", resultUser);
			map.put("result", "success");
		}
		return map;
	}

	@RequestMapping(value="/updateInfo.ap",method=RequestMethod.POST)
	HashMap<String, String> updateInfoRequest(@ModelAttribute User user,
			@RequestParam("changePw") String changePw, HttpSession session){

		HashMap<String, String> map = new HashMap<>();
		User sessionUser = (User) session.getAttribute("user");
		System.out.println(changePw);
		if(sessionUser !=null){
			user.setUserId(sessionUser.getUserId());
			userDao.updateInfo(user,changePw);
			session.setAttribute("user", userDao.getUserInfoById(user));
			map.put("result", "success");
		}else{
			map.put("result", "noUser");
			return map;
		}
		return map;
	}


	@RequestMapping(value="/registReview.ap", method=RequestMethod.POST)
	Map<String,String> registReview(HttpSession session,@ModelAttribute Review review){
		HashMap<String, String> map = new HashMap<>();

		User user = (User) session.getAttribute("user");
		if(user!=null){
			map.put("result", "success");
			review.setUserId(user.getUserId());
			userDao.registReview(review);
		}else{
			map.put("result", "fail");
		}
		return map;
	}

	@RequestMapping(value="/purchaseRequest",method=RequestMethod.POST)
	HashMap<String, String> purchaseRequest(@ModelAttribute Order order,
			@RequestParam("modeType")String modeType, HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("result", "fail");
			return map;
		}
		order.setUserId(user.getUserId());
		//Cart와 Order 같이 처리 DTO도 Order로 같이처리했음.
		if(modeType.equals("cartRequest")){
			productDao.insertCart(order);
			map.put("result", "Success_cart");
		}else{
			//결제 정보확인한후에 넣어야함.
			productDao.insertOrder(order,true);
			map.put("result", "Success_order");
		}
		return map;
	}
	@RequestMapping(value="/cartPurchaseRequest.ap",method=RequestMethod.POST)
	HashMap<String, String> cartPurchaseRequest(@ModelAttribute Pay pay, HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("result", "fail");
			return map;
		}
		pay.setUserId(user.getUserId());
		String paySeq = userDao.insertPay(pay);
		map.put("paySeq", paySeq);
		return map;
	}
	@RequestMapping(value="/insertEachOrder.ap",method=RequestMethod.POST)
	HashMap<String, String> insertEachOrder(@ModelAttribute Order order, HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("result", "fail");
			return map;
		}
		productDao.insertOrder(order,false);
		//카트에서 삭제하는 작업도 해야됨.
		userDao.deleteCart(user.getUserId(),order.getCartSeq());
		map.put("result", "success");
		return map;
	}

	@RequestMapping(value="/transferCart.ap",method=RequestMethod.POST)
	HashMap<String, String> transferCart(@RequestParam("zzimSeq") String zzimSeq,
			@RequestParam("productId") String productId, HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("result", "fail");
			return map;
		}
		userDao.transferZzimToCart(user.getUserId(),zzimSeq,productId);
		map.put("result", "success");
		return map;
	}

	@RequestMapping(value="/getCartItems")
	ArrayList<Product> getCartItems(HttpSession session){
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			return null;
		}
		return productDao.getCartItem(user);
	}

	@RequestMapping(value="/deleteCart.ap",method=RequestMethod.POST)
	HashMap<String, String> deleteCart(@RequestParam("cartSeq") String cartSeq,HttpSession session){
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("result", "fail");
			return map;
		}
		userDao.deleteCart(user.getUserId(),cartSeq);
		map.put("result", "success");
		return map;
	}

	@RequestMapping(value="/curDeliveryAddress")
	ArrayList<Pay> getCurDeliveryAddress(HttpSession session){
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user == null){
			return null;
		}
		ArrayList<Pay> addressList = null;
		addressList = userDao.getDeliveryAddressList(user);
		return addressList;
	}

	@RequestMapping(value="/findPw",method=RequestMethod.POST)
	HashMap<String, String> findPw(User user){
		HashMap<String, String> map = new HashMap<>();
		//등록된 email인지 확인
		User resultUser =userDao.checkFindPw(user); 
		if(resultUser!=null){
			String tempPw = randomGenerator.nextSessionId();
			resultUser.setUserPw(tempPw);
			userDao.updateInfo(resultUser, "1");
			mailSender.sendMailToUser(user.getEmail(), "아이핏 임시비밀번호 발급입니다.", user.getUserId()+"님의 임시비밀번호입니다.\n["+tempPw+"]\n\n임시 비밀번호로 접속후 회원정보수정을 통해 비밀번호를 변경해주세요.");
			map.put("result", "success");
			return map;
		}else{
			map.put("result", "fail");
		}

		return map;
	}
	@RequestMapping(value="/codiToCart.ap",method=RequestMethod.POST)
	HashMap<String, String> codiToCart(@RequestParam("productList[]") List<String> productList,HttpSession session){
		ArrayList<String> cartList = (ArrayList<String>) productList;
		HashMap<String, String> map = new HashMap<>();
		//Session 검사
		User user = (User) session.getAttribute("user");
		if(user != null){
			userDao.addCart(user.getUserId(), cartList);
			map.put("result", "success");
		}else{
			map.put("result", "fail");
		}
		return map;
	}
	
	


}
