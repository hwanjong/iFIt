package com.hwan.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hwan.model.Banner;
import com.hwan.model.Color;
import com.hwan.model.MainLabel;
import com.hwan.model.Order;
import com.hwan.model.Product;
import com.hwan.model.Promotion;
import com.hwan.model.Review;
import com.hwan.model.SearchModel;
import com.hwan.model.Size;
import com.hwan.model.User;

@Mapper
public interface ProductMapper {
	
	public Product getProduct(String productId);
	public ArrayList<Size> getSize(String productId);
	
	public ArrayList<Product> getMainProduct();
	
	public ArrayList<MainLabel> getLebelList();
	public ArrayList<Banner> getBannerList();
	
	public ArrayList<Promotion> getPromotionList();
	
	public ArrayList<Product> getCategoryBestList(int category);
	public ArrayList<String> getAdminTagList();
	public ArrayList<String> getHotTagList();
	
	public void updateAndInsertQuery(String inputValue);
	
	public ArrayList<Product> getProductByCategory(SearchModel search);
	public ArrayList<Product> getProductByInputValue(SearchModel search);
	public ArrayList<Product> gerSubPromotion(int proSeq);
	
	public ArrayList<Banner> getSubPhoto(String productId);
	public ArrayList<Review> getReview(String productId);
	public ArrayList<Color> getColorList(String productId);
	public ArrayList<String> getRGBList(String productId);
	public void insertOrder(Order order);
	public String isLikeItem(@Param("userId")String userId,@Param("productId")String productId);
	
	public ArrayList<Product> getUserLikeItem(User user);
	public void insertCart(Order order);
	public ArrayList<Product> getCartItems(String userId);
	public int insertPayByOne(Order order);

}
