package com.coor.service;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;
import java.util.List;

public interface ProductService {
	
   /*카테고리 리스트 조회*/
   List<CategoryVO> subCategoryList(Integer cat_code);
   List<CategoryVO> subCategoryList2();

   /*카테고리 정보*/
   CategoryVO getCatCode(Integer cat_code);
   CategoryVO getPrtCode(Integer cat_code);

   /*카테고리별 상품 조회*/
   List<ProductVO> getListWithPaging(Criteria cri, Integer cat_code);
   int getTotalCount(Criteria cri, Integer cat_code);
	  
   /*상품 상세 정보*/
   ProductVO getProduct(Integer pro_num);
}
