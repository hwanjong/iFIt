package com.hwan.service;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

@Service
public class MyMailSender {
	private MailSender mailSender;

	public void sendMailToUser(String to, String subject, String msg){
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			
			message.setFrom("dobepartners@gmail.com");
			message.setTo(to);
			message.setSubject(subject);
			message.setText(msg);
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}
	public void sendMailToAdmin(String from, String subject, String msg){
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			
			message.setFrom(from);
			message.setTo("jhkim@dobepartners.com");
			message.setSubject(subject);
			message.setText(msg);
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}
	
	public MailSender getMailSender() {
		return mailSender;
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	
}
