package com.coor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.coor.domain.OrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.Criteria;
import com.coor.dto.OrderListDTO;

public interface OrderMapper {
	
	/* 주문 정보 */
	void order_save(OrderVO o_vo);  
	
	/* 주문 리스트 조회*/
	List<OrderListDTO> myorder(@Param("cri") Criteria cri, @Param("mb_id") String mb_id);
	int getTotalCount(@Param("cri") Criteria cri, @Param("mb_id") String mb_id);
	 
	/* 회원별 총 주문 수*/
	OrderListDTO orderCount(String mb_id);
	  
	List<OrderListDTO> contactOrder(String mb_id);
	  
	/* 상세 주문 정보 저장 */
	void order_detail_save(Long o_vo);	  
	void payment_save(PaymentVO p_vo);
	  
	/* 결제 정보 조회*/
	PaymentVO getPaymentInfo(Long ord_code);
	  
	/* 주문 조회 */
	OrderVO getOrderInfo(Long ord_code);
	OrderDetailVO detail_myorder(@Param("mb_id") String mb_id, @Param("ord_code") Long ord_code);
	  
	/* 주문 취소 */
	void order_cancel(Long ord_code);

}
