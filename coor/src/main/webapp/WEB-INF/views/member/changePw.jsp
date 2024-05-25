<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - MYPAGE - 비밀번호 변경</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body>
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <section id="section" class="section container">
            <div class="member-wrap">
                <div class="member-inner-wrap">
                    <!-- col-wrap -->
                    <div class="col-wrap">
                        <!-- col -->
                        <div class="col">
                            <h2 class="pb50">비밀번호 변경<!-- 비밀번호 변경--></h2>
                            <form method="post" action="/member/changePw" id="pwchangeForm">
                                <div class="table-wrap">
                                    <table class="board-form">
                                        <caption> 비밀번호 변경 표<!--비밀번호 변경 표--></caption>
                                        <div>
                                            <div class="board-list row">
                                                <input type="password" id="old_mb_pw" name="old_mb_pw" maxlength="20" class="input-text col" placeholder="이전 비밀번호"><!--비밀번호-->
                                                <label for="old_mb_pw">
                                                    이전 비밀번호
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="password" name="new_mb_pw" id="new_mb_pw" maxlength="20" class="input-text" placeholder="새 비밀번호"><!--새 비밀번호-->
                                                <label for="new_mb_pw">
                                                    새 비밀번호
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="password" name="new_mb_pwChk" id="new_mb_pwChk" maxlength="20" class="input-text" placeholder="새 비밀번호 확인"><!--새 비밀번호 확인-->
                                                <label for="new_mb_pwChk">
                                                    새 비밀번호 확인
                                                </label>
                                            </div>
                                        </div>
                                    </table>
                                    <div class="btn-member-bottom"> 
                                    	<!--비밀번호 변경  -->
                                        <button id="btnPwchange" type="button" class="button large mb20" value="비밀번호 변경">비밀번호 변경</button>
                                        <!--수정취소-->
                                        <button id="btnCancle" type="button" class="button large" onclick="history.back(-1);">취소</button>
                                    </div>
                                </div>     
                            </form>
                        </div>
                        <!--// col -->
                    </div>
                    <!--// col-wrap -->
                </div>
            </div>
        </section>
    </div>
</body>
<script>

$(document).ready(function(){

    // 비밀번호 변경 검사
    $("#btnPwchange").click(function() {
        let pwchangeForm = $("#pwchangeForm");
        
        //이전 비밀번호와 새 비밀번호가 같은지 검사
        if($('#old_mb_pw').val() == $('#new_mb_pw').val()){
            alert("이전 비밀번호와 새 비밀번호가 같습니다.");
            $('#new_mb_pw').focus();
            return false;
        }
        
        //새비밀번호와 새비밀번호확인이 같은지 검사
        if($('#new_mb_pw').val() != $('#new_mb_pwChk').val()){
            alert("새 비밀번호가 같지 않습니다.");
            $('#new_mb_pw').focus();
            return false;
        }
        
        $.ajax({
            url: '/member/changePw',
            type: 'post',
            data: {old_mb_pw : $("#old_mb_pw").val(), new_mb_pw : $("#new_mb_pw").val()},
            dataType: 'text',
            success: function(result) {
                if(result == "success") {
                    location.href = '/member/myshop';
                    alert("비밀번호 변경되었습니다.");
                    $("#old_mb_pw").val('');
                    $("#new_mb_pw").val('');

                }else if(result == "failPw") {   
                	window.location.reload();               
                    alert("기존비밀번호가 틀립니다. \n확인바랍니다.");
                    $("#old_mb_pw").val('');
                    $("#old_mb_pw").focus();
                 }
            }
        });
        

        pwchangeForm.submit();
    });


});
</script>
</html>