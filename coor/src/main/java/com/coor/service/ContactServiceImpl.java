package com.coor.service;

import com.coor.domain.ContactVO;
import com.coor.dto.Criteria;
import com.coor.mapper.CollectionMapper;
import com.coor.mapper.ContactMapper;

import lombok.Setter;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContactServiceImpl implements ContactService {
	
   @Setter(onMethod_ = {@Autowired})  // jdk 1.8  _ 언더바 사용.
   private ContactMapper contactMapper;
   
   
   @Override
   public List<ContactVO> contact_list(Criteria cri, String mb_id) {
      return contactMapper.contact_list(cri, mb_id);
   }
   
   @Override
   public int getTotalCount(Criteria cri, String mb_id) {
      return contactMapper.getTotalCount(cri, mb_id);
   }
   
   @Override
   public int getMbContactCount(String mb_id) {
      return contactMapper.getMbContactCount(mb_id);
   }
   
   @Override
   public void insert(ContactVO vo) {
      contactMapper.insert(vo);
   }
   
   @Override
   public void modify(ContactVO vo) {
      contactMapper.modify(vo);
   }
   
   @Override
   public void delete(Long contact_num) {
      contactMapper.delete(contact_num);
   }
   
   @Override
   public ContactVO getContact(Long contact_num) {
      return contactMapper.getContact(contact_num);
   }

}
