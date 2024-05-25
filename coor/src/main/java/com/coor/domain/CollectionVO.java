package com.coor.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CollectionVO {
	
	  private Integer col_num;	  
	  private String col_name;	  
	  private String col_content;	  
	  private String col_show;	  
	  private Date col_regdate;	  
	  private Date col_updatedate;	  
	  private int rn;
}
