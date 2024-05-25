package com.coor.mapper;

import java.util.List;

import com.coor.domain.CollectionVO;
import com.coor.dto.Criteria;

public interface AdCollectionMapper {
	
	/* 컬렉션 추가 */
	void col_insert(CollectionVO vo);
	  
	/* 컬렉션 조회 */
	CollectionVO getCollection(Integer col_num);
	
	/* 컬렉션 리스트 조회 */
	List<CollectionVO> getListWithPaging(Criteria cri);	 
	int getTotalCount(Criteria cri);
	  
	/* 컬렉션 수정 */
	void col_modify(CollectionVO vo);	   
	void col_checked_modify(List<CollectionVO> col_list);
	

	/* 컬렉션 삭제 */
	void col_delete(Integer col_num);
	void col_checked_delete(List<Integer> col_num_arr);

	  
}
