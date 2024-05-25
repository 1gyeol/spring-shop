package com.coor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coor.domain.CollectionVO;
import com.coor.service.CollectionService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/collection/*")
public class CollectionController {

	@Setter(onMethod_ = {@Autowired})
	private CollectionService collectionService;

   @GetMapping("/col_detail/{col_num}")
   public String col_modify(@PathVariable("col_num") Integer col_num, Model model) {
      
	  CollectionVO vo = collectionService.getCollection(col_num);
      model.addAttribute("collectionVO", vo);
      
      return "/collection/col_detail";
   }

}
