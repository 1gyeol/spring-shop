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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coor.domain.CartVO;
import com.coor.domain.MemberVO;
import com.coor.dto.CartListDTO;
import com.coor.service.CartService;
import com.coor.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/cart/*")
@Controller
public class CartController {

	@Setter(onMethod_ = {@Autowired})
    private CartService cartService;

	//업로드폴더 주입
	@Resource(name = "uploadPath") // servlet-context.xml 참조.
	private String uploadPath;  // C:\\dev\\upload\\pds\\
	

	//장바구니 추가
   @ResponseBody
   @PostMapping("/cart_add")
   public ResponseEntity<String> cart_add(CartVO vo, HttpSession session) {
      ResponseEntity<String> entity = null;
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      vo.setMb_id(mb_id);
      if (cartService.cart_add(vo) == 1) {
         entity = new ResponseEntity("success", HttpStatus.OK);
      } else {
         entity = new ResponseEntity("fail", HttpStatus.OK);
      }

      return entity;
   }

   @GetMapping("/direct_cart_add")
   public String direct_cart_add(CartVO vo, HttpSession session) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      vo.setMb_id(mb_id);
      log.info("장바구니: " + vo);
      cartService.cart_add(vo);
      return "redirect:/order/order_info";
   }

   // 장바구니 리스트
   @GetMapping("/cart_list")
   public void cart_list(HttpSession session, Model model) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      List<CartListDTO> cart_list = cartService.cart_list(mb_id);
      
      cart_list.forEach((vo) -> {
         vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
      });
      
      model.addAttribute("cart_list", cart_list);
      
      if (cart_list.size() != 0) {
         model.addAttribute("cart_tot_price", cartService.cart_tot_price(mb_id));
      }

   }

   // 이미지 매핑주소
   @ResponseBody
   @GetMapping("/displayImage")
   public ResponseEntity<byte[]> displayFile(String folderName, String fileName) throws IOException {
      return FileUtils.getFile(uploadPath + folderName, fileName);
   }

   
   // 장바구니 수량 변경
   @ResponseBody
   @GetMapping("/cart_amount_change")
   public ResponseEntity<String> cart_amount_change(Long cart_code, int cart_amount) {
      ResponseEntity<String> entity = null;
      if (cartService.cart_amount_change(cart_code, cart_amount) == 1) {
         entity = new ResponseEntity("success", HttpStatus.OK);
      } else {
         entity = new ResponseEntity("fail", HttpStatus.OK);
      }

      return entity;
   }

   // 장바구니 제거
   @ResponseBody
   @PostMapping("/cart_delete")
   public ResponseEntity<String> cart_delete(Long cart_code) {
      ResponseEntity<String> entity = null;
      if (cartService.cart_delete(cart_code) == 1) {
         entity = new ResponseEntity("success", HttpStatus.OK);
      } else {
         entity = new ResponseEntity("fail", HttpStatus.OK);
      }

      return entity;
   }

   // 장바구니 비우기
   @GetMapping("/cart_empty")
   public String cart_empty(HttpSession session) {
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      cartService.cart_empty(mb_id);
      return "redirect:/cart/cart_list";
   }

}
