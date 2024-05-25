package com.coor.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.coor.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		log.info("로그인 인증관리 인터셉터: preHandle");
		
		HttpSession session = request.getSession();
		
		MemberVO loginAuth = (MemberVO) session.getAttribute("loginStatus");
		
		if(loginAuth == null) {
					
			if(isAjaxRequest(request)) {
				
				// ajax요청은 로그인 jsp를 사용불가능.  이유는 리턴값만 부분업데이트 성격으로 받는 특징때문에.
				//response.sendRedirect("/member/login");
				
				response.sendError(400);
			}else {
				
				// 사용자가 로그인으로 강제 진행되기전 요청했던 주소를 저장하는 작업.(원래 요청된 주소)
				getTargetUrl(request);  // ajax요청에서 사용시 무의미하다.
				response.sendRedirect("/member/login");
			}

			return false;
		}
		
	
		return true; // 인증된 사용자 일 경우 요청한 컨트롤러의 매핑주소로 제어가 넘어간다.
	}

	private void getTargetUrl(HttpServletRequest request) {
		
		// localhost:8080/product/pro_list?pro_num=10
		String uri = request.getRequestURI(); // localhost:8080/product/pro_list
		String query = request.getQueryString(); // pro_num=10
		
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		String targetUrl = uri + query;
		
		// 요청방식.  GET/POST/PATCH/PUT/DELETE 등
		if(request.getMethod().equals("GET")) {
			
			log.info("dest: " + targetUrl);
			// 원래요청주소를 세션으로 저장
			request.getSession().setAttribute("dest", targetUrl); // 로그인 인증처리작업에서 참조해야 함.
		}
	}
	
	// ajax요청 구분
	private boolean isAjaxRequest(HttpServletRequest request) {
		
		boolean isAjax = false;
		
		String header = request.getHeader("AJAX"); // 클라이언트 ajax호출하는 부분에서 작업이 먼저 선행되어야 한다.
		if(header != null && header.equals("true")) {
			isAjax = true;
			
			System.out.println("ajax요청");
		}
		
		return isAjax;
	}
}
