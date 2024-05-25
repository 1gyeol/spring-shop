package com.coor.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.coor.domain.AdminVO;
import com.coor.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/*")
@Controller
public class AdminController {

   @Setter(onMethod_ = {@Autowired})
   private AdminService adminService;

   @Setter(onMethod_ = {@Autowired})
   private PasswordEncoder passwordEncoder;

   @GetMapping("/login")
   public void login() {
      log.info("관리자 로그인 폼");
   }

   // 관리자 로그인 
   @PostMapping("/login")
   public String login(AdminVO vo, HttpSession session, RedirectAttributes rttr) {
      
	  AdminVO db_vo = adminService.admin_ok(vo.getAdmin_id());
      String url = "";
      String msg = "";
      
      if (db_vo != null) {
         if (this.passwordEncoder.matches(vo.getAdmin_pw(), db_vo.getAdmin_pw())) {
            session.setAttribute("adminStatus", db_vo);
            url = "admin/admin_menu";
            this.adminService.now_visit(vo.getAdmin_id());
         } else {
            url = "admin/";
            msg = "failPW";
         }
      } else {
         url = "admin/";
         msg = "failID";
      }

      rttr.addFlashAttribute("msg", msg);
      return "redirect:/" + url;
   }

   // 관리자 메뉴
   @GetMapping("/admin_menu")
   public void admin_menu() {
   }

   // 로그아웃 
   @GetMapping("/logout")
   public String logout(HttpSession session) {
      session.invalidate();
      return "redirect:/admin/";
   }

}
