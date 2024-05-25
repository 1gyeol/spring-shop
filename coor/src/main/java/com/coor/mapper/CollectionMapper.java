package com.coor.mapper;

import java.util.List;

import com.coor.domain.CollectionVO;

public interface CollectionMapper {
	
	/* 컬렉션 조회 */	
	CollectionVO getCollection(Integer col_num);
	List<CollectionVO> getCollectionList();
}
