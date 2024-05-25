package com.coor.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderVO {
	  private Long ord_code;
	  
	  private String mb_id;
	  
	  private String ord_name;
	  
	  private String ord_zipcode;
	  
	  private String ord_addr;
	  
	  private String ord_deaddr;
	  
	  private String ord_tel;
	  
	  private int ord_price;
	  
	  private String ord_cancel;
	  
	  private Date ord_canceldate;
	  
	  private Date ord_regdate;
	  
	  private String pay_method;
	  
	  private int pro_num;
	  
	  private String ordt_name;
	  
	  private String ordt_price;
}
