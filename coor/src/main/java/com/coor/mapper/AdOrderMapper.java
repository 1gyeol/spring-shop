package com.coor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.coor.domain.AdOrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.Criteria;

public interface AdOrderMapper {
	
	/* 주문 정보 리스트 */
	List<OrderVO> orderList(@Param("cri") Criteria cri, @Param("sDate") String sDate, @Param("eDate") String eDate);
	int getTotalCount(@Param("cri") Criteria cri, @Param("sDate") String sDate, @Param("eDate") String eDate);

	/* 주문 취소 정보 리스트 */
	List<OrderVO> orderCancelList(@Param("cri") Criteria cri, @Param("sDate") String sDate, @Param("eDate") String eDate);
	int getTotalCancelCount(@Param("cri") Criteria cri, @Param("sDate") String sDate, @Param("eDate") String eDate);

	/* 주문 정보 */
	OrderVO getOrderInfo(Long ord_code);
	  
	/* 주문 상세 정보 */
	AdOrderDetailVO orderDetail(Long ord_code);

	/* 결제 정보 */
	PaymentVO getPaymentInfo(Long ord_code);
	  
	/* 주문 취소 */
	void orderCancel(Long ord_code);
	void checked_cancel(List<Long> ord_code_arr);
}
