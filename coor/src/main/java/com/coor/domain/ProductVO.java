package com.coor.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductVO {
	  private Integer pro_num;
	  
	  private int cat_code;
	  
	  private int cat_prtcode;
	  
	  private String cat_name;
	  
	  private String pro_name;
	  
	  private int pro_price;
	  
	  private int pro_discount;
	  
	  private int pro_dis_price;
	  
	  private String pro_content;
	  
	  private String pro_up_folder;
	  
	  private String pro_up_img;
	  
	  private int pro_amount;
	  
	  private String pro_buy;
	  
	  private String pro_show;
	  
	  private Date pro_date;
	  
	  private Date pro_updatedate;
	  
	  private String pro_img_content;
	  
	  private int pro_size_s;
	  
	  private int pro_size_m;
	  
	  private int pro_size_l;
	  
	  private int pro_size_free;
	  
	  private MultipartFile uploadFile;
}
