package com.coor.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderListDTO {
	  private int rn;
	  
	  private Long ord_code;
	  
	  private String mb_id;
	  
	  private String ord_name;
	  
	  private String pay_method;
	  
	  private int ord_price;
	  
	  private String ord_cancel;
	  
	  private Date ord_canceldate;
	  
	  private Date ord_regdate;
	  
	  private int ordt_amount;
	  
	  private int pro_num;
	  
	  private String pro_name;
	  
	  private String pro_up_folder;
	  
	  private String pro_up_img;
	  
	  private int totalPrice;
	  
	  private int totalCount;
}
