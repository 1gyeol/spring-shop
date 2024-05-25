package com.coor.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	  private int rn;	  
	  private String mb_id;	  
	  private String mb_pw;	  
	  private String mb_name;	  
	  private String mb_phone;	  
	  private String mb_zipcode;	  
	  private String mb_addr;	  
	  private String mb_deaddr;	  
	  private String mb_email;	  
	  private String mb_birth;	  
	  private Date mb_regdate;	  
	  private Date mb_updatedate;	  
	  private Date mb_lastdate;	  
	  private Date mb_deletedate;	  
	  private int cart_amount;
}
