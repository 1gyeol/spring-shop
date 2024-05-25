package com.coor.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.coor.domain.ContactVO;
import com.coor.domain.MemberVO;
import com.coor.dto.Criteria;
import com.coor.dto.OrderListDTO;
import com.coor.dto.PageDTO;
import com.coor.service.ContactService;
import com.coor.service.OrderService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/help/*")
public class ContactController {
   private static final Logger log = Logger.getLogger(ContactController.class);
   

	@Setter(onMethod_ = {@Autowired})
	private ContactService contactService;

	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;
	
	//업로드폴더 주입
	@Resource(name = "uploadPath") // servlet-context.xml 참조.
	private String uploadPath;  // C:\\dev\\upload\\pds\\
	
	//CkEditor 업로드폴더
	@Resource(name = "uploadCkEditorPath") // 
	private String uploadCkEditorPath;  // C:\\dev\\upload\\ckeditor\\
		

	// help 폼
   @GetMapping("/help")
   public void help() {
      log.info("help 페이지");
   }

   // 이미지 매핑 주소
   @ResponseBody
   @GetMapping("/displayImage")
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
   }

   
    //CKEditor에서 파일업로드 기능사용 : 파일이 업로드되고, 업로드한 파일정보를 CKEditor에 돌려준다.
 	// HttpServletRequest req : request객체
 	// HttpServletResponse res : response객체
 	// <input type="file" name="upload" size="38">
 	@PostMapping("/imageUpload")
 	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
 		
 		OutputStream out = null;
 		PrintWriter printWriter = null;
 		
 		// 클라이언트에게 보내는 정보에 설명.
 		res.setCharacterEncoding("utf-8");
 		res.setContentType("text/html; charset=utf-8");
 		
 		try {
 			// 1)업로드 작업
 			String fileName = upload.getOriginalFilename(); // 클라이언트에서 보낸 파일이름.
 			byte[] bytes = upload.getBytes(); // 클라이언트에서 보낸 업로드되는 파일을 바이트배열로 확보.
 			
 			String uploadPath = uploadCkEditorPath + fileName;
 			
 			log.info("파일업로드: " + uploadPath);
 			
 			out = new FileOutputStream(new File(uploadPath));
 			out.write(bytes);
 			out.flush();
 			
 			// 2)업로드된 파일정보를 CKEditor 에게 보내는 작업.
 			printWriter = res.getWriter();
 			
 			// 1)톰캣 Context Path에서 Add External Web Module 작업을 해야 함.
 			// Path : /upload, Document Base : C:\\dev\\upload\\ckeditor 설정
 			// 2)Tomcat server.xml에서 <Context docBase="업로드경로" path="/upload" reloadable="true"/>
 			
 			String fileUrl = "/upload/" + fileName;
 			// "filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"
 			printWriter.println("{\"filename\":\"" +  fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"");
 			printWriter.flush();
 			
 		}catch(Exception ex) {
 			ex.printStackTrace();
 		}finally {
 			if(out != null) {
 				try {
 					out.close();
 				}catch(Exception ex) {
 					ex.printStackTrace();
 				}
 			}
 			if(printWriter != null) printWriter.close();
 		}
 	}

 	// 문의하기 폼
   @GetMapping("/contact")
   public void contact(HttpSession session, Model model) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      List<OrderListDTO> orderList = orderService.contactOrder(mb_id);
      orderList.forEach((vo) -> {
         vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      });
      model.addAttribute("orderList", orderList);
   }

   // 문의하기
   @PostMapping("/contact")
   public String create(ContactVO vo, HttpSession session, RedirectAttributes rttr) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      vo.setMb_id(mb_id);
      
      log.info("문의 : " + vo);
      
      contactService.insert(vo);
      rttr.addFlashAttribute("result", vo.getContact_num());
      
      return "redirect:/help/contact_list";
   }

   @GetMapping("/contact_list")
   public void contact_list(@ModelAttribute("cri") Criteria cri, Model model, HttpSession session) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      List<ContactVO> contactList = contactService.contact_list(cri, mb_id);
      model.addAttribute("contactList", contactList);
      
      int totalCount = contactService.getTotalCount(cri, mb_id);
      PageDTO pageDTO = new PageDTO(totalCount, cri);
      model.addAttribute("pageMaker", pageDTO);
   }

}
