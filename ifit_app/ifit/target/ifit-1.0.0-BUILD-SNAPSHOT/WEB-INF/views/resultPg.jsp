<%@ page  contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.Calendar" %>
<%

/*******************************************************************************
' FILE NAME : mx_rnoti.asp
' FILE DESCRIPTION :
' �̴Ͻý� smart phone ���� ��� ���� ������ ����
' ������� : ts@inicis.com
' HISTORY 
' 2010. 02. 25 �����ۼ� 
' 2010  06. 23 WEB ����� ������� ���� ������� ä�� ��� ���� ó�� �߰�(APP ����� �ش� ����!!)
' WEB ����� ��� �̹� P_NEXT_URL ���� ä�� ����� ���� �Ͽ����Ƿ�, 
' �̴Ͻý����� �����ϴ� ������� ä�� ��� ������ ���� �Ͻñ� �ٶ��ϴ�.
'*******************************************************************************/


// �̴Ͻý� NOTI �������� ���� Value
//  P_TID	�ŷ���ȣ
//  P_MID	�������̵�
//  P_AUTH_DT	��������
//  P_STATUS	�ŷ����� (00:����, 01:����)
//  P_TYPE	���Ҽ���
//  P_OID	�����ֹ���ȣ
//  P_FN_CD1	�������ڵ�1
//  P_FN_CD2	�������ڵ�2
//  P_FN_NM	������� (�����, ī����, ������)
//  P_AMT	�ŷ��ݾ�
//  P_UNAME	����������
//  P_RMESG1	����ڵ�
//  P_RMESG2	����޽���
//  P_NOTI	��Ƽ�޽���(�������� �ø� �޽���)
//  P_AUTH_NO	���ι�ȣ

//**********************************************************************************
//�̺κп� �α����� ��θ� �������ּ���.	
String file_path = "/home/woong";  //�α׸� ����� ���͸�
//**********************************************************************************
String addr = request.getRemoteAddr().toString();
if("118.129.210.25".equals(addr) || "211.219.96.165".equals(addr)) //PG���� ���´��� IP�� üũ 
{
	// �̴Ͻý����� ���� value
	P_TID   	= request.getParameter("P_TID") + "";   
	P_MID     	= request.getParameter("P_MID") + "";   
	P_AUTH_DT   	= request.getParameter("P_AUTH_DT") + ""; 
	P_STATUS      	= request.getParameter("P_STATUS") + "";  
	P_TYPE       	= request.getParameter("P_TYPE") + "";    
	P_OID      	= request.getParameter("P_OID") + "";     
	P_FN_CD1    	= request.getParameter("P_FN_CD1") + "";  
	P_FN_CD2    	= request.getParameter("P_FN_CD2") + "";  
	P_FN_NM     	= request.getParameter("P_FN_NM") + "";   
	P_UNAME     	= request.getParameter("P_UNAME") + "";   
	P_AMT       	= request.getParameter("P_AMT") + "";     
	P_RMESG1      	= request.getParameter("P_RMESG1") + "";  
	P_RMESG2    	= request.getParameter("P_RMESG2") + "";  
	P_NOTI    	= request.getParameter("P_NOTI") + "";    
	P_AUTH_NO      	= request.getParameter("P_AUTH_NO") + ""; 

	/***********************************************************************************
	 ����ó���� ���� �α� ���
	 ������ ���� �����ͺ��̽��� ��� ���������� ���� �����ÿ��� "OK"�� �̴Ͻý��� ���нô� "FAIL" ��
	 �����ϼž��մϴ�. �Ʒ� ���ǿ� �����ͺ��̽� ������ �޴� FLAG ������ ��������
	 (����) OK�� �������� �����ø� �̴Ͻý� ���� ������ "OK"�� �����Ҷ����� ��� �������� �õ��մϴ�
	 ��Ÿ �ٸ� ������ out.println(response.write)�� ���� �����ñ� �ٶ��ϴ�
	***********************************************************************************/
	try
	{	
		//WEB ����� ��� ������� ä�� ��� ���� ó��
		//(APP ����� ��� �ش� ������ ���� �Ǵ� �ּ� ó�� �Ͻñ� �ٶ��ϴ�.)			
		if(P_TYPE.equals("VBANK"))	//���������� ��������̸�
		{
		  if(!P_STATUS.equals("02"))	//�Ա��뺸 "02" �� �ƴϸ�(������� ä�� : 00 �Ǵ� 01 ���)
		  {
		     out.print("OK");
		     return;		  	 
		  }
		
		}	
		

		writeLog(file_path);
		  
	//	if (�����ͺ��̽� ��� ���� ���� ���Ǻ��� = true) 
	//	{
	     		out.print("OK"); // ����� ������ ������

	//	}
	//	else
	//	{
	//    		out.print("FAIL"); 
	//	}
	    
	}
	catch(Exception e)
	{
		out.print(e.getMessage());
	}
 
}

%>



<%!

   	//�̴Ͻý� NOTI �������� ���� Value
	String  P_TID;			// �ŷ���ȣ
	String  P_MID;			// �������̵�
	String  P_AUTH_DT;		// ��������
	String  P_STATUS;		// �ŷ����� (00:����, 01:����)
	String  P_TYPE;			// ���Ҽ���
	String  P_OID;			// �����ֹ���ȣ
	String  P_FN_CD1;		// �������ڵ�1
	String  P_FN_CD2;		// �������ڵ�2
	String  P_FN_NM;		// ������� (�����, ī����, ������)
	String  P_AMT;			// �ŷ��ݾ�
	String  P_UNAME;		// ����������
	String  P_RMESG1;		// ����ڵ�
	String  P_RMESG2;		// ����޽���
	String  P_NOTI;			// ��Ƽ�޽���(�������� �ø� �޽���)
	String  P_AUTH_NO;		// ���ι�ȣ

    private String getDate()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	StringBuffer times = new StringBuffer();
        times.append(Integer.toString(calendar.get(Calendar.YEAR)));
		if((calendar.get(Calendar.MONTH)+1)<10)
        { 
            times.append("0"); 
        }
		times.append(Integer.toString(calendar.get(Calendar.MONTH)+1));
		if((calendar.get(Calendar.DATE))<10) 
        {
            times.append("0");	
        } 
		times.append(Integer.toString(calendar.get(Calendar.DATE)));
    	
    	return times.toString();
    }
    
    private String getTime()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	StringBuffer times = new StringBuffer();

    	times.append("[");
    	if((calendar.get(Calendar.HOUR_OF_DAY))<10) 
        { 
            times.append("0"); 
        } 
 		times.append(Integer.toString(calendar.get(Calendar.HOUR_OF_DAY)));
 		times.append(":");
 		if((calendar.get(Calendar.MINUTE))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.MINUTE)));
 		times.append(":");
 		if((calendar.get(Calendar.SECOND))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.SECOND)));
 		times.append("]");
 		
 		return times.toString();
    }

    private void writeLog(String file_path) throws Exception
    {

        File file = new File(file_path);
        file.createNewFile();

        FileWriter file2 = new FileWriter(file_path+"/noti_input_"+getDate()+".log", true);


        file2.write("\n************************************************\n");
        file2.write("PageCall time : " 	+ getTime());
        file2.write("\n P_TID : " 	+ P_TID);
	file2.write("\n P_MID : " 	+ P_MID);
	file2.write("\n P_AUTH_DT : " 	+ P_AUTH_DT);
	file2.write("\n P_STATUS : " 	+ P_STATUS);
	file2.write("\n P_TYPE : " 	+ P_TYPE);
	file2.write("\n P_OID : " 	+ P_OID);
	file2.write("\n P_FN_CD1 : " 	+ P_FN_CD1);
	file2.write("\n P_FN_CD2 : " 	+ P_FN_CD2);
	file2.write("\n P_FN_NM : " 	+ P_FN_NM);
	file2.write("\n P_AMT : " 	+ P_AMT);
	file2.write("\n P_UNAME : " 	+ P_UNAME);
	file2.write("\n P_RMESG1 : " 	+ P_RMESG1);
	file2.write("\n P_RMESG2 : " 	+ P_RMESG2);
	file2.write("\n P_NOTI : " 	+ P_NOTI);	
	file2.write("\n P_AUTH_NO : " +	 P_AUTH_NO);	        
        file2.write("\n************************************************\n");

        file2.close();

    }
%>

