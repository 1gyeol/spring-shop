package com.coor.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coor.domain.MemberVO;
import com.coor.domain.OrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.CartListDTO;
import com.coor.dto.Criteria;
import com.coor.dto.OrderListDTO;
import com.coor.dto.PageDTO;
import com.coor.kakaopay.CancelResponse;
import com.coor.kakaopay.ReadyResponse;
import com.coor.service.CartService;
import com.coor.service.KakaoPayService;
import com.coor.service.MemberService;
import com.coor.service.OrderService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/order/*")
@Controller
public class OrderController {


	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;

	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;

	@Setter(onMethod_ = {@Autowired})
	private MemberService memberService;

	@Setter(onMethod_ = {@Autowired})
	private KakaoPayService kakaoPayService;
	
	// cid 정보 주입
	@Resource(name = "cid")
    private String cid;
	
	//업로드폴더 주입
	@Resource(name = "uploadPath") // servlet-context.xml 참조.
	private String uploadPath;  // C:\\dev\\upload\\pds\\
	

	// 주문 정보
   @GetMapping("/order_info")
   public void order_info(HttpSession session, Model model) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      List<CartListDTO> cart_list = cartService.cart_list(mb_id);
      
      cart_list.forEach((vo) -> {
         vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      });
      
      String order_productName = ((CartListDTO)cart_list.get(0)).getPro_name() + "외 " + (cart_list.size() - 1) + " 건";
      model.addAttribute("order_productName", order_productName);
      model.addAttribute("cart_list", cart_list);
      model.addAttribute("cart_tot_price", cartService.cart_tot_price(mb_id));
      model.addAttribute("memberVO", memberService.login(mb_id));
   }

   // 이미지 매핑 주소
   @GetMapping("/displayImage")
   @ResponseBody
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
   }

   // 주문 리스트
   @GetMapping("/order_list")
   public void order_list(@ModelAttribute("cri") Criteria cri, HttpSession session, Model model) {
      
	  String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      List<OrderListDTO> orderList = orderService.myorder(cri, mb_id);
      
      log.info("주문목록 : " + orderList);
      
      orderList.forEach((vo) -> {
         vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      });
      
      model.addAttribute("orderList", orderList);
      int totalCount = orderService.getTotalCount(cri, mb_id);
      PageDTO dto = new PageDTO(totalCount, cri);
      
      model.addAttribute("pageMaker", dto);
      model.addAttribute("orderInfo", orderService.orderCount(mb_id));
   }

   // 상세 주문
   @GetMapping("/order_detail")
   public void order_detail(Long ord_code, HttpSession session, Model model) {
	   
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      OrderDetailVO dto = orderService.detail_myorder(mb_id, ord_code);
      
      model.addAttribute("orderVO", dto);
   }

   // 주문
   @GetMapping("/orderbuy")
   @ResponseBody
   public ReadyResponse orderPay(String pay_type, String order_productName, OrderVO o_vo, PaymentVO p_vo, HttpSession session) {
      
	  ReadyResponse readyResponse = new ReadyResponse();
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      
      o_vo.setMb_id(mb_id);
      p_vo.setMb_id(mb_id);
      
      log.info("결제방식: " + pay_type);
      log.info("무통장주문정보: " + o_vo);
      log.info("무통장결제정보: " + p_vo);
      
      if (pay_type.equals("bank")) {
         p_vo.setTid("");
         orderService.order_save(o_vo, p_vo);
      }

      if (pay_type.equals("kakaopay")) {
    	  
         p_vo.setPay_user(p_vo.getMb_id());
         p_vo.setPay_bank("kakaopay");
         
         String approval_url = "http://localhost:8081/order/orderApproval";
         String cancel_url = "http://localhost:8081/order/orderCancel";
         String fail_url = "http://localhost:8081/order/orderFail";
         
         readyResponse = kakaoPayService.payReady(cid, o_vo.getOrd_code(), mb_id, order_productName, 1, o_vo.getOrd_price(), 0, approval_url, cancel_url, fail_url);
         
         log.info("결제준비요청: " + readyResponse);
         log.info("결제고유번호(tid): " + readyResponse.getTid());
         log.info("결제요청URL(QR코드): " + readyResponse.getNext_redirect_pc_url());
         
         session.setAttribute("tid", readyResponse.getTid());
         session.setAttribute("ord_code", o_vo.getOrd_code());
         
         p_vo.setTid(readyResponse.getTid());
         
         log.info("카카오페이결제정보: " + p_vo);
         
         orderService.order_save(o_vo, p_vo);
      }

      return readyResponse;
   }

   
   // 결제 승인
   @GetMapping("/orderApproval")
   public String orderApproval(String pg_token, HttpSession session) {
	   
      log.info("승인 폼");
      
      String tid = (String)session.getAttribute("tid");
      session.removeAttribute("tid");
      Long ord_code = (Long)session.getAttribute("ord_code");
      
      session.removeAttribute("ord_code");
      
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      
      kakaoPayService.payApprove(cid, tid, ord_code, mb_id, pg_token);
      
      return "redirect:/order/orderComplete";
   }

   @GetMapping("/orderComplete")
   public String orderComplete() {
      log.info("주문완료");
      return "/order/order_complete";
   }

   @GetMapping("/orderCancel")
   public void orderCancel() {
      log.info("결제 취소");
   }

   @GetMapping("/orderFail")
   public void orderFail() {
      log.info("결제 실패");
   }

   //주문 취소
   @GetMapping("/pay_cancel")
   @ResponseBody
   public ResponseEntity<String> pay_cancel(Long ord_code, String pay_method, HttpSession session) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      ResponseEntity<String> entity = null;
      
      log.info("받은 데이터 : " + ord_code + pay_method);
      new CancelResponse();
      
      PaymentVO p_vo = orderService.getPaymentInfo(ord_code);
      String msg = "";
      
      if (pay_method.equals("bank")) {
         log.info("결제 정보 : " + p_vo);
         orderService.order_cancel(ord_code);
         entity = new ResponseEntity("success", HttpStatus.OK);
      }

      if (pay_method.equals("kakaopay")) {
         String tid = p_vo.getTid();
         
         log.info("\ncid : " + cid + "\ntid : " + tid + "\n취소금액 : " + p_vo.getPay_price() + "\n취소비과세 : " + "0");
         
         kakaoPayService.payCancel(cid, tid, p_vo.getPay_price(), 0);
         pay_method = orderService.detail_myorder(mb_id, ord_code).getPay_method();
         String ord_status = orderService.detail_myorder(mb_id, ord_code).getOrd_cancel();
         
         log.info("주문상태 : " + ord_status);
         log.info("주문취소 테스트");
        
         orderService.order_cancel(ord_code);
         entity = new ResponseEntity("success", HttpStatus.OK);
      }

      return entity;
   }
}
