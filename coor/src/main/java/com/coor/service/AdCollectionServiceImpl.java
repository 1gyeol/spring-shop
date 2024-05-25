package com.coor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coor.domain.CollectionVO;
import com.coor.dto.Criteria;
import com.coor.mapper.AdCollectionMapper;

import lombok.Setter;

@Service
public class AdCollectionServiceImpl implements AdCollectionService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private AdCollectionMapper adCollectionMapper;
   
   @Override
   public void col_insert(CollectionVO vo) {
      adCollectionMapper.col_insert(vo);
   }
   
   @Override
   public CollectionVO getCollection(Integer col_num) {
      return adCollectionMapper.getCollection(col_num);
   }
   
   @Override
   public List<CollectionVO> getListWithPaging(Criteria cri) {
      return adCollectionMapper.getListWithPaging(cri);
   }
   
   @Override
   public int getTotalCount(Criteria cri) {
      return adCollectionMapper.getTotalCount(cri);
   }
   
   @Override
   public void col_modify(CollectionVO vo) {
      adCollectionMapper.col_modify(vo);
   }
   
   @Override
   public void col_delete(Integer col_num) {
      adCollectionMapper.col_delete(col_num);
   }
   
   @Override
   public void col_checked_modify(List<CollectionVO> col_list) {
      adCollectionMapper.col_checked_modify(col_list);
   }
   
   @Override
   public void col_checked_delete(List<Integer> col_num_arr) {
      adCollectionMapper.col_checked_delete(col_num_arr);
   }

}
