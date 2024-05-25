package com.coor.mapper;

import java.util.List;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;

public interface AdProductMapper {

	  /* 카테고리 리스트 조회 */
	  List<CategoryVO> getCategoryList();	  
	  List<CategoryVO> subCategoryList(Integer cat_code);
	  
	  /* 상품 추가 */
	  void pro_insert(ProductVO vo);
	  
	  /* 상품 상세 정보 */
	  ProductVO getProduct(Integer pro_num);
	  
	  /* 상품 수정 */
	  void pro_modify(ProductVO vo);
	  void pro_checked_modify(List<ProductVO> paramList);
	  
	  
	  /* 상품 삭제*/
	  void pro_delete(Integer pro_num);	  
	  void pro_checked_delete(List<Integer> paramList);
	  
	  /* 상품 리스트*/
	  List<ProductVO> getListWithPaging(Criteria cri);	  
	  int getTotalCount(Criteria cri);
	  
	  CategoryVO get(int paramInt);
}
