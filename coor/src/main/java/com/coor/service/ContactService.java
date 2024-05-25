package com.coor.service;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;
import java.util.List;

public interface ContactService {
	
   /* 회원별 문의하기 조회 */
   List<ContactVO> contact_list(Criteria cri, String mb_id);
   int getTotalCount(Criteria cri, String mb_id);

   /* 회원별 총 문의 수*/
   int getMbContactCount(String mb_id);

   /* 문의 내용 */
   ContactVO getContact(Long contact_num);

   /* 문의하기*/
   void insert(ContactVO vo);

   /* 문의 수정*/
   void modify(ContactVO vo);

   /* 문의 삭제*/
   void delete(Long contact_num);
}
