package com.hwan.model;

public class Pay {
	String deliveryAddress;
	String deliveryAddressDetail;
	String payUserName;
	String orderDate;
	String totalPrice;
	
	String userId;
	String pay_seq;
	
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public String getDeliveryAddressDetail() {
		return deliveryAddressDetail;
	}
	public void setDeliveryAddressDetail(String deliveryAddressDetail) {
		this.deliveryAddressDetail = deliveryAddressDetail;
	}
	public String getPayUserName() {
		return payUserName;
	}
	public void setPayUserName(String payUserName) {
		this.payUserName = payUserName;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPay_seq() {
		return pay_seq;
	}
	public void setPay_seq(String pay_seq) {
		this.pay_seq = pay_seq;
	}
	
}