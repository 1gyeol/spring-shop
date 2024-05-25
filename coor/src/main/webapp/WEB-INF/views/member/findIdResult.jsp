<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - FIND ID RESULT</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body>
    <div class="wrapper">

		<!--header-->
		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		<!--header end-->

	    <section class="section container">
	    	<div class="member-wrap">
	    		<div class="member-inner-wrap">
	                <!-- col-wrap -->
	                <div class="col-wrap pt80">
	                    <!-- col -->
	                   		<div class="col pb60">
								<h2 class="text-center">
									회원님의 아이디는 <br>
									<span style="color:#333; display:inline-block; font-size:1em; text-decoration: underline;"><c:out value="${mb_id}"/></span> 입니다.</h2>	
	        				</div>
	                        <div class="btn-member-bottom">
	                           <button type="button" id="btnJoin" class="button mr10 btn-orange" onclick="location.href='/member/login'">로그인</button>
	                           <button type="button" id="btnFindPw" class="button" onclick="location.href='/member/findPw'">비밀번호 찾기</button>
	                        </div>
	                    <!-- col -->
	                </div>
	                <!-- col-wrap -->
	    		</div> 
	        </div>
	    </section>
		
		<!--footer start-->
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
		<!--footer end-->
    </div>
</body>

</html>
