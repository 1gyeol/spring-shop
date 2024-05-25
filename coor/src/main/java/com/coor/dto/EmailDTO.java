package com.coor.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class EmailDTO {

	private String senderName; // 발신자 이름
	private String senderMail; // 발신자 메일주소
	private String receiverMail; // 수신자 메일주소, 즉 회원메일 주소로 사용
	private String subject; // 제목
	
	public EmailDTO() {
		this.senderName = "test";
	    this.senderMail = "coor";
	    this.subject = "coor 임시비밀번호입니다." ;
	}
}
