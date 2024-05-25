package com.coor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;

public interface ContactMapper {
	
	   /* 회원별 문의하기 조회 */
	   List<ContactVO> contact_list(@Param("cri") Criteria cri, @Param("mb_id") String mb_id);
	   int getTotalCount(@Param("cri") Criteria cri, @Param("mb_id") String mb_id);

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
