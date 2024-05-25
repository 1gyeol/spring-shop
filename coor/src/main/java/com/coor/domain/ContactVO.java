package com.coor.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ContactVO {
	  private int rn;	   
	  private Long contact_num;	  
	  private String mb_id;	  
	  private int pro_num;	  
	  private int ord_code;	  
	  private String contact_type;	  
	  private String contact_title;	  
	  private String contact_content;
	  private String contact_re;	  
	  private String contact_status;	  
	  private Date contact_regdate;	  
	  private Date contact_updatedate;	  
	  private Date contact_re_date;
}
