package com.hwan.dao;

import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hwan.mapper.CommonMapper;
import com.hwan.mapper.ProductMapper;
import com.hwan.mapper.UserMapper;
import com.hwan.model.Cart;
import com.hwan.model.EachQuestion;
import com.hwan.model.FaQ;
import com.hwan.model.Order;
import com.hwan.model.Pay;
import com.hwan.model.Product;
import com.hwan.model.Review;
import com.hwan.model.User;

@Repository
public class UserDAO{
	@Inject
	private SqlSession sqlSession;


	public String joinUser(User user, HttpSession session){
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			User userResult = mapper.getUserInfoById(user.getUserId());
			if(userResult!=null){
				return "이미 존재하는 ID입니다.";
			}
			//핸드폰번호 중복도 체크해야됨
			mapper.joinUser(user);
			session.setAttribute("user", user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return "success";
	}

	public User getUser(User user){
		User userResult=null;
		try {
			UserMapper mapper =  sqlSession.getMapper(UserMapper.class);
			userResult = mapper.getUserInfo(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return userResult;
	}

	public ArrayList<FaQ> getFAQ() {
		// TODO Auto-generated method stub
		CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
		ArrayList<FaQ> faqList = null;
		try {
			faqList = mapper.getFAQ();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return faqList;

	}

	public ArrayList<Order> getOrderList(User user) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		ArrayList<Order> orderList = null;
		try {
			orderList = mapper.getOrderList(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return orderList;
	}

	public void registReview(Review review) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			mapper.registReview(review);
			mapper.updateOrderState(review);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			sqlSession.rollback();
		}
	}

	public String likeItem(String likeItemNo, String userId) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		String returnMsg=null;
		try {
			String zzimSeq = mapper.isLikeItem(likeItemNo,userId);
			if(zzimSeq!=null){
				mapper.descreaseLikeCount(likeItemNo);
				mapper.deleteLikeInfo(zzimSeq);
				returnMsg = "alreadyLike";
			}else{
				mapper.increaseLikeCount(likeItemNo);
				mapper.insertLikeItem(likeItemNo,userId);
				returnMsg = "success";
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return returnMsg;
	}
	
	public void deleteLikeInfo(String zzimSeq) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			mapper.deleteLikeInfo(zzimSeq);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}


	public ArrayList<Product> getLikeItemList(User user) {
		// TODO Auto-generated method stub
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		ArrayList<Product> likeItemList = null;
		try {
			likeItemList = mapper.getUserLikeItem(user);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();		
		}
		return likeItemList;
	}

	
	public ArrayList<EachQuestion> getUserQuestion(User user) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		ArrayList<EachQuestion> questionList = null;
		try {
			questionList= mapper.getUserQuestion(user.getUserId());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return questionList;
	}

	public void registQuestion(EachQuestion question, String userId) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		question.setUserId(userId);
		try {
			mapper.registQeustion(question);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void transferZzimToCart(String userId,String zzimSeq,String productId) {
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			//먼저 Cart에 {User,productId}가 있는지보고 없으면 Cart에 추가.
			String cartSeq = mapper.getCartSeq(productId,userId);
			if(cartSeq ==null){
				mapper.insertCartItemFromZzim(productId,userId);
			}
			//최종적으로는 찜에있는 zzimSeq삭제.
			mapper.deleteLikeInfo(zzimSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public void addCart(String userId, ArrayList<String> productIdList){
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			for(String productId:productIdList){
				mapper.insertCartItemFromZzim(productId, userId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteCart(String userId, String cartSeq) {
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			mapper.deleteCart(userId,cartSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public ArrayList<Pay> getDeliveryAddressList(User user) {
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		ArrayList<Pay> payList=null;
		try {
			payList = mapper.getRecentAddress(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return payList;
	}

	public void checkSNSLogin(User user) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			User resultUser = mapper.getUserInfoById(user.getUserId());
			if(resultUser == null){
				mapper.joinUser(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public User getUserInfoById(User user){
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		User resultUser = null;
		try {
			resultUser = mapper.getUserInfoById(user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultUser;
	}

	public void updateInfo(User user, String changePw) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			if(changePw.equals("1")){
				mapper.updateUserInfoAll(user);
			}else{
				mapper.updateUserInfoNoPw(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public User checkFindPw(User user) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		User resultUser = null;
		try {
			resultUser = mapper.getUserInfoByIdEmail(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultUser;
	}

	public String insertPay(Pay pay) {
		// TODO Auto-generated method stub
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		String paySeq = null;
		try {
			//pay_seq를 받아서 돌려줘야함.
			mapper.insertPay(pay);
			paySeq = pay.getPay_seq();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return paySeq;
	}
	
	public void insertPhoneConfirm(String phone,String code){
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		try {
			mapper.insertPhoneConfirm(phone,code);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean checkCodePhone(String phone, String code) {
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		String seq =null;
		try {
			seq = mapper.checkPhoneConfirm(phone,code);
			if(seq!=null){
				System.out.println("일치");
				mapper.deletePhoneCode(seq);
				return true;
			}else{
				System.out.println("불일치");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
