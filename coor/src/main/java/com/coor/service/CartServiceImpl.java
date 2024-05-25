package com.coor.service;

import com.coor.domain.CartVO;
import com.coor.dto.CartListDTO;
import com.coor.mapper.AdProductMapper;
import com.coor.mapper.CartMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl implements CartService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private CartMapper cartMapper;
   
   
   @Override
   public int cart_add(CartVO vo) {
      return cartMapper.cart_add(vo);
   }
   
   @Override
   public List<CartListDTO> cart_list(String mb_id) {
      return cartMapper.cart_list(mb_id);
   }
   
   @Override
   public int cart_amount_change(Long cart_code, int cart_amount) {
      return cartMapper.cart_amount_change(cart_code, cart_amount);
   }
   
   @Override
   public int cart_delete(Long cart_code) {
      return cartMapper.cart_delete(cart_code);
   }
   
   @Override
   public int cart_tot_price(String mb_id) {
      return cartMapper.cart_tot_price(mb_id);
   }
   
   @Override
   public void cart_empty(String mb_id) {
      cartMapper.cart_empty(mb_id);
   }
   
   @Override
   public int cart_amount(String mb_id) {
      return cartMapper.cart_amount(mb_id);
   }

}
