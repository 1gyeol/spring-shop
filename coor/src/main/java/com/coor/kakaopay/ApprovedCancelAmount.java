package com.coor.kakaopay;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApprovedCancelAmount {
	  private int total;
	  
	  private int tax_free;
	  
	  private int vat;
	  
	  private int point;
	  
	  private int discount;
	  
	  private int green_deposit;
}
