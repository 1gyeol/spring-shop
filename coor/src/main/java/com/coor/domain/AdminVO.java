package com.coor.domain;

import java.util.Date;

import lombok.Getter;
import lombok.ToString;
import lombok.Setter;

@Getter
@Setter
@ToString
public class AdminVO {
   private String admin_id;
   private String admin_pw;
   private String admin_name;
   private Date admin_date;
   private Date admin_visit_date;

}
