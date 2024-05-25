package com.coor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class StoreController {
	
   @RequestMapping({"/store", "/store/", "/store/about"})
   public String about() {
      log.info("스토어");
      return "/store/about";
   }
}
