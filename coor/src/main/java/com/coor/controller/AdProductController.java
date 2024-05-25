package com.coor.controller;

import com.coor.domain.CategoryVO;
import com.coor.domain.ProductVO;
import com.coor.dto.Criteria;
import com.coor.dto.PageDTO;
import com.coor.service.AdProductService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Log4j
@Controller
@RequestMapping("/admin/product/*")
public class AdProductController {

   @Setter(onMethod_= {@Autowired})
   private AdProductService adProductService;
   

   //업로드 경로 주입
   @Resource(name = "uploadPath")
   private String uploadPath;
   

   //CkEditor 업로드 경로 주입
   @Resource(name = "uploadCkEditorPath")
   private String uploadCkEditorPath;

   // 이미지 매핑주소
   @ResponseBody
   @GetMapping("/displayImage")
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
   }

   //카테고리 정보
   @ResponseBody
   @GetMapping("/subCategory/{cat_code}")
   public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cat_code") Integer cat_code) {
      ResponseEntity<List<CategoryVO>> entity = null;
      entity = new ResponseEntity(adProductService.subCategoryList(cat_code), HttpStatus.OK);
      return entity;
   }

   @GetMapping("/pro_insert")
   public void product_insert() {
      log.info("제품 추가 폼");
   }

   @PostMapping("/pro_insert")
   public String product_insert(ProductVO vo, RedirectAttributes rttr) {
      String uploadDateFolder = FileUtils.getFolder();
      String uploadImageName = FileUtils.uploadFile(this.uploadPath, uploadDateFolder, vo.getUploadFile());
      vo.setPro_up_folder(uploadDateFolder);
      vo.setPro_up_img(uploadImageName);
      log.info("상품 정보: " + vo);
      adProductService.pro_insert(vo);
      return "redirect:/admin/product/pro_list";
   }

// CKEditor에서 파일업로드 기능사용 : 파일이 업로드되고, 업로드한 파일정보를 CKEditor에 돌려준다.
   // HttpServletRequest req : request객체
   // HttpServletResponse res : response객체
   @PostMapping("/imageUpload")
   public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
      
	  OutputStream out = null;
      PrintWriter printWriter = null;

	  // 클라이언트에게 보내는 정보에 설명.
      res.setCharacterEncoding("utf-8");
      res.setContentType("text/html; charset=utf-8");

      try {
	     // 1)업로드 작업
         String fileName = upload.getOriginalFilename();
         byte[] bytes = upload.getBytes();
         
         String uploadPath = this.uploadCkEditorPath + fileName;
        
         out = new FileOutputStream(new File(uploadPath));
         out.write(bytes);
         out.flush();
         
         // 2)업로드된 파일정보를 CKEditor 에게 보내는 작업.
         printWriter = res.getWriter();
         

		// 1)톰캣 Context Path에서 Add External Web Module 작업을 해야 함.
		// Path : /upload, Document Base : C:\\dev\\upload\\ckeditor 설정
		// 2)Tomcat server.xml에서 <Context docBase="업로드경로" path="/upload" reloadable="true"/>
         String fileUrl = "/upload/" + fileName;
         printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
         printWriter.flush();
         
      } catch (Exception ex) {
    	  
         ex.printStackTrace();
         
      } finally {
         if (out != null) {
            try {
               out.close();
            } catch (Exception ex) {
               ex.printStackTrace();
            }
         }

         if (printWriter != null) {
            printWriter.close();
         }

      }

   }

   // 상품 상세 정보
   @GetMapping({"/pro_modify"})
   public void product_modify(Integer pro_num, Model model) {
      ProductVO vo = adProductService.getProduct(pro_num);
      vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      model.addAttribute("productVO", vo);
      model.addAttribute("subCategoryList", adProductService.subCategoryList(vo.getCat_prtcode()));
   }

   // 상품 정보 수정
   @PostMapping({"/pro_modify"})
   public String product_modify(ProductVO vo, RedirectAttributes rttr) {
      if (!vo.getUploadFile().isEmpty()) {
         FileUtils.deleteFile(this.uploadPath, vo.getPro_up_folder(), vo.getPro_up_img());
         String uploadDateFolder = FileUtils.getFolder();
         String saveImageName = FileUtils.uploadFile(this.uploadPath, uploadDateFolder, vo.getUploadFile());
         vo.setPro_up_img(saveImageName);
         vo.setPro_up_folder(uploadDateFolder);
      }

      log.info("상품 정보: " + vo);
      adProductService.pro_modify(vo);
      rttr.addFlashAttribute("msg", "modify");
      return "redirect:/admin/product/pro_list";
   }

   // 상품 삭제
   @PostMapping("/pro_delete")
   public String pro_delete(Integer pro_num, Criteria cri, RedirectAttributes rttr) {
      log.info("상품코드 : " + pro_num);
      adProductService.pro_delete(pro_num);
      rttr.addFlashAttribute("msg", "delete");
      return "redirect:/admin/product/pro_list";
   }

   // 상품 리스트
   @GetMapping("/pro_list")
   public void product_list(@ModelAttribute("cri") Criteria cri, Model model) {
      log.info("cri: " + cri);
      List<CategoryVO> cateList = adProductService.getCategoryList();
      log.info("카테고리 리스트 : " + cateList);
      model.addAttribute("cateList", cateList);
      List<ProductVO> proList = adProductService.getListWithPaging(cri);
      log.info(proList);
      proList.forEach((vo) -> {
         vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      });
      model.addAttribute("proList", proList);
      int totalCount = adProductService.getTotalCount(cri);
      PageDTO dto = new PageDTO(totalCount, cri);
      model.addAttribute("pageMaker", dto);
   }

   // 체크 상품리스트 수정
   @ResponseBody
   @PostMapping({"/pro_checked_modify"})
   public ResponseEntity<String> pro_checked_modify(@RequestParam("pro_num_arr[]") List<Integer> pro_num_arr, @RequestParam("pro_price_arr[]") List<Integer> pro_price_arr, @RequestParam("pro_buy_arr[]") List<String> pro_buy_arr, @RequestParam("pro_show_arr[]") List<String> pro_show_arr) {
      ResponseEntity<String> entity = null;
      log.info("수정상품코드: " + pro_num_arr);
      log.info("수정상품가격: " + pro_price_arr);
      log.info("수정상품판매여부: " + pro_buy_arr);
      log.info("수정상품게시노출여부: " + pro_show_arr);
      List<ProductVO> pro_list = new ArrayList();

      for(int i = 0; i < pro_num_arr.size(); ++i) {
         ProductVO productVO = new ProductVO();
         productVO.setPro_num((Integer)pro_num_arr.get(i));
         productVO.setPro_price((Integer)pro_price_arr.get(i));
         productVO.setPro_buy((String)pro_buy_arr.get(i));
         productVO.setPro_show((String)pro_show_arr.get(i));
         pro_list.add(productVO);
      }

      adProductService.pro_checked_modify(pro_list);
      entity = new ResponseEntity("success", HttpStatus.OK);
      return entity;
   }

   // 체크 상품리스트 삭제
   @ResponseBody
   @PostMapping({"/pro_checked_delete"})
   public ResponseEntity<String> pro_checked_modify(@RequestParam("pro_num_arr[]") List<Integer> pro_num_arr) {
      ResponseEntity<String> entity = null;
      adProductService.pro_checked_delete(pro_num_arr);
      entity = new ResponseEntity("success", HttpStatus.OK);

      for(int i = 0; i < pro_num_arr.size(); ++i) {
      }

      return entity;
   }

}
