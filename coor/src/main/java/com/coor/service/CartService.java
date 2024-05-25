package com.coor.service;

import com.coor.domain.CartVO;
import com.coor.dto.CartListDTO;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface CartService {
	
	  /* 장바구니 추가 */
	  int cart_add(CartVO vo);
	  
	  /* 장바구니 리스트 */
	  List<CartListDTO> cart_list(String mb_id);
	  
	  /* 수량 변경*/
	  int cart_amount_change(Long cart_code, int cart_amount);
	  
	  /* 장바구니 삭제 */
	  int cart_delete(Long cart_code);
	  
	  /* 총 금액 */
	  int cart_tot_price(String mb_id);
	  
	  /* 장바구니 비우기 */
	  void cart_empty(String mb_id);
	  
	  /* 장바구니 총 수량*/
	  int cart_amount(String mb_id);
}
