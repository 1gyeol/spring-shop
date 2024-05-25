package com.coor.service;

import com.coor.domain.AdminVO;

public interface AdminService {
	
   AdminVO admin_ok(String admin_id);

   void now_visit(String admin_id);
}
