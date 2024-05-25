package com.coor.mapper;

import org.apache.ibatis.annotations.Param;

import com.coor.domain.MemberVO;
import com.coor.dto.FindMemberDTO;

public interface MemberMapper {

	   /* 아이디 중복검사 */
	   String idCheck(String mb_id);

	   /* 회원 가입 */
	   void join(MemberVO vo);

	   /* 로그인 */
	   MemberVO login(String mb_id);
       /* 로그인 시 최근 접속 시간 업데이트 */
	   void now_visit(String mb_id);

	   /* 회원정보 - 아이디 찾기*/
	   String findId(FindMemberDTO dto);

	   /* 회원정보 - 비밀번호 찾기*/
	   String findPw(FindMemberDTO dto);
	   
	   /*임시 비밀번호 발급*/
	   String tempPw();
	   
	   /*임시 비밀번호 업데이트 */
	   void updateTempPw(@Param("mb_id") String mb_id, @Param("enc_temp_pw") String enc_temp_pw);

	   /* 비밀번호 변경*/
	   void updatePw(@Param("mb_id") String mb_id, @Param("enc_mb_pw") String enc_mb_pw);

	   /* 회원 - 마이페이지 */
	   MemberVO mypage(String mb_id);

	   /* 회원정보 수정*/
	   void modify(MemberVO vo);
}
