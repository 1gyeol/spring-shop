package com.coor.service;

import com.coor.domain.ReviewVO;
import com.coor.dto.Criteria;
import com.coor.mapper.ProductMapper;
import com.coor.mapper.ReviewMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private ReviewMapper reviewMapper;
   
   @Override
   public List<ReviewVO> review_list(Criteria cri, int pro_num) {
      return reviewMapper.review_list(cri, pro_num);
   }
   
   @Override
   public int review_count(int pro_num) {
      return reviewMapper.review_count(pro_num);
   }
   
   @Override
   public void create(ReviewVO vo) {
      reviewMapper.create(vo);
   }
   
   @Override
   public void modify(ReviewVO vo) {
      reviewMapper.modify(vo);
   }
   
   @Override
   public void delete(Long rew_num) {
      reviewMapper.delete(rew_num);
   }

}
