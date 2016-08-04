package com.hwan.model;

import java.io.UnsupportedEncodingException;

public class PgAccessResult {
	String P_STATUS;
	String RMEP_RMESG1;
	String P_TID;
	String P_REQ_URL;
	String P_NOTI;
	
	public String getP_STATUS() {
		return P_STATUS;
	}
	public void setP_STATUS(String p_STATUS) {
		P_STATUS = p_STATUS;
	}
	public String getRMEP_RMESG1() {
		return RMEP_RMESG1;
	}
	public void setRMEP_RMESG1(String rMEP_RMESG1) {
		RMEP_RMESG1 = rMEP_RMESG1;
	}
	public String getP_TID() {
		return P_TID;
	}
	public void setP_TID(String p_TID) {
		P_TID = p_TID;
	}
	public String getP_REQ_URL() {
		return P_REQ_URL;
	}
	public void setP_REQ_URL(String p_REQ_URL) {
		P_REQ_URL = p_REQ_URL;
	}
	public String getP_NOTI() {
		return P_NOTI;
	}
	public void setP_NOTI(String p_NOTI) {
		try {
			P_NOTI = new String(p_NOTI.getBytes("iso-8859-1"), "euc-kr");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void getAllInfo(){
		System.out.println("P_STATUS: "+getP_STATUS());
		System.out.println("RMEP_RMESG1: "+getRMEP_RMESG1());
		System.out.println("P_TID: "+getP_TID());
		System.out.println("P_REQ_URL: "+getP_REQ_URL());
		System.out.println("P_NOTI: "+getP_NOTI());
	}
}
