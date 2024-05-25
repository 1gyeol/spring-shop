package com.coor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coor.domain.OrderDetailVO;
import com.coor.domain.OrderVO;
import com.coor.domain.PaymentVO;
import com.coor.dto.Criteria;
import com.coor.dto.OrderListDTO;
import com.coor.mapper.CartMapper;
import com.coor.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private OrderMapper orderMapper;
   
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private CartMapper cartMapper;   

   @Transactional
   @Override
   public void order_save(OrderVO o_vo, PaymentVO p_vo) {
	   
      orderMapper.order_save(o_vo);
      orderMapper.order_detail_save(o_vo.getOrd_code());
      
      p_vo.setOrd_code(o_vo.getOrd_code());
      
      orderMapper.payment_save(p_vo);
      cartMapper.cart_empty(o_vo.getMb_id());
   }
   
   @Override
   public List<OrderListDTO> myorder(Criteria cri, String mb_id) {
      return orderMapper.myorder(cri, mb_id);
   }
   
   @Override
   public int getTotalCount(Criteria cri, String mb_id) {
      return orderMapper.getTotalCount(cri, mb_id);
   }
   
   @Override
   public OrderListDTO orderCount(String mb_id) {
      return orderMapper.orderCount(mb_id);
   }
   
   @Override
   public void order_cancel(Long ord_code) {
      orderMapper.order_cancel(ord_code);
   }
   
   @Override
   public OrderDetailVO detail_myorder(String mb_id, Long ord_code) {
      return orderMapper.detail_myorder(mb_id, ord_code);
   }
   
   @Override
   public OrderVO getOrderInfo(Long ord_code) {
      return orderMapper.getOrderInfo(ord_code);
   }
   
   @Override
   public PaymentVO getPaymentInfo(Long ord_code) {
      return orderMapper.getPaymentInfo(ord_code);
   }
   
   @Override
   public List<OrderListDTO> contactOrder(String mb_id) {
      return orderMapper.contactOrder(mb_id);
   }

}
