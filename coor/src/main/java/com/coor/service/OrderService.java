package com.coor.service;

import com.coor.domain.OrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.Criteria;
import com.coor.dto.OrderListDTO;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface OrderService {
	
	/* 주문 정보 저장 */
	void order_save(OrderVO o_vo, PaymentVO p_vo);
 
	
	/* 주문 리스트 조회*/
	List<OrderListDTO> myorder(Criteria cri, String mb_id);
	int getTotalCount(Criteria cri, String mb_id);
	 
	/* 회원별 총 주문 수*/
	OrderListDTO orderCount(String mb_id);
	  
	List<OrderListDTO> contactOrder(String mb_id);
	  	  	  
	/* 결제 정보 조회*/
	PaymentVO getPaymentInfo(Long ord_code);

	/* 주문 조회 */
	OrderVO getOrderInfo(Long ord_code);
	OrderDetailVO detail_myorder(String mb_id, Long ord_code);
	  
	/* 주문 취소 */
	void order_cancel(Long ord_code);
}
