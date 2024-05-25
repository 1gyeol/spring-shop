package com.coor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coor.domain.MemberVO;
import com.coor.domain.ReviewVO;
import com.coor.dto.Criteria;
import com.coor.dto.PageDTO;
import com.coor.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/review/*")
@RestController
public class ReviewController {

	@Setter(onMethod_ = {@Autowired})
	private ReviewService reviewService;

	// 리뷰 리스트
   @GetMapping("/list/{pro_num}/{page}")
   public ResponseEntity<Map<String, Object>> review_list(@PathVariable("pro_num") int pro_num, @PathVariable("page") int page) {
      ResponseEntity<Map<String, Object>> entity = null;
      Map<String, Object> map = new HashMap();
      
      Criteria cri = new Criteria();
      cri.setPageNum(page);

	  //1)상품후기목록
      List<ReviewVO> list = this.reviewService.review_list(cri, pro_num);
      map.put("list", list);
      

      //2)페이징정보
      PageDTO pageMaker = new PageDTO(this.reviewService.review_count(pro_num), cri);
      map.put("pageMaker", pageMaker);
      
      entity = new ResponseEntity(map, HttpStatus.OK);
      
      return entity;
   }

   @PostMapping(value = "/new", consumes = "application/json", produces = "text/plain")
   public ResponseEntity<String> create(@RequestBody ReviewVO vo, HttpSession session) {
      log.info("상품후기" + vo);
      ResponseEntity<String> entity = null;
      
      String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
      vo.setMb_id(mb_id);
      
      this.reviewService.create(vo);
      entity = new ResponseEntity("success", HttpStatus.OK);
      
      return entity;
   }

   @PatchMapping(value = "/modify", consumes = "application/json", produces = "text/plain" )
   public ResponseEntity<String> modify(@RequestBody ReviewVO vo, HttpSession session) {
      
	   ResponseEntity<String> entity = null;
      
      this.reviewService.modify(vo);
      entity = new ResponseEntity("success", HttpStatus.OK);
      
      return entity;
   }

   @DeleteMapping("/delete/{rew_num}")
   public ResponseEntity<String> delete(@PathVariable("rew_num") Long rew_num) {
      ResponseEntity<String> entity = null;
      this.reviewService.delete(rew_num);
      entity = new ResponseEntity("success", HttpStatus.OK);
      return entity;
   }
}
