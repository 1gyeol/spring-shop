package com.coor.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString	
public class CartVO {
	 private Long cart_code;
	 private int pro_num;
	 private String mb_id;
	 private int cart_amount;
}
