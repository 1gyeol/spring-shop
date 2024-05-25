package com.coor.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.coor.domain.MemberVO;
import com.coor.dto.Criteria;
import com.coor.dto.EmailDTO;
import com.coor.dto.FindMemberDTO;
import com.coor.dto.OrderListDTO;
import com.coor.service.CartService;
import com.coor.service.ContactService;
import com.coor.service.EmailService;
import com.coor.service.MemberService;
import com.coor.service.OrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Setter(onMethod_ = {@Autowired})
	private MemberService memberService;
	
	@Setter(onMethod_ = {@Autowired})
    private CartService cartService;
	
	@Setter(onMethod_ = {@Autowired})
    private OrderService orderService;
	
	@Setter(onMethod_ = {@Autowired})
    private EmailService emailService;
	
	@Setter(onMethod_ = {@Autowired})
    private ContactService contactService;
	
	@Setter(onMethod_ = {@Autowired})
    private PasswordEncoder passwordEncoder;

	// 아이디 중복 체크
   @ResponseBody
   @GetMapping("/idCheck")
   public ResponseEntity<String> idCheck(String mb_id) {
      ResponseEntity<String> entity = null;
      String isUse = "";
      if (memberService.idCheck(mb_id) != null) {
         isUse = "no";
      } else {
         isUse = "yes";
      }

      entity = new ResponseEntity(isUse, HttpStatus.OK);
      return entity;
   }

   // 회원가입 폼
   @GetMapping("/join")
   public void join() {
   }

   // 회원 가입
   @PostMapping("/join")
   public String join(MemberVO vo) {
      log.info("회원정보" + vo);
      vo.setMb_pw(passwordEncoder.encode(vo.getMb_pw()));
      memberService.join(vo);
      return "redirect:/member/login";
   }

   // 로그인 폼
   @GetMapping("/login")
   public void login() {
      log.info("로그인폼");
   }

   // 로그인
   @PostMapping("/login")
   public String login(String mb_id, String mb_pw, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
      log.info("아이디 : " + mb_id + "\n패스워드 : " + mb_pw);
      MemberVO vo = memberService.login(mb_id);
      String url = "";
      String msg = "";
      if (vo != null) {
         if (passwordEncoder.matches(mb_pw, vo.getMb_pw())) {
            session.setAttribute("loginStatus", vo);
            String priorUrl = (String)session.getAttribute("priorUrl");
            log.info("*************************************");
            log.info("priorUrl? " + priorUrl);
            log.info("*************************************");
            if (priorUrl != null) {
               memberService.now_visit(mb_id);
               session.removeAttribute("priorUrl");
               return "redirect:" + priorUrl;
            }

            return "redirect:/";
         }

         url = "/member/login";
         msg = "failPW";
      } else {
         url = "/member/login";
         msg = "failID";
      }

      rttr.addFlashAttribute("msg", msg);
      return "redirect:" + url;
   }

   // 로그아웃
   @GetMapping("/logout")
   public String logout(HttpSession session) {
      session.invalidate();
      return "redirect:/";
   }

   // 아이디 찾기 폼
   @GetMapping("/findId")
   public void findId() {
      log.info("아이디 찾기 폼");
   }

   // 아이디 찾기
   @PostMapping("/findId")
   public String findId(FindMemberDTO dto, RedirectAttributes rttr) {
      String url = "";
      String msg = "";
      String mb_id = memberService.findId(dto);
      if (mb_id != null) {
         url = "member/findIdResult";
         msg = "success";
         rttr.addFlashAttribute("mb_id", mb_id);
      } else {
         url = "member/findId";
         msg = "fail";
         rttr.addFlashAttribute("msg", msg);
      }

      return "redirect:/" + url;
   }

   // 아이디 찾기 결과
   @GetMapping("/findIdResult")
   public void findIdResult() {
   }

   // 비밀번호 찾기 폼
   @GetMapping("/findPw")
   public void findPw() {
      log.info("비밀번호 찾기 폼");
   }

   // 비밀번호 찾기 결과
   @GetMapping("/findPwResult")
   public ResponseEntity<String> findPw(FindMemberDTO dto, RedirectAttributes rttr) {
      
	   ResponseEntity<String> entity = null;
      
      String result = "";
      String mb_pw = memberService.findPw(dto);
      String temp_pw = memberService.tempPw();
     
      if (mb_pw != null) {
         result = "success";
         String enc_temp_pw = passwordEncoder.encode(temp_pw);
         
         log.info("임시비밀번호 " + temp_pw);
         log.info("인코딩 임시 비밀번호 " + enc_temp_pw);
         
         memberService.updateTempPw(dto.getMb_id(), enc_temp_pw);
         System.out.print("이메일주소 " + dto.getMb_email());
         
         EmailDTO emailDTO = new EmailDTO();
         emailDTO.setReceiverMail(dto.getMb_email());
         log.info(emailDTO);
         
         String content = "안녕하세요. COOR입니다.\n임시비밀번호는 " + temp_pw + "입니다.";
         emailService.sendMail(emailDTO, content);
         log.info("이메일 전송완료");
      } else {
         result = "fail";
      }

      entity = new ResponseEntity(result, HttpStatus.OK);
      return entity;
   }

   //마이페이지
   @GetMapping("/myshop")
   public void mypage(@ModelAttribute("cri") Criteria cri, HttpSession session, Model model) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      List<OrderListDTO> orderList = orderService.myorder(cri, mb_id);
      
      log.info("주문목록 : " + orderList);
      
      model.addAttribute("orderInfo", orderService.orderCount(mb_id));
      model.addAttribute("orderList", orderList);
      model.addAttribute("contactCount", contactService.getMbContactCount(mb_id));
   }

   // 회원정보 수정 폼
   @GetMapping("/modify")
   public void modify(HttpSession session, Model model) {
      log.info("수정폼");
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      MemberVO vo = memberService.mypage(mb_id);
      model.addAttribute("memberVO", vo);
   }

   // 회원정보 수정
   @PostMapping("/modify")
   public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
      log.info("입력정보 " + vo);
      String msg = "";
      String db_mb_pw = ((MemberVO)session.getAttribute("loginStatus")).getMb_pw();
      
      if (passwordEncoder.matches(vo.getMb_pw(), db_mb_pw)) {
         memberService.modify(vo);
         msg = "success";
      } else {
         msg = "fail";
      }

      rttr.addFlashAttribute("msg", msg);
      return "redirect:/member/modify";
   }

   // 비밀번호 변경 폼
   @GetMapping("/changePw")
   public void changePw(HttpSession session) {
      log.info("비밀번호 변경페이지");
   }

   // 비밀번호 변경
   @ResponseBody
   @PostMapping("/changePw")
   public ResponseEntity<String> changePw(HttpSession session, String old_mb_pw, String new_mb_pw) {
      ResponseEntity<String> entity = null;
      
      String msg = "";
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      
      MemberVO db_vo = memberService.mypage(mb_id);
      String db_pw = db_vo.getMb_pw();
      
      if (passwordEncoder.matches(old_mb_pw, db_pw)) {
         String enc_mb_pw = passwordEncoder.encode(new_mb_pw);
         memberService.updatePw(mb_id, enc_mb_pw);
         msg = "success";
      } else {
         msg = "fail";
      }

      entity = new ResponseEntity(msg, HttpStatus.OK);
      return entity;
   }

}
