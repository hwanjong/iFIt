package com.hwan.model;

import java.util.ArrayList;

public class Product {
	String productId;
	String productName;
	String productMainURL;
	String lookupURL;
	String productPrice;
	String detailInfo;
	int category;
	int likeCount;
	String catRef;
	ArrayList<Size> sizeList;
	ArrayList<Color> colorList;
	ArrayList<Review> reviewList;
	String regdate;
	int mainType;
	String adminSeq;
	String isLikeItem;
	String zzimSeq;
	
	String cartSeq;
	String selectedColorId;
	String selectedSizeId;
	String amount;
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductMainURL() {
		return productMainURL;
	}
	public void setProductMainURL(String productMainURL) {
		this.productMainURL = productMainURL;
	}
	public String getLookupURL() {
		return lookupURL;
	}
	public void setLookupURL(String lookupURL) {
		this.lookupURL = lookupURL;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public String getDetailInfo() {
		return detailInfo;
	}
	public void setDetailInfo(String detailInfo) {
		this.detailInfo = detailInfo;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getCatRef() {
		return catRef;
	}
	public void setCatRef(String catRef) {
		this.catRef = catRef;
	}
	public ArrayList<Size> getSizeList() {
		return sizeList;
	}
	public void setSizeList(ArrayList<Size> sizeList) {
		this.sizeList = sizeList;
	}
	public ArrayList<Color> getColorList() {
		return colorList;
	}
	public void setColorList(ArrayList<Color> colorList) {
		this.colorList = colorList;
	}
	public ArrayList<Review> getReviewList() {
		return reviewList;
	}
	public void setReviewList(ArrayList<Review> reviewList) {
		this.reviewList = reviewList;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getMainType() {
		return mainType;
	}
	public void setMainType(int mainType) {
		this.mainType = mainType;
	}
	public String getAdminSeq() {
		return adminSeq;
	}
	public void setAdminSeq(String adminSeq) {
		this.adminSeq = adminSeq;
	}
	public String getIsLikeItem() {
		return isLikeItem;
	}
	public void setIsLikeItem(String isLikeItem) {
		this.isLikeItem = isLikeItem;
	}
	public String getZzimSeq() {
		return zzimSeq;
	}
	public void setZzimSeq(String zzimSeq) {
		this.zzimSeq = zzimSeq;
	}
	public String getCartSeq() {
		return cartSeq;
	}
	public void setCartSeq(String cartSeq) {
		this.cartSeq = cartSeq;
	}
	public String getSelectedColorId() {
		return selectedColorId;
	}
	public void setSelectedColorId(String selectedColorId) {
		this.selectedColorId = selectedColorId;
	}
	public String getSelectedSizeId() {
		return selectedSizeId;
	}
	public void setSelectedSizeId(String selectedSizeId) {
		this.selectedSizeId = selectedSizeId;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}

}
