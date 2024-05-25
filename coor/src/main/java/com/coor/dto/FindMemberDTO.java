package com.coor.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FindMemberDTO {

	  private String mb_id;
	  
	  private String mb_pw;
	  
	  private String mb_name;
	  
	  private String mb_phone;
	  
	  private String mb_email;
}
