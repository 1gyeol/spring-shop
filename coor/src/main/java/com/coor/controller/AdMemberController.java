package com.coor.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.coor.domain.MemberVO;
import com.coor.dto.Criteria;
import com.coor.dto.EmailDTO;
import com.coor.dto.PageDTO;
import com.coor.service.AdMemberService;
import com.coor.service.EmailService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/member/*")
public class AdMemberController {

   @Setter(onMethod_ = {@Autowired})
   private AdMemberService adMemberService;

   @Setter(onMethod_ = {@Autowired})
   private PasswordEncoder passwordEncoder;

   @Setter(onMethod_ = {@Autowired})
   private EmailService emailService;

   
   // 아이디 중복 체크
   @ResponseBody
   @GetMapping("/idCheck")
   public ResponseEntity<String> idCheck(String mb_id) {
      ResponseEntity<String> entity = null;
      String isUse = "";
      if (adMemberService.idCheck(mb_id) != null) {
         isUse = "no";
      } else {
         isUse = "yes";
      }

      entity = new ResponseEntity(isUse, HttpStatus.OK);
      return entity;
   }

   // 회원 추가 폼
   @GetMapping("/member_insert")
   public void member_insert() {
      log.info("회원 추가 폼");
   }

   // 회원 추가 
   @PostMapping("/member_insert")
   public String member_insert(MemberVO vo, RedirectAttributes rttr) {
      log.info("회원 정보 : " + vo);
      String enc_pw = passwordEncoder.encode(vo.getMb_pw());
      vo.setMb_pw(enc_pw);
      adMemberService.mb_insert(vo);
      return "redirect:/admin/member/member_list";
   }

   // 회원 리스트
   @GetMapping("/member_list")
   public void member_list(@ModelAttribute("cri") Criteria cri, Model model) {
      
	  List<MemberVO> memberList = adMemberService.getListWithPaging(cri);
      int totalCount = adMemberService.getTotalCount(cri);
      PageDTO dto = new PageDTO(totalCount, cri);
      log.info("회원 리스트");
      
      model.addAttribute("pageMaker", dto);
      model.addAttribute("memberList", memberList);
   }

   // 탈퇴 회원 리스트
   @GetMapping("/member_del_list")
   public void member_del_list(@ModelAttribute("cri") Criteria cri, Model model) {
      List<MemberVO> memberList = adMemberService.getDelListWithPaging(cri);
      int totalCount = adMemberService.getDelTotalCount(cri);
      PageDTO dto = new PageDTO(totalCount, cri);
      log.info("회원 리스트");
      model.addAttribute("pageMaker", dto);
      model.addAttribute("memberList", memberList);
   }

   // 회원 상세 정보
   @GetMapping("/member_modify")
   public void member_modify(String mb_id, Model model) {
      MemberVO vo = adMemberService.mb_detail(mb_id);
      model.addAttribute("memberVO", vo);
   }

   //회원 정보 수정
   @PostMapping("/member_modify")
   public String member_modify(MemberVO vo, Model model) {
      
      adMemberService.mb_modify(vo);      
      return "redirect:/admin/member/member_list";
   }

   // 임시비밀번호 발급
   @ResponseBody
   @GetMapping("/tempPw")
   public ResponseEntity<String> tempPw(String mb_id, String mb_email) {
      
	  ResponseEntity<String> entity = null;
      
      String msg = "";
      String temp_pw = adMemberService.tempPw();
      String enc_temp_pw = passwordEncoder.encode(temp_pw);
      
      log.info("임시비밀번호 생성 : " + temp_pw);
      log.info("인코딩임시비밀번호 생성 : " + enc_temp_pw);
      
      if (enc_temp_pw != null) {
         msg = "success";
         adMemberService.updateTempPw(mb_id, enc_temp_pw);
         EmailDTO emailDTO = new EmailDTO();
         emailDTO.setReceiverMail(mb_email);
         
         // 이메일 발송 내용
         String content = "안녕하세요. coor입니다.\n" + mb_id + "님의 " + "임시비밀번호는 " + temp_pw + "입니다.";
         emailService.sendMail(emailDTO, content);
         
         System.out.println("이메일 발송성공!");
      } else {
         msg = "fail";
      }

      entity = new ResponseEntity(msg, HttpStatus.OK);
      return entity;
   }

   @GetMapping("/member_del_detail")
   public void member_del_detail(String mb_id, Model model) {
      MemberVO vo = adMemberService.mb_del_detail(mb_id);
      model.addAttribute("memberVO", vo);
   }

   @PostMapping("/member_delete")
   public String member_delete(String mb_id, RedirectAttributes rttr) {
      adMemberService.mb_delete(mb_id);
      rttr.addFlashAttribute("result", "success");
      return "redirect:/admin/member/member_list";
   }

   @ResponseBody
   @RequestMapping("/checked_modify")
   public ResponseEntity<String> checked_modify(@RequestParam(name = "mb_id_arr[]") List<String> mb_id_arr, @RequestParam(name = "mb_name_arr[]") List<String> mb_name_arr, @RequestParam(name = "mb_phone_arr[]") List<String> mb_phone_arr, @RequestParam(name = "mb_email_arr[]") List<String> mb_email_arr, @RequestParam(name = "mb_birth_arr[]") List<String> mb_birth_arr) {
      ResponseEntity<String> entity = null;
      System.out.println("회원아이디 : " + mb_id_arr);
      System.out.println("회원 이름 : " + mb_name_arr);
      System.out.println("회원 전화번호 : " + mb_phone_arr);
      System.out.println("회원 이메일: " + mb_email_arr);
      System.out.println("회원 생일 : " + mb_birth_arr);
      List<MemberVO> member_list = new ArrayList();

      for(int i = 0; i < member_list.size(); ++i) {
         MemberVO memberVO = new MemberVO();
         memberVO.setMb_id((String)mb_id_arr.get(i));
         memberVO.setMb_name((String)mb_name_arr.get(i));
         memberVO.setMb_phone((String)mb_phone_arr.get(i));
         memberVO.setMb_email((String)mb_email_arr.get(i));
         memberVO.setMb_birth((String)mb_birth_arr.get(i));
      }

      adMemberService.mb_checked_modify(member_list);
      entity = new ResponseEntity("success", HttpStatus.OK);
      return entity;
   }

   @ResponseBody
   @RequestMapping("/checked_delete")
   public ResponseEntity<String> checked_delete(@RequestParam(name = "mb_id_arr[]") List<String> mb_id_arr) {
      ResponseEntity<String> entity = null;
      adMemberService.mb_checked_delete(mb_id_arr);
      entity = new ResponseEntity("success", HttpStatus.OK);

      for(int i = 0; i < mb_id_arr.size(); ++i) {
      }

      return entity;
   }

}
