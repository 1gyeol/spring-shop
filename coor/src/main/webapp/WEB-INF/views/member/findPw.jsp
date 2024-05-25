<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - FIND PASSWORD</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body class="bg_grey">
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
	                                <li id="list-id" class="find-list"><a href="/member/findId" title="아이디찾기 선택">아이디 찾기<!--아이디찾기--></a></li>
	                                <li id="list-pw" class="find-list active"><a href="/member/findPw" title="비밀번호 찾기 선택">비밀번호 찾기<!--비밀번호 찾기--></a></li>
	                            </ul>
	                        </div>
	                        <div class="find-pw">
	                            <div class="table-wrap">
	                                <form method="get" name="findPw" id="findPw">
	                                	<table class="board-form">
		                                    <caption>아이디, 이름, 핸드폰 번호, 인증번호 항목을 가진 비밀번호 찾기 입력 표<!--아이디이름, 핸드폰 번호, 인증번호 항목을 가진 비밀번호 찾기 입력 표--></caption>
		                                    <div>
	                                            <div class="board-list">
                                                    <input type="text" id="mb_id" name="mb_id" maxlength="20" class="input-text" placeholder=" "><!--아이디-->
	                                                <label for="mb_id">
	                                                    ID *
	                                                </label>
	                                            </div>
	                                            <div class="board-list">
                                                    <input type="text" id="mb_name" name="mb_name" maxlength="20" class="input-text" placeholder=" "><!--이름-->
	                                                <label for="mb_name">
	                                                    NAME *
	                                                </label>
	                                            </div>
	                                            <div class="board-list">
                                                    <input type="text" id="mb_email" name="mb_email" class="input-text" placeholder="abc@naver.com"><!--이메일-->
	                                                <label for="mb_email"> 
                                                        E-MAIL *
	                                                </label>
	                                            </div>
	                                        </div>
		                                </table>
			                            <div class="btn-member-bottom">
			                                <button type="button" id="btnSchPw" class="button large btn-orange" value="비밀번호 찾기" onclick="findSchPw();" disabled>비밀번호 찾기</button>
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

function findSchPw(){

	let id = $("#mb_id").val();
	let name = $("#mb_name").val();
	let email = $("#mb_email").val();


	console.log("버튼을 클릭했습니다.");

	if( id == "") {
	alert("아이디를 입력하세요.");
	$("#mb_id").focus();
	return false;
	}
	if( name == "") {
	alert("이름을 입력하세요.");
	$("#mb_id").focus();
	return false;
	}
	if( email == "") {
	alert("이메일을 입력하세요.");
	$("#mb_email").focus();
	return false;
	}

	console.log("\n아이디 : " + id + "\n이름 : " + name + "\n이메일 : " + email);

	$.ajax({
		url: '/member/findPwResult',
		type: 'get',
		dataType: 'text',
		data: {mb_id : id, mb_name : name, mb_email : email},
		success: function(result) {

			if(result == "success") {
				alert("입력한 이메일로 임시 비밀번호가 전송됩니다.");
				location.href = '/member/login';
			}else {
				alert("해당 정보가 존재하지 않습니다. 확인 후 다시 입력해주세요.");
				$("#mb_id").focus();
				return false;
			}        
			
		}
	});
}



$(function(){

	//버튼 활성화
    let mb_id = document.querySelector('#mb_id');
    let mb_name = document.querySelector('#mb_name');
    let mb_email = document.querySelector('#mb_email');
    let btnSchPwd = document.querySelector('#btnSchPw');

	mb_name.addEventListener('keyup', listener);
	mb_email.addEventListener('keyup', listener);

	function listener() {
	    switch (!(mb_name.value && mb_email.value)) {
	        case true: btnSchPwd.disabled = true; break;
	        case false: btnSchPwd.disabled = false; break;
	    }
	}

});

//메일 발송
$(function(){
    let msg = '${msg}';
    if(msg == 'success') {
		alert("입력한 이메일로 임시 비밀번호가 전송됩니다.");
		return;
    }else if(msg == 'fail') {
    	alert("회원정보가 잘못되었습니다.");
		$('#mb_id').focus();
		return false;
    }
});



</script>
</html>