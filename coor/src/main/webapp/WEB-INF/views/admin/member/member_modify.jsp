<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>관리자페이지 | 회원관리 | 회원수정</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>
  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/nav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        회원정보 수정
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 회원관리</a></li>
        <li class="active">회원목록</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
       
       <div class="row">
     	<div class="col-md-12">
     		<div class="box box-primary">
     			<form id="memberForm" action="/admin/member/member_modify" method="post">
            <div class="box-header">
              회원정보 수정
            </div>
            <div class="box-body">	
             <!-- 아이디 -->
             <div class="form-group row" style="display: flex; align-items: center;">
               <label for="mb_id" class="col-sm-2 col-form-label">아이디</label>
               <div class="col-sm-6" style="display: flex;">
               	<span id="mb_id" name="mb_id">${memberVO.mb_id}</span>
               </div>
             </div>
             <!-- 아이디 -->
             <!-- 비밀번호 -->
             <div class="form-group row" style="display: flex; align-items: center;">
               <label for="mb_pw" class="col-sm-2 col-form-label">비밀번호</label>
               <div class="col-sm-6">
                 <button type="button" id="btnTempPw" name="btnTempPw" class="btn btn-Warning" >임시 비밀번호 발급</button>
               </div>
             </div>
             <!-- 비밀번호 -->
             <!-- 이름 -->
             <div class="form-group row" style="display: flex; align-items: center;">
               <label for="mb_name" class="col-sm-2 col-form-label">이름</label>
               <div class="col-sm-6">
                 <input type="text" name="mb_name" value="${memberVO.mb_name}">
               </div>
             </div>
             <!-- 이름 -->
             <!-- 휴대폰 번호 -->
             <div class="form-group row" style="display: flex; align-items: center;">
              <label for="mb_phone" class="col-sm-2 col-form-label">휴대폰 번호</label>
              <div class="col-sm-6">
                <input type="text" name="mb_phone" value="${memberVO.mb_phone}">
              </div>
             </div>
             <!-- 휴대폰 번호 -->
 
             <!-- 이메일 주소 -->
             <div class="form-group row" style="display: flex; align-items: center;">
               <label for="mb_email" class="col-sm-2 col-form-label">이메일 주소</label>
               <div class="col-sm-6">
                 <input type="text" name="mb_email" value="${memberVO.mb_email}">
               </div>
             </div>
             <!-- 이메일 주소 -->
 
             <!-- 생년월일 -->
             <div class="form-group row" style="display: flex; align-items: center;">
               <label for="mb_birth" class="col-sm-2 col-form-label">생년월일</label>
               <div class="col-sm-6">
                 <input type="text" id="mb_birth" name="mb_birth" value="${memberVO.mb_birth}" placeholder="생년월일을 입력해주세요. 예)19930722">
               </div>
             </div>
             <!-- 생년월일 --> 

             <!-- 주소 -->
             <div class="form-group row" style="display: flex; align-items: center;">
              <label for="mb_addr" class="col-sm-2 col-form-label">주소</label>
              <div class="col-sm-6">
                <input type="text" id="sample2_postcode" name="mb_zipcode" placeholder="우편번호" value="${memberVO.mb_zipcode}">
                <input type="text" id="sample2_address" name="mb_addr" class="input-text"  style="width: 65%;"  placeholder=" " value="${memberVO.mb_addr }" ><!--주소-->
                <input type="text" id="sample2_detailAddress" name="mb_deaddr" placeholder="상세주소" value="${memberVO.mb_deaddr}">
                <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">  
                <input type="button" id="find_address_btn" class="button btn-dark" style="width: 25%; font-size: 16px;" onclick="sample2_execDaumPostcode()" value="주소 찾기">            
              </div>
            </div>
            <!-- 주소 -->  


            </div>
            <div class="box-footer">
              <div class="form-group">
                <ul class="uploadedList"></ul>
              </div>    				
              <div class="form-group" style=" display:flex; justify-content: space-between;">
                <div>
                 <button type="button" class="btn btn-danger" id="btnDelete">회원삭제</button>
                </div>	
                <div>
                 <button type="submit" class="btn btn-dark" id="btnMember">회원수정</button>
                 <button type="button" class="btn btn-dark" id="btnCancel" onclick="history.go(-1)">취소</button>
                </div>			
             </div>
            </div>
     			</form>
     		</div>
     	</div>
     </div>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<script>
  
  $("#btnTempPw").on("click", function(){
    alert("버튼 클릭");
    let mb_id = '${memberVO.mb_id}';
    let mb_email = '${memberVO.mb_email}';
  
    $.ajax({
      url: '/admin/member/tempPw',
      type: 'get',
      dataType: 'text',
      data: {
        mb_id : mb_id,
        mb_email : mb_email
      },
      success: function(result){
        if(result == "success"){
          alert("해당 이메일주소로 임시 비밀번호가 발급되었습니다.");
        }else{
          alert("임시 비밀번호 발급에 실패하였습니다. 관리자에게 연락하세요.");
        }
      }
    });
  });
  
  </script>

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
  <script>
  
      let mb_id = '${memberVO.mb_id}';
      
      // 삭제버튼을 클릭. 
      $("button[id='btnDelete']").on("click", function() {

        if(!confirm("회원을 삭제하겠습니까?")) return;
        
        $.ajax({
            url: '/admin/member/member_delete',
            type: 'post',
            data: {mb_id : mb_id},
            dataType: 'text',
            success: function(result) {
                if(result == "success") {
                    alert("해당 회원이 삭제되었습니다.");

                }else if(result == "fail") {   
                	window.location.reload();               
                    alert("회원 삭제가 실패하였습니다. \n확인바랍니다.");
                 }
            }
        });

      });
  </script>
</body>

</html>