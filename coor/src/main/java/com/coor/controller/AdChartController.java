package com.coor.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coor.service.AdChartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping({"/admin/chart/*"})
public class AdChartController {
	
   @Setter(onMethod_ = {@Autowired})
   private AdChartService adChartService;

   @GetMapping("/overall")
   public void overall(Model model) {
   }

   @ResponseBody
   @GetMapping("/firstCategoryOrderPrice")
   public ResponseEntity<JSONObject> firstCategoryOrderPrice() {
      ResponseEntity<JSONObject> entity = null;
      entity = new ResponseEntity(this.adChartService.firstCategoryChart(), HttpStatus.OK);
      return entity;
   }

}
