package com.coor.service;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;
import com.coor.mapper.AdCollectionMapper;
import com.coor.mapper.AdContactMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdContactServiceImpl implements AdContactService {

   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private AdContactMapper adContactMapper;
   
   @Override
   public List<ContactVO> contact_list(Criteria cri) {
      return adContactMapper.contact_list(cri);
   }
   
   @Override
   public int getTotalCount(Criteria cri) {
      return adContactMapper.getTotalCount(cri);
   }
   
   @Override
   public ContactVO getContact(Long contact_num) {
      return adContactMapper.getContact(contact_num);
   }
   
   @Override
   public void reply(ContactVO vo) {
      adContactMapper.reply(vo);
   }
   
   @Override
   public void delete(Long contact_num) {
      adContactMapper.delete(contact_num);
   }
   
   @Override
   public void checked_delete(List<Long> contact_num_arr) {
      adContactMapper.checked_delete(contact_num_arr);
   }

}
