package com.hwan.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class SMSUtil {

	String charsetType = "UTF-8"; //EUC-KR 또는 UTF-8

	public String randomNumber() {
		String randomString = "";
		Random random = new Random();
		Hashtable ht = new Hashtable();
		int i = 0;
		while (true) {
			int value = random.nextInt(10);

			if (!ht.containsKey(new Integer(value)) && i <= 5) {
				ht.put(new Integer(value), new Integer(value));
				i++;
			} else if (i == 6) {
				break;
			}
		}
		Enumeration enums = ht.keys();
		while (enums.hasMoreElements()) {
			randomString += ht.get(enums.nextElement());
		}
		return randomString;
	}

	public String nullcheck(String str,  String Defaultvalue ) throws Exception{
		String ReturnDefault = "" ;
		if (str == null){
			ReturnDefault =  Defaultvalue ;
		}else if (str == "" ){
			ReturnDefault =  Defaultvalue ;
		}else{
			ReturnDefault = str ;
		}
		return ReturnDefault ;
	}

	/**
	 * BASE64 Encoder
	 * @param str
	 * @return
	 */
	public String base64Encode(String str)  throws java.io.IOException {
		sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
		byte[] strByte = str.getBytes();
		String result = encoder.encode(strByte);
		return result ;
	}

	/**
	 * BASE64 Decoder
	 * @param str
	 * @return
	 */
	public String base64Decode(String str)  throws java.io.IOException {
		sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
		byte[] strByte = decoder.decodeBuffer(str);
		String result = new String(strByte);
		return result ;
	}

	public String send(String sendMsg, String phoneNum) throws Exception{

		// 필수
		String sms_url = "";
		sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
		String user_id = base64Encode("dobedobe1"); // SMS아이디
		String secure = base64Encode("1486c1546e11ec29125196faf704c6ba ");//인증키
		String sphone1 = base64Encode(nullcheck("010", ""));
		String sphone2 = base64Encode(nullcheck("8521", ""));
		String sphone3 = base64Encode(nullcheck("2409", ""));
		String rphone = base64Encode(nullcheck(phoneNum, ""));
		String msg = base64Encode(nullcheck(sendMsg, ""));

		// 선택
		String rdate = base64Encode(nullcheck("", ""));
		String rtime = base64Encode(nullcheck("", ""));
		String mode = base64Encode("1");
		String subject = "";
		//        if(nullcheck(request.getParameter("smsType"), "").equals("L")) {
		//            subject = base64Encode(nullcheck(request.getParameter("subject"), ""));
		//        }
		String testflag = base64Encode(nullcheck("", ""));
		String destination = base64Encode(nullcheck("", ""));
		String repeatFlag = base64Encode(nullcheck("", ""));
		String repeatNum = base64Encode(nullcheck("", ""));
		String repeatTime = base64Encode(nullcheck("", ""));
		String returnurl = nullcheck("", "");
		String nointeractive = nullcheck("", "");
		String smsType = base64Encode(nullcheck("S", ""));

		String[] host_info = sms_url.split("/");
		String host = host_info[2];
		String path = "/" + host_info[3];
		int port = 80;

		// 데이터 맵핑 변수 정의
		String arrKey[]
				= new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3","rdate","rtime"
						,"mode","testflag","destination","repeatFlag","repeatNum", "repeatTime", "smsType", "subject"};
		String valKey[]= new String[arrKey.length] ;
		valKey[0] = user_id;
		valKey[1] = secure;
		valKey[2] = msg;
		valKey[3] = rphone;
		valKey[4] = sphone1;
		valKey[5] = sphone2;
		valKey[6] = sphone3;
		valKey[7] = rdate;
		valKey[8] = rtime;
		valKey[9] = mode;
		valKey[10] = testflag;
		valKey[11] = destination;
		valKey[12] = repeatFlag;
		valKey[13] = repeatNum;
		valKey[14] = repeatTime;
		valKey[15] = smsType;
		valKey[16] = subject;

		String boundary = "";
		Random rnd = new Random();
		String rndKey = Integer.toString(rnd.nextInt(32000));
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] bytData = rndKey.getBytes();
		md.update(bytData);
		byte[] digest = md.digest();
		for(int i =0;i<digest.length;i++)
		{
			boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
		}
		boundary = "---------------------"+boundary.substring(0,11);

		// 본문 생성
		String data = "";
		String index = "";
		String value = "";
		for (int i=0;i<arrKey.length; i++)
		{
			index =  arrKey[i];
			value = valKey[i];
			data +="--"+boundary+"\r\n";
			data += "Content-Disposition: form-data; name=\""+index+"\"\r\n";
			data += "\r\n"+value+"\r\n";
			data +="--"+boundary+"\r\n";
		}

		//out.println(data);

		InetAddress addr = InetAddress.getByName(host);
		Socket socket = new Socket(host, port);
		// 헤더 전송
		BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
		wr.write("POST "+path+" HTTP/1.0\r\n");
		wr.write("Content-Length: "+data.length()+"\r\n");
		wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
		wr.write("\r\n");

		// 데이터 전송
		wr.write(data);
		wr.flush();

		// 결과값 얻기
		BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(),charsetType));
		String line;
		String alert = "";
		ArrayList tmpArr = new ArrayList();
		while ((line = rd.readLine()) != null) {
			tmpArr.add(line);
		}
		wr.close();
		rd.close();

		String tmpMsg = (String)tmpArr.get(tmpArr.size()-1);
		String[] rMsg = tmpMsg.split(",");
		String Result= rMsg[0]; //발송결과
		String Count= ""; //잔여건수
		if(rMsg.length>1) {Count= rMsg[1]; }

		//발송결과 알림
		if(Result.equals("success")) {
			alert = "성공적으로 발송하였습니다.";
			alert += " 잔여건수는 "+ Count+"건 입니다.";
		}
		else if(Result.equals("reserved")) {
			alert = "성공적으로 예약되었습니다";
			alert += " 잔여건수는 "+ Count+"건 입니다.";
		}
		else if(Result.equals("3205")) {
			alert = "잘못된 번호형식입니다.";
		}
		else {
			alert = "[Error]"+Result;
		}

		return alert;
	}
}