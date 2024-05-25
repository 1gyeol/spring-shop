package com.coor.controller;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;
import com.coor.dto.PageDTO;
import com.coor.service.AdContactService;
import com.coor.service.AdProductService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Log4j
@Controller
@RequestMapping("/admin/contact/*")
public class AdContactController {
	
   @Setter(onMethod_= {@Autowired})
   private AdContactService adContactService;

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
   @GetMapping({"/displayImage"})
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
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

   // 상세 문의
   @GetMapping("/contact_detail")
   public void contact_detail(Long contact_num, Model model) {
      ContactVO vo = adContactService.getContact(contact_num);
      model.addAttribute("contactVO", vo);
   }

   // 문의 답변
   @PostMapping("/contact_reply")
   public String contact_reply(ContactVO vo, RedirectAttributes rttr) {
      log.info(vo);
      adContactService.reply(vo);
      rttr.addFlashAttribute("msg", "success");
      return "redirect:/admin/contact/contact_list/";
   }

   // 문의 삭제
   @PostMapping({"/contact_delete"})
   public String contact_delete(Long contact_num, Criteria cri, RedirectAttributes rttr) {
      log.info("문의코드 : " + contact_num);
      adContactService.delete(contact_num);
      rttr.addFlashAttribute("msg", "delete");
      return "redirect:/admin/contact/contact_list";
   }

   // 문의하기 리스트 
   @GetMapping("/contact_list")
   public void contact_list(@ModelAttribute("cri") Criteria cri, Model model) {
	   
      List<ContactVO> contactList = adContactService.contact_list(cri);
      model.addAttribute("contactList", contactList);
      
      int totalCount = adContactService.getTotalCount(cri);
      PageDTO dto = new PageDTO(totalCount, cri);
      model.addAttribute("pageMaker", dto);
   }

   // 문의 체크 리스트 삭제
   @ResponseBody
   @PostMapping("/checked_delete")
   public ResponseEntity<String> checked_modify(@RequestParam("contact_num_arr[]") List<Long> contact_num_arr) {
      ResponseEntity<String> entity = null;
      adContactService.checked_delete(contact_num_arr);
      entity = new ResponseEntity("success", HttpStatus.OK);

      for(int i = 0; i < contact_num_arr.size(); ++i) {
      }

      return entity;
   }
}
