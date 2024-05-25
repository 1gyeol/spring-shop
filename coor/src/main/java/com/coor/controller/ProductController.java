package com.coor.controller;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;
import com.coor.dto.PageDTO;
import com.coor.service.AdProductService;
import com.coor.service.ProductService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Log4j
@RequestMapping("/product/*")
@Controller
public class ProductController {
	
	@Setter(onMethod_ = {@Autowired})
	private ProductService productService;

	@Setter(onMethod_ = {@Autowired})
    private AdProductService adProductService;

	//업로드폴더 주입
	@Resource(name = "uploadPath") // servlet-context.xml 참조.
	private String uploadPath;  // C:\\dev\\upload\\pds\\
	

	// 하위 카테고리
   @ResponseBody
   @GetMapping("/subCategory/{cat_code}")
   public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("cat_code") Integer cat_code) {
      ResponseEntity<List<CategoryVO>> entity = null;
      entity = new ResponseEntity(productService.subCategoryList(cat_code), HttpStatus.OK);
      return entity;
   }

   //이미지 매핑 정보
   @ResponseBody
   @GetMapping("/displayImage")
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
   }

   // 카테고리별 리스트
   @GetMapping("/pro_list/{cat_code}")
   public String product_list(@ModelAttribute("cri") Criteria cri, @PathVariable("cat_code") Integer cat_code, Model model) {
      model.addAttribute("cat_code", productService.getCatCode(cat_code));
      model.addAttribute("cat_prtcode", productService.getPrtCode(cat_code));
      List<ProductVO> proList = productService.getListWithPaging(cri, cat_code);
      proList.forEach((vo) -> {
         vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      });
      model.addAttribute("proList", proList);
      int totalCount = productService.getTotalCount(cri, cat_code);
      PageDTO dto = new PageDTO(totalCount, cri);
      model.addAttribute("pageMaker", dto);
      return "/product/pro_list";
   }

   // 상품 정보
   @GetMapping("/pro_detail")
   public void pro_detail(Integer pro_num, @ModelAttribute("cri") Criteria cri, Model model) {
      ProductVO vo = productService.getProduct(pro_num);
      vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      model.addAttribute("productVO", vo);
   }

   // 상품 정보
   @GetMapping("/pro_detail/{pro_num}")
   public String pro_detail(@PathVariable("pro_num") Integer pro_num, Model model) {
      log.info("상품번호 : " + pro_num);
      ProductVO vo = productService.getProduct(pro_num);
      vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      model.addAttribute("productVO", vo);
      return "/product/pro_detail";
   }

}
