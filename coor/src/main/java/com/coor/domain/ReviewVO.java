package com.coor.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewVO {
	  private Integer rew_num;
	  
	  private int pro_num;
	  
	  private String mb_id;
	  
	  private int rew_score;
	  
	  private String rew_title;
	  
	  private String rew_content;
	  
	  private Date rew_regdate;
	  
	  private int rn;
}
