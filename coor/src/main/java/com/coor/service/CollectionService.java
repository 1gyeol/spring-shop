package com.coor.service;

import com.coor.domain.CollectionVO;
import java.util.List;

public interface CollectionService {


	/* 컬렉션 조회 */	
	CollectionVO getCollection(Integer col_num);
	List<CollectionVO> getCollectionList();
}
