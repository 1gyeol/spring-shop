package com.coor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coor.domain.MemberVO;
import com.coor.dto.Criteria;
import com.coor.mapper.AdMemberMapper;

import lombok.Setter;

@Service
public class AdMemberServiceImpl implements AdMemberService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private AdMemberMapper adMemberMapper;
   
   
   @Override
   public String idCheck(String mb_id) {
      return adMemberMapper.idCheck(mb_id);
   }
   
   @Override
   public void mb_insert(MemberVO vo) {
      adMemberMapper.mb_insert(vo);
   }
   
   @Override
   public MemberVO mb_detail(String mb_id) {
      return adMemberMapper.mb_detail(mb_id);
   }
   
   @Override
   public void mb_modify(MemberVO vo) {
      adMemberMapper.mb_modify(vo);
   }
   
   @Override
   public void mb_delete(String mb_id) {
      adMemberMapper.mb_delete(mb_id);
   }
   
   @Override
   public List<MemberVO> getListWithPaging(Criteria cri) {
      return adMemberMapper.getListWithPaging(cri);
   }
   
   @Override
   public int getTotalCount(Criteria cri) {
      return adMemberMapper.getTotalCount(cri);
   }

   public String tempPw() {
	   
	  /* 비밀번호 랜덤 생성 */
      char[] charSet = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'J', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
      
      String temp_pw = "";
      
      int idx = 0;

      for(int i = 0; i < 15; ++i) {
    	 idx = (int)(charSet.length * Math.random());
         temp_pw = temp_pw + charSet[idx];
      }

      return temp_pw;
   }
   
   @Override
   public void updateTempPw(String mb_id, String enc_temp_pw) {
      adMemberMapper.updateTempPw(mb_id, enc_temp_pw);
   }
   
   @Override
   public void mb_checked_modify(List<MemberVO> mb_list) {
      adMemberMapper.mb_checked_modify(mb_list);
   }
   
   @Override
   public void mb_checked_delete(List<String> mb_id_arr) {
      adMemberMapper.mb_checked_delete(mb_id_arr);
   }
   
   @Override
   public List<MemberVO> getDelListWithPaging(Criteria cri) {
      return adMemberMapper.getDelListWithPaging(cri);
   }
   
   @Override
   public int getDelTotalCount(Criteria cri) {
      return adMemberMapper.getDelTotalCount(cri);
   }
   
   @Override
   public MemberVO mb_del_detail(String mb_id) {
      return adMemberMapper.mb_del_detail(mb_id);
   }

}
