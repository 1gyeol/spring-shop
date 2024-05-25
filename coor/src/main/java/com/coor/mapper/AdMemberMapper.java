package com.coor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.coor.domain.MemberVO;
import com.coor.dto.Criteria;

public interface AdMemberMapper {

	/* 회원 중복 검사*/
    String idCheck(String mb_id);

    /* 회원 가입 */
    void mb_insert(MemberVO vo);

    /* 회원 상세 정보 */
    MemberVO mb_detail(String mb_id);

    /* 탈퇴 회원 상세 정보*/
    MemberVO mb_del_detail(String mb_id);

    /* 회원 정보 수정 */
    void mb_modify(MemberVO vo);

    /* 회원 정보 삭제 */
    void mb_delete(String mb_id);
    
    /* 임시 비밀번호 발급 */
    String tempPw();

    /* 임시 비밀번호 변경 - 비밀번호 변경 */
    void updateTempPw(@Param("mb_id") String mb_id, @Param("enc_temp_pw") String enc_temp_pw);
	
    /* 회원 리스트 조회 */
    List<MemberVO> getListWithPaging(Criteria cri);
    int getTotalCount(Criteria cri);

    /* 탈퇴 회원 리스트 조회*/
    List<MemberVO> getDelListWithPaging(Criteria cri);
    int getDelTotalCount(Criteria cri);

    /* 체크 회원 수정 또는 삭제 */
    void mb_checked_modify(List<MemberVO> member_list);
    void mb_checked_delete(List<String> mb_id_arr);
}
