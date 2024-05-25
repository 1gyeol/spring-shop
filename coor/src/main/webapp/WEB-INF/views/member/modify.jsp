<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - MYPAGE</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>

    <script>
        $(document).ready(function(){
            
            let msg = '${msg}';
            
            if(msg == 'failPw'){
                alert('비밀번호를 확인하세요.');
                return false;
                $("#mb_pw").focus();
            }
            
            
            if(msg == 'success'){
                alert('변경되었습니다.');
            }
        });
        

    </script>
</head>
<body>
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
                        <div class="col pb50">
                            <form method="post" id="modifyForm"  enctype="multipart/form-data">
                                <div class="table-wrap">
                                    <table class="board-form">
                                        <caption> 회원정보수정 표<!--회원정보수정 표--></caption>
                                        <div>
                                            <div class="board-list row">
                                                <input type="text" id="mb_id" name="mb_id" class="input-text" value="${memberVO.mb_id }" readonly><!--아이디-->
                                                <label for="mb_id">
                                                    ID
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="text" name="mb_name" id="mb_name" class="input-text"  value="${memberVO.mb_name }"readonly><!--이름-->
                                                <label for="mb_name">
                                                    NAME
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="password" name="mb_pw" id="mb_pw" maxlength="20" class="input-text" autocomplete="new-password" placeholder=" "><!--비밀번호-->
                                                <label for="mb_pw">
                                                    PASSWORD
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="text" name ="mb_email" id="mb_email" maxlength="20" class="input-text" value="${memberVO.mb_email }"><!--이메일 주소-->
                                                <label for="mb_email">
                                                    E-MAIL
                                                </label>
                                            </div>
                                            <div class="board-list">
                                                <input type="text" name="mb_phone" id="mb_phone" maxlength="11" class="input-text" value="${memberVO.mb_phone }"><!--휴대폰 번호-->
                                                <label for="mb_phone">
                                                    PHONE
                                                </label>
                                            </div>
                                            <div class="board-list row">
                                                <div class="birth col">
                                                    <input name="mb_birth" id="mb_birth" type="text" class="input-text"  value="${memberVO.mb_birth }"><!--생년월일-->
                                                	<label for="mb_birth">
	                                                    DATE OF BIRTH
	                                                </label> 
                                                </div>
                                            </div>
                                            <div class="board-list justify-content-between">
                                                <input type="text" id="sample2_address" name="mb_addr" class="input-text"  style="width: 65%;"  placeholder=" " value="${memberVO.mb_addr }" ><!--주소-->
                                                <label for="sample2_address">
                                                    ADDRESS
                                                </label>
                                                <input type="button" id="find_address_btn" class="button" style="width: 25%; font-size: 16px;" onclick="sample2_execDaumPostcode()" value="주소 찾기">
                               	     		</div>
                                            <div class="board-list">
                                                <input type="hidden" id="sample2_postcode" name="mb_zipcode" placeholder="우편번호" value="${memberVO.mb_zipcode}">
                                                <input type="text" id="sample2_detailAddress" name="mb_deaddr" placeholder="상세주소" value="${memberVO.mb_deaddr}">
                                                <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
                                            </div>
                                        </div>
                                    </table>
                                    <div class="btn-member-bottom">
                                        <!--수정하기-->
                                        <button id="btnModify" type="button" class="button large mb20" value="수정" onclick="modify();">수정</button>
                                        <!-- 비밀번호 수정 -->
                                        <button id="btnChgPw" type="button" class="button large mb20" value="수정" onclick="location.href='/member/changePw'">비밀번호 변경</button>
                                        <!--수정취소-->
                                        <button id="btnCancle" type="button btn-white" class="button large" onclick="location.href='/member/myshop'">취소</button>
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
        <!-- footer start -->
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
        <!-- footer end -->
    </div>
    <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
    <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
        </div>
        
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script>
            // 우편번호 찾기 화면을 넣을 element
            var element_layer = document.getElementById('layer');
        
            function closeDaumPostcode() {
                // iframe을 넣은 element를 안보이게 한다.
                element_layer.style.display = 'none';
            }
        
            function sample2_execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수
        
                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }
        
                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if(data.userSelectedType === 'R'){
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.
                            document.getElementById("sample2_extraAddress").value = extraAddr;
                        
                        } else {
                            document.getElementById("sample2_extraAddress").value = '';
                        }
        
                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('sample2_postcode').value = data.zonecode;
                        document.getElementById("sample2_address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("sample2_detailAddress").focus();
        
                        // iframe을 넣은 element를 안보이게 한다.
                        // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                        element_layer.style.display = 'none';
                    },
                    width : '100%',
                    height : '100%',
                    maxSuggestItems : 5
                }).embed(element_layer);
        
                // iframe을 넣은 element를 보이게 한다.
                element_layer.style.display = 'block';
        
                // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
                initLayerPosition();
            }
        
            // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
            // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
            // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
            function initLayerPosition(){
                var width = 300; //우편번호서비스가 들어갈 element의 width
                var height = 400; //우편번호서비스가 들어갈 element의 height
                var borderWidth = 5; //샘플에서 사용하는 border의 두께
        
                // 위에서 선언한 값들을 실제 element에 넣는다.
                element_layer.style.width = width + 'px';
                element_layer.style.height = height + 'px';
                element_layer.style.border = borderWidth + 'px solid';
                // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
                element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
                element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
            }
        </script>
</body>
<script>
    function modify(){
		let msg = '${msg}';
        let pw = $("#mb_pw").val();

        if(pw == ''){
            alert("비밀번호를 입력하세요.");
            return false;
            $("#mb_pw").focus();
        }
         
        
        $("#modifyForm").attr("action", "/member/modify");
        $("#modifyForm").submit();

    }
  </script>  
</html>