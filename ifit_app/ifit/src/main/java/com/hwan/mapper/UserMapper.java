package com.hwan.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hwan.model.Cart;
import com.hwan.model.EachQuestion;
import com.hwan.model.Order;
import com.hwan.model.Pay;
import com.hwan.model.Product;
import com.hwan.model.Review;
import com.hwan.model.User;

@Mapper
public interface UserMapper {
	public User getUserInfo(User user);
	public void joinUser(User user);
	public User getUserInfoById(String userId);
	public ArrayList<Order> getOrderList(User user);
	public void registReview(Review review);
	public void updateOrderState(Review review);
	public String isLikeItem(@Param("likeItemNo")String likeItemNo, @Param("userId")String userId);
	public void insertLikeItem(@Param("likeItemNo")String likeItemNo, @Param("userId")String userId);
	public void deleteLikeInfo(String zzimSeq);
	public ArrayList<EachQuestion> getUserQuestion(String userId);
	public void registQeustion(EachQuestion question);
	public String getCartSeq(@Param("productId")String productId, @Param("userId")String userId);
	public void insertCartItemFromZzim(@Param("productId")String productId, @Param("userId")String userId);
	public void deleteCart(@Param("userId")String userId, @Param("cartSeq")String cartSeq);
	public ArrayList<Pay> getRecentAddress(User user);
	public void updateUserInfoAll(User user);
	public void updateUserInfoNoPw(User user);
	public User getUserInfoByIdEmail(User user);
	public void insertPay(Pay pay);
	public void increaseLikeCount(String likeItemNo);
	public void descreaseLikeCount(String likeItemNo);
	public void insertPhoneConfirm(@Param("phone")String phone, @Param("code")String code);
	public String checkPhoneConfirm(@Param("phone")String phone, @Param("code")String code);
	public void deletePhoneCode(String seq);
}
