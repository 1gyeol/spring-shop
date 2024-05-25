package com.coor.service;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;
import java.util.List;

public interface AdContactService {
   List<ContactVO> contact_list(Criteria cri);

   int getTotalCount(Criteria cri);

   ContactVO getContact(Long contact_num);

   void reply(ContactVO vo);

   void delete(Long contact_num);

   void checked_delete(List<Long> contact_num_arr);
}
