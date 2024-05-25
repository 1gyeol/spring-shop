package com.coor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;

public interface ProductMapper {
	
	  /*카테고리 리스트 조회*/
	  List<CategoryVO> subCategoryList(Integer cat_code);
	  List<CategoryVO> subCategoryList2();
	  
	  /*카테고리 정보*/
	  CategoryVO getCatCode(Integer cat_code);
	  CategoryVO getPrtCode(Integer cat_code);
	  
	  /*카테고리별 상품 조회*/
	  List<ProductVO> getListWithPaging(@Param("cri") Criteria cri, @Param("cat_code") Integer cat_code); 
	  int getTotalCount(@Param("cri") Criteria cri, @Param("cat_code") Integer cat_code);
	  
	  /*상품 조회*/
	  ProductVO getProduct(Integer pro_num);
}
