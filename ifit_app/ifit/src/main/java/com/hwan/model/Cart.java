package com.hwan.model;

public class Cart {
	String cartSeq;
	String productId;
	String selectedColorId;
	String selectedSizeId;
	String amount;
	String userId;
	String regdate;
	public String getCartSeq() {
		return cartSeq;
	}
	public void setCartSeq(String cartSeq) {
		this.cartSeq = cartSeq;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
	
}
