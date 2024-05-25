package com.coor.service;

import com.coor.domain.CollectionVO;
import com.coor.mapper.CartMapper;
import com.coor.mapper.CollectionMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CollectionServiceImpl implements CollectionService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private CollectionMapper collectionMapper;
   
   
   @Override
   public CollectionVO getCollection(Integer col_num) {
      return collectionMapper.getCollection(col_num);
   }
   
   @Override
   public List<CollectionVO> getCollectionList() {
      return collectionMapper.getCollectionList();
   }
}
