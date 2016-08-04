package com.hwan.dao;

import java.util.ArrayList;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hwan.mapper.ProductMapper;
import com.hwan.model.Banner;
import com.hwan.model.MainModel;
import com.hwan.model.Order;
import com.hwan.model.Pay;
import com.hwan.model.Product;
import com.hwan.model.Promotion;
import com.hwan.model.SearchModel;
import com.hwan.model.User;

@Repository
public class ProductDAO {
	@Inject
	private SqlSession sqlSession;
	
	public Product getProductByProductId(String productId,User user){
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		Product product = mapper.getProduct(productId);
		try {
			product.setReviewList(mapper.getReview(productId));
			product.setColorList(mapper.getColorList(productId));
			product.setSizeList(mapper.getSize(productId));
			if(user!=null){
				product.setIsLikeItem(mapper.isLikeItem(user.getUserId(),productId));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return product;
	}
	
	public MainModel getMainResource(){
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		MainModel model = new MainModel();
		model.setAllProductList(mapper.getMainProduct());
		model.setMainLabelList(mapper.getLebelList());
		model.setBannerList(mapper.getBannerList());
		model.setAdminTagList(mapper.getAdminTagList());
		model.setHotTagList(mapper.getHotTagList());
		return model;
	}
	
	public ArrayList<Banner> getBannerList(){
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		ArrayList<Banner> bannerList = null;
		try {
			bannerList= mapper.getBannerList();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return bannerList;
	}
	
	public ArrayList<Promotion> getPromotionList(){
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		return mapper.getPromotionList();
	}
	public ArrayList<Product> getBestCategory(){
		ArrayList<Product> resultList = new ArrayList<>();
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		for(int i=1;i<=8;i++){
			for(Product product :mapper.getCategoryBestList(i)){
				resultList.add(product);
			}
		}
		return resultList;
	}

	public ArrayList<Product> getSearchItems(SearchModel search) {
		// TODO Auto-generated method stub
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		ArrayList<Product> productList =null;
		//Input�� �ִ°��
		if(search.getInputValue()!=""){
			try {
				productList = mapper.getProductByInputValue(search);
				mapper.updateAndInsertQuery(search.getInputValue());
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else {
			productList = mapper.getProductByCategory(search);
		}
		return productList;
	}

	public ArrayList<Product> getSubPromotion(int proSeq) {
		// TODO Auto-generated method stub
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		ArrayList<Product> productList = null;
		try {
			productList = mapper.gerSubPromotion(proSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}

	public ArrayList<Banner> getSubPhotoByProductId(String productId) {
		// TODO Auto-generated method stub
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		ArrayList<Banner> bannerList = null;
		try {
			bannerList = mapper.getSubPhoto(productId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return bannerList;
		
	}

	// 통합함
	public void insertPayAndOrder(Pay pay) {
		// TODO Auto-generated method stub
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		String paySeq = null;
		try {
			mapper.insertPay(pay);
			paySeq = pay.getPay_seq();
			for(Order orderData : pay.getOrderList()){
				orderData.setPay_seq(paySeq);
				orderData.setUserId(pay.getUserId());
				insertOrder(orderData);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	/**
	 * 상세페이지에서 낱개 상품을 주문
	 * @param order
	 * @param b 
	 */
	public void insertOrder(Order order) {
		// TODO Auto-generated method stub
		try {
			ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
			Product product = mapper.getProduct(order.getProductId());
			//임시 배송비 고정.(Mybatis 쿼리에서처리)
			order.setPrice(product.getProductPrice());
			mapper.insertOrder(order);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public void insertCart(Order order) {
		// TODO Auto-generated method stub
		try {
			ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
			mapper.insertCart(order);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public ArrayList<Product> getCartItem(User user){
		ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
		ArrayList<Product> productList = null;
		try {
			productList = mapper.getCartItems(user.getUserId());
			if(productList!=null){
				for(Product product:productList){
					product.setColorList(mapper.getColorList(product.getProductId()));
					product.setSizeList(mapper.getSize(product.getProductId()));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}

}
