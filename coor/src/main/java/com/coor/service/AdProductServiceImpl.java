package com.coor.service;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;
import com.coor.mapper.AdOrderMapper;
import com.coor.mapper.AdProductMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdProductServiceImpl implements AdProductService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private AdProductMapper adProductMapper;
   
   
   @Override
   public List<CategoryVO> getCategoryList() {
      return adProductMapper.getCategoryList();
   }
   
   @Override
   public List<CategoryVO> subCategoryList(Integer cat_code) {
      return adProductMapper.subCategoryList(cat_code);
   }
   
   @Override
   public void pro_insert(ProductVO vo) {
      adProductMapper.pro_insert(vo);
   }
   
   @Override
   public ProductVO getProduct(Integer pro_num) {
      return adProductMapper.getProduct(pro_num);
   }
   
   @Override
   public void pro_modify(ProductVO vo) {
      adProductMapper.pro_modify(vo);
   }
   
   @Override
   public void pro_delete(Integer pro_num) {
      adProductMapper.pro_delete(pro_num);
   }
   
   @Override
   public void pro_checked_modify(List<ProductVO> pro_list) {
      adProductMapper.pro_checked_modify(pro_list);
   }
   
   @Override
   public void pro_checked_delete(List<Integer> pro_num_arr) {
      adProductMapper.pro_checked_delete(pro_num_arr);
   }
   
   @Override
   public List<ProductVO> getListWithPaging(Criteria cri) {
      return adProductMapper.getListWithPaging(cri);
   }
   
   @Override
   public int getTotalCount(Criteria cri) {
      return adProductMapper.getTotalCount(cri);
   }
   
   @Override
   public CategoryVO get(int cat_code) {
      return adProductMapper.get(cat_code);
   }

}
