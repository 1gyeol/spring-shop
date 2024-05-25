package com.coor.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

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

import com.coor.domain.AdOrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.Criteria;
import com.coor.dto.PageDTO;
import com.coor.kakaopay.CancelResponse;
import com.coor.service.AdOrderService;
import com.coor.service.KakaoPayService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/order/*")
public class AdOrderController {
   
   //cid 주입
   @Resource(name = "cid" )
   private String cid;
   
   @Setter(onMethod_ = {@Autowired})
   private AdOrderService adOrderService;
	
   @Setter(onMethod_ = {@Autowired})
   private KakaoPayService kakaoPayService;

   //업로드폴더 주입
   @Resource(name = "uploadPath")
   private String uploadPath;

   // 이미지 매핑주소
   @ResponseBody
   @GetMapping("/displayImage")
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
   }

   // 주문 리스트
   @GetMapping("/order_list")
   public void orderList(@ModelAttribute("cri") Criteria cri, @ModelAttribute("sDate") String sDate, @ModelAttribute("eDate") String eDate, Model model) {
      log.info("시작날자: " + sDate);
      log.info("종료날자: " + eDate);
      List<OrderVO> orderList = this.adOrderService.orderList(cri, sDate, eDate);
      int totalCount = this.adOrderService.getTotalCount(cri, sDate, eDate);
      model.addAttribute("orderList", orderList);
      model.addAttribute("pageMaker", new PageDTO(totalCount, cri));
   }

   // 주문 취소 리스트
   @GetMapping("/order_cancel_list")
   public void orderCancelList(@ModelAttribute("cri") Criteria cri, @ModelAttribute("sDate") String sDate, @ModelAttribute("eDate") String eDate, Model model) {
      log.info("시작날자: " + sDate);
      log.info("종료날자: " + eDate);
      List<OrderVO> orderCancelList = this.adOrderService.orderCancelList(cri, sDate, eDate);
      int totalCount = this.adOrderService.getTotalCancelCount(cri, sDate, eDate);
      model.addAttribute("orderList", orderCancelList);
      model.addAttribute("pageMaker", new PageDTO(totalCount, cri));
   }

   // 주문 상세 정보
   @GetMapping("/order_detail")
   public void orderDetail(Long ord_code, Model model) {
      AdOrderDetailVO vo = this.adOrderService.orderDetail(ord_code);
      vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      model.addAttribute("orderVO", vo);
   }

   // 주문 취소
   @PostMapping("/orderCancel")
   @ResponseBody
   public ResponseEntity<String> orderCancel(Long ord_code) {
      ResponseEntity<String> entity = null;
      new CancelResponse();
      PaymentVO p_vo = this.adOrderService.getPaymentInfo(ord_code);
      String pay_method = p_vo.getPay_method();
      String msg = "";
      if (pay_method.equals("bank")) {
         log.info("결제 정보 : " + p_vo);
         this.adOrderService.orderCancel(ord_code);
         new ResponseEntity("success", HttpStatus.OK);
      }

      if (pay_method.equals("kakaopay")) {
         String tid = p_vo.getTid();
         log.info("\ncid : " + this.cid + "\ntid : " + tid + "\n취소금액 : " + p_vo.getPay_price() + "\n취소비과세 : " + "0");
         this.kakaoPayService.payCancel(this.cid, tid, p_vo.getPay_price(), 0);
         log.info("주문취소 테스트");
         this.adOrderService.orderCancel(ord_code);
         new ResponseEntity("success", HttpStatus.OK);
      }

      this.adOrderService.orderCancel(ord_code);
      entity = new ResponseEntity("success", HttpStatus.OK);
      return entity;
   }

   // 체크 주문 취소
   @ResponseBody
   @RequestMapping("/checked_cancel")
   public ResponseEntity<String> checked_delete(@RequestParam(name = "ord_code_arr[]") List<Long> ord_code_arr) {
      ResponseEntity<String> entity = null;
      this.adOrderService.checked_cancel(ord_code_arr);
      entity = new ResponseEntity("success", HttpStatus.OK);

      for(int i = 0; i < ord_code_arr.size(); ++i) {
      }

      return entity;
   }

}
