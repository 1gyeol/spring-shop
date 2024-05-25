package com.coor.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetailVO {
	  private Long ord_code;
	  
	  private String ord_name;
	  
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
	  
	  private String ord_zipcode;
	  
	  private String ord_addr;
	  
	  private String ord_deaddr;
	  
	  private int pro_discount;
	  
	  private int pro_dis_price;
	  
	  private int pay_price;
	  
	  private String pay_method;
	  
	  private Date pay_date;
	  
	  private int totalPrice;
	  
	  private int totalCount;
}
