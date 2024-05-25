package com.coor.service;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;
import com.coor.mapper.OrderMapper;
import com.coor.mapper.ProductMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private ProductMapper productMapper;
   
   
   @Override
   public List<CategoryVO> subCategoryList(Integer cat_code) {
      return productMapper.subCategoryList(cat_code);
   }
   
   @Override
   public List<ProductVO> getListWithPaging(Criteria cri, Integer cat_code) {
      return productMapper.getListWithPaging(cri, cat_code);
   }
   
   @Override
   public int getTotalCount(Criteria cri, Integer cat_code) {
      return productMapper.getTotalCount(cri, cat_code);
   }
   
   @Override
   public List<CategoryVO> subCategoryList2() {
      return productMapper.subCategoryList2();
   }
   
   @Override
   public ProductVO getProduct(Integer pro_num) {
      return productMapper.getProduct(pro_num);
   }
   
   @Override
   public CategoryVO getCatCode(Integer cat_code) {
      return productMapper.getCatCode(cat_code);
   }
   
   @Override
   public CategoryVO getPrtCode(Integer cat_code) {
      return productMapper.getPrtCode(cat_code);
   }

}
