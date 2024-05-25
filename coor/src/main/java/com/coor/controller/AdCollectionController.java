package com.coor.controller;

import com.coor.domain.CollectionVO;
import com.coor.dto.Criteria;
import com.coor.dto.PageDTO;
import com.coor.service.AdChartService;
import com.coor.service.AdCollectionService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/collection/*")
public class AdCollectionController {
	
   @Setter(onMethod_ = {@Autowired})
   private AdCollectionService adCollectionService;

   //CkEditor 업로드 경로 주입
   @Resource(name = "uploadCkEditorPath")
   private String uploadCkEditorPath;

   @GetMapping("/col_insert")
   public void col_insert() {}

   @PostMapping("/col_insert")
   public String col_insert(CollectionVO vo) {
      adCollectionService.col_insert(vo);
      
      return "redirect:/admin/collection/col_list";
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
         
         String uploadPath = uploadCkEditorPath + fileName;
        
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

   // 컬렉션 리스트
   @GetMapping("/col_list")
   public void col_list(@ModelAttribute("cri") Criteria cri, Model model) {
      
      List<CollectionVO> colList = adCollectionService.getListWithPaging(cri);
      model.addAttribute("colList", colList);
      
      int totalCount = adCollectionService.getTotalCount(cri);
      PageDTO dto = new PageDTO(totalCount, cri);
      model.addAttribute("pageMaker", dto);
   }

   // 컬렉션 상세정보
   @GetMapping("/col_modify")
   public void col_modify(Integer col_num, Model model) {
      CollectionVO vo = adCollectionService.getCollection(col_num);
      model.addAttribute("collectionVO", vo);
   }

   // 컬렉션 수정
   @PostMapping("/col_modify")
   public String col_modify(CollectionVO vo) {
	   
      adCollectionService.col_modify(vo);
      
      return "redirect:/admin/collection/col_list";
   }

   // 컬렉션 삭제
   @GetMapping("/col_delete")
   public String col_delete(Integer col_num, Criteria cri, RedirectAttributes rttr) {
      
	  adCollectionService.col_delete(col_num);
      rttr.addFlashAttribute("msg", "delete");
      
      return "redirect:/admin/collection/col_list";
   }

}
