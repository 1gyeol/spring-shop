package com.coor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coor.domain.AdOrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.Criteria;
import com.coor.mapper.AdOrderMapper;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private AdOrderMapper adOrderMapper;
	
   
   @Override
   public List<OrderVO> orderList(Criteria cri, String sDate, String eDate) {
      return adOrderMapper.orderList(cri, sDate, eDate);
   }
   
   @Override
   public int getTotalCount(Criteria cri, String sDate, String eDate) {
      return adOrderMapper.getTotalCount(cri, sDate, eDate);
   }
   
   @Override
   public AdOrderDetailVO orderDetail(Long ord_code) {
      return adOrderMapper.orderDetail(ord_code);
   }
   
   @Override
   public List<OrderVO> orderCancelList(Criteria cri, String sDate, String eDate) {
      return adOrderMapper.orderCancelList(cri, sDate, eDate);
   }
   
   @Override
   public int getTotalCancelCount(Criteria cri, String sDate, String eDate) {
      return adOrderMapper.getTotalCancelCount(cri, sDate, eDate);
   }
   
   @Override
   public void orderCancel(Long ord_code) {
      adOrderMapper.orderCancel(ord_code);
   }
   
   @Override
   public void checked_cancel(List<Long> ord_code_arr) {
      adOrderMapper.checked_cancel(ord_code_arr);
   }
   
   @Override
   public OrderVO getOrderInfo(Long ord_code) {
      return adOrderMapper.getOrderInfo(ord_code);
   }
   
   @Override
   public PaymentVO getPaymentInfo(Long ord_code) {
      return adOrderMapper.getPaymentInfo(ord_code);
   }

}
