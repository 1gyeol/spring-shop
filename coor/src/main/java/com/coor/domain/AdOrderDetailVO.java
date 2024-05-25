package com.coor.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdOrderDetailVO {
	
	 private Long ord_code;		  
	 private Integer pro_num;	  
	 private int ordt_amount;	  
	 private int ordt_price;	  
	 private String pro_name;	  
	 private String pro_up_folder;	  
	 private String pro_up_img;	  
	 private int pro_price;	  
	 private int cart_amount;	  
	 private int unitprice;	  
	 private String ord_cancel;	  
	 private Date ord_regdate;	  
	 
	 private int pro_discount;	  
	 private int pro_dis_price;
	 
	 private int pay_price;	  
	 private String pay_method;	  
	 private Date pay_date;
}
