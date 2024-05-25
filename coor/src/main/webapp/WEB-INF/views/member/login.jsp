<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - LOGIN</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body class="bg_grey">
    <div class="wrapper">
        <!-- header start -->
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <!-- header end -->
        <section id="section" class="section">
            <div class="member-wrap">
                <div class="member-inner-wrap">
                    <!-- col-wrap -->
                    <div class="col-wrap">
                        <!-- col -->
                        <div class="col">
                            <h2 class="pb50">로그인<!-- 로그인--></h2>
                            <form method="post" action="/member/login" name="joinForm" id="joinForm">
                                <div class="table-wrap">
                                    <table class="board-form">
                                        <caption>로그인을 위한 입력 표<!--로그인을 위한 입력 표--></caption>
                                        <div>
                                            <div class="board-list">
                                                <input type="text" id="mb_id" name="mb_id" maxlength="20" class="input-text" autocomplete="false" placeholder=" "><!--아이디-->
                                                <label for="mb_id">
                                                    ID *
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="password" name="mb_pw" id="mb_pw" maxlength="20" class="input-text" autocomplete="new-password" placeholder=" "><!--비밀번호-->
                                                <label for="mb_pw">
                                                    PASSWORD *
                                                </label>
                                            </div>
                                        </div>
                                        <div class="member-link">
                                            <a href="/member/findId" title="ID/PW 찾기 선택" class="mr30">ID/PW 찾기<!--ID/PW 찾기--></a>
                                            <a href="/member/join" title="회원가입 선택">회원가입<!--회원가입--></a>
                                        </div>
                                        <div class="btn-member-bottom mt30">
                                            <input type="submit" id="btnLogin" class="button large" value="로그인" disabled><!--로그인-->
                                            <input type="button" id="btnOrder" class="button large btn-white mt15" value="비회원 주문조회"><!--비회원 주문조회-->
                                        </div>
                                    </table>
                                    
                                </div>     
                            </form>
                        </div>
                        <!--// col -->
                    </div>
                    <!--// col-wrap -->
                </div>
            </div>
        </section>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
</body>
<script>

$(document).ready(function() {

    let msg = '${msg}';

    if(msg == 'failID') {
        alert("존재하지 않는 아이디입니다.");
        $("#mb_id").focus();
    }else if(msg == 'failPW') {
        alert("비밀번호를 확인해주세요.");
        $("#mb_pw").focus();
    }


    
    //로그인 버튼 활성화
	$(function(){
	
	    const mb_id = document.querySelector('#mb_id');
	    const mb_pw = document.querySelector('#mb_pw');
	
	    mb_id.addEventListener('keyup', listener);
	    mb_pw.addEventListener('keyup', listener);
	
	    function listener() {
	        switch (!(mb_id.value && mb_pw.value)) {
	            case true: btnLogin.disabled = true; break;
	            case false: btnLogin.disabled = false; break;
	        }
	    }
	    
	});
    
});

</script>
</html>