package com.hwan.model;

import java.util.ArrayList;

public class MainModel {
	ArrayList<Product> allProductList;
	ArrayList<MainLabel> mainLabelList;
	ArrayList<Banner> bannerList;
	ArrayList<String> adminTagList;
	ArrayList<String> hotTagList;
	public ArrayList<Product> getAllProductList() {
		return allProductList;
	}
	public void setAllProductList(ArrayList<Product> allProductList) {
		this.allProductList = allProductList;
	}
	public ArrayList<MainLabel> getMainLabelList() {
		return mainLabelList;
	}
	public void setMainLabelList(ArrayList<MainLabel> mainLabelList) {
		this.mainLabelList = mainLabelList;
	}
	public ArrayList<Banner> getBannerList() {
		return bannerList;
	}
	public void setBannerList(ArrayList<Banner> bannerList) {
		this.bannerList = bannerList;
	}
	public ArrayList<String> getAdminTagList() {
		return adminTagList;
	}
	public void setAdminTagList(ArrayList<String> adminTagList) {
		this.adminTagList = adminTagList;
	}
	public ArrayList<String> getHotTagList() {
		return hotTagList;
	}
	public void setHotTagList(ArrayList<String> hotTagList) {
		this.hotTagList = hotTagList;
	}
}
