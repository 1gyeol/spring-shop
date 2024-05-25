package com.coor.mapper;

import java.util.List;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;

public interface AdContactMapper {
	
	/* 문의 조회 */
	List<ContactVO> contact_list(Criteria cri);
	int getTotalCount(Criteria cri);

	/* 문의 상세 조회 */
	ContactVO getContact(Long contact_num);
	  
	/* 문의 답변 */
	void reply(ContactVO vo);
	  
	/* 문의 삭제 */
	void delete(Long contact_num);
	  
	/* 문의 체크 삭제*/
	void checked_delete(List<Long> contact_num_arr);
}
