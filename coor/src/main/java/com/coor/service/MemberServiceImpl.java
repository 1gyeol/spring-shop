package com.coor.service;

import com.coor.domain.MemberVO;
import com.coor.dto.FindMemberDTO;
import com.coor.mapper.MemberMapper;

import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private MemberMapper memberMapper;   
   
   @Override
   public String idCheck(String mb_id) {
      return memberMapper.idCheck(mb_id);
   }
   
   @Override
   public void join(MemberVO vo) {
      memberMapper.join(vo);
   }

   public MemberVO login(String mb_id) {
      return memberMapper.login(mb_id);
   }
   
   @Override
   public void now_visit(String mb_id) {
      memberMapper.now_visit(mb_id);
   }
   
   @Override
   public String findId(FindMemberDTO dto) {
      return memberMapper.findId(dto);
   }
   
   @Override
   public String findPw(FindMemberDTO dto) {
      return memberMapper.findPw(dto);
   }

   public String tempPw() {
	   
	  /* 비밀번호 랜덤 생성 */
      char[] charSet = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'J', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
      
      String temp_pw = "";  
      
      int idx = 0;
      for(int i = 0; i < 6; ++i) {
         idx = (int)(charSet.length * Math.random());
         temp_pw = temp_pw + charSet[idx];
      }

      return temp_pw;
   }
   
   @Override
   public void updateTempPw(String mb_id, String enc_temp_pw) {
      memberMapper.updateTempPw(mb_id, enc_temp_pw);
   }
   
   @Override
   public void updatePw(String mb_id, String enc_mb_pw) {
      memberMapper.updatePw(mb_id, enc_mb_pw);
   }
   
   @Override
   public MemberVO mypage(String mb_id) {
      return memberMapper.mypage(mb_id);
   }

   @Override
   public void modify(MemberVO vo) {
      memberMapper.modify(vo);
   }

}
