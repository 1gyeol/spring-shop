package com.coor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coor.domain.AdminVO;
import com.coor.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private AdminMapper adminMapper;
   
   
   @Override
   public AdminVO admin_ok(String admin_id) {
      return adminMapper.admin_ok(admin_id);
   }
   
   @Override
   public void now_visit(String admin_id) {
      adminMapper.now_visit(admin_id);
   }

}
