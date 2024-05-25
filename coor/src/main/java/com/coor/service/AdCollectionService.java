package com.coor.service;

import com.coor.domain.CollectionVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;
import java.util.List;

public interface AdCollectionService {
	
   void col_insert(CollectionVO vo);

   CollectionVO getCollection(Integer col_num);

   List<CollectionVO> getListWithPaging(Criteria cri);

   int getTotalCount(Criteria cri);

   void col_modify(CollectionVO vo);

   void col_delete(Integer col_num);

   void col_checked_modify(List<CollectionVO> col_list);

   void col_checked_delete(List<Integer> col_num_arr);
}
