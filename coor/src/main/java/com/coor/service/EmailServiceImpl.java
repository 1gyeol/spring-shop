package com.coor.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.coor.dto.EmailDTO;

import lombok.Setter;

@Service
public class EmailServiceImpl implements EmailService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private JavaMailSender mailSender;
   

   public void sendMail(EmailDTO dto, String content) {
      
	  MimeMessage msg = this.mailSender.createMimeMessage();

      try {
		// 받는사람의 메일주소
		msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiverMail()));
		// 보내는 사람(메일, 이름)
		msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
		//메일제목
		msg.setSubject(dto.getSubject(), "utf-8");
		// 본문내용
		msg.setText(content, "utf-8");
		
		mailSender.send(msg);
      } catch (Exception ex) {
    	  
         ex.printStackTrace();
         
      }

   }

}
