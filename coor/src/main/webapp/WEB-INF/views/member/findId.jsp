<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - FIND ID</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body>
    <div class="wrapper">

		<!--header-->
		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		<!--header end-->

        <section id="section" class="section">
            <div class="member-wrap">
                <div class="member-inner-wrap">
                    <!-- col-wrap -->
                    <div class="col-wrap">
                        <!-- col -->
                        <div class="col">
                            <h2 class="pb50">아이디/비밀번호 찾기<!-- 로그인--></h2>
                            <div class="tab-list pb50">
	                            <ul>
	                                <li id="list-id" class="find-list active"><a href="/member/findId" title="아이디찾기 선택">아이디 찾기<!--아이디찾기--></a></li>
	                                <li id="list-pw" class="find-list"><a href="/member/findPw" title="비밀번호 찾기 선택">비밀번호 찾기<!--비밀번호 찾기--></a></li>
	                            </ul>
	                        </div>
	                        <div class="find-id">
	                            <div class="table-wrap">
	                            	<form method="post" id="findId" action="/member/findId" >
	                            		<table class="board-form">
	                                    <caption>이름, 생년월일, 휴대폰 번호 항목을 가진 아이디 찾기 입력 표<!--이름, 생년월일, 휴대폰 번호 항목을 가진 아이디 찾기 입력 표--></caption>
	                                    <div>
                                            <div class="board-list">
                                                <input type="text" id="mb_name" name="mb_name" maxlength="20" class="input-text" placeholder=" "><!--이름-->
                                                <label for="mb_name">
                                                    	NAME *
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="text" name="mb_phone" id="mb_phone" class="input-text" placeholder="01012341234"><!--핸드폰 번호-->
                                                <label for="mb_phone">
                                                    	PHONE *
                                                </label>
                                            </div>
                                        </div>
	                                </table>
	                                        
		                            <div class="btn-member-bottom">
		                                <input type="submit" id="btnSchId" type="button" class="button large btn-orange" value="아이디 찾기" disabled><!--아이디 찾기-->
		                            </div>
	                            </form>
	                                
	                            </div>
	                        </div>
                        </div>
                        <!--// col -->
                    </div>
                    <!--// col-wrap -->
                </div>
            </div>
        </section>
		
		<!--footer start-->
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
		<!--footer end-->
    </div>
</body>
<script>


//버튼 활성화
$(function(){

    let mb_name = document.querySelector('#mb_name');
    let mb_phone = document.querySelector('#mb_phone');
    let btnSchId = document.querySelector('#btnSchId');

	mb_name.addEventListener('keyup', listener);
	mb_phone.addEventListener('keyup', listener);

	function listener() {
	    switch (!(mb_name.value && mb_phone.value)) {
	        case true: btnSchId.disabled = true; break;
	        case false: btnSchId.disabled = false; break;
	    }
	}


});

//회원정보 확인
$(function(){
    let msg = '${msg}';
    if(msg == 'fail') {alert("회원정보가 잘못되었습니다."); return false;}
});



</script>
</html>