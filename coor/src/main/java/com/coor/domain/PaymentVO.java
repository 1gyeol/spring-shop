package com.coor.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentVO {
	  private Integer pay_code;
	  
	  private long ord_code;
	  
	  private String tid;
	  
	  private String mb_id;
	  
	  private String pay_method;
	  
	  private int pay_price;
	  
	  private String pay_user;
	  
	  private String pay_bank;
	  
	  private Date pay_date;
	  
	  private String pay_memo;
}
