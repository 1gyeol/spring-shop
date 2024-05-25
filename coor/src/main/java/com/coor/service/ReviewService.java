package com.coor.service;

import com.coor.domain.ReviewVO;
import com.coor.dto.Criteria;
import java.util.List;

public interface ReviewService {
	
   /* 상품별 리뷰 리스트*/
   List<ReviewVO> review_list(Criteria cri, int pro_num);
   int review_count(int pro_num);
   
   /* 리뷰 추가 */
   void create(ReviewVO vo);

   /* 리뷰 수정 */
   void modify(ReviewVO vo);

   /* 리뷰 삭제 */
   void delete(Long rew_num);
}
