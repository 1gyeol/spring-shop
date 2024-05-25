<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>관리자페이지 | 회원 관리 | 회원 목록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>
  	
  <style>
  
.pagination {
  display: flex;
  justify-content: center;
}
  </style>
  <script>
  
  	let msg = "${msg}";
  	if(msg == 'modify') {
  		alert("회원이 수정되었습니다.");
  	}else if(msg == 'delete') {
  		alert("회원이 삭제되었습니다.");
  	}
  
  </script>
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
        회원목록
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
        	
        		<div class="box">
            <div class="box-header with-border">
              <form id="searchForm" action="/admin/member/member_list" method="get">
                <div class="form-group" style="display:flex; align-items: center; justify-content: space-between; ">
                  <div>
                    <select name="type">
                      <option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected':'' }" />>아이디</option>   
                      <option value="MN" <c:out value="${pageMaker.cri.type eq 'MN'? 'selected':'' }" />>회원명</option>   
                      <option value="SN" <c:out value="${pageMaker.cri.type eq 'SN'? 'selected':'' }" />>상점명</option>   
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력하세요." value='<c:out value="${pageMaker.cri.keyword }" />'>
                    <input type="hidden" name="pageNum" value="1">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <button type="submit"  class="btn btn-success">Search</button>
                  </div>
                  <div>
                    <button type="button" id="btn_checkedModify" class="btn">선택회원수정</button>
                    <button type="button" id="btn_checkedDelete" class="btn btn-danger">선택회원삭제</button>
                  </div>
                </div>
              </form>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table class="table table-bordered">
                <tbody><tr>
                  <th style="width: 2%"><input type="checkbox" id="checkAll"></th>
                  <th style="width: 8%">번호</th>
                  <th style="width: 10%">아이디</th>
                  <th style="width: 10%">이름</th>
                  <th style="width: 10%">핸드폰번호</th>
                  <th style="width: 15%">이메일</th>
                  <th style="width: 10%">가입일</th>
                  <th style="width: 10%">마지막 접속 시간</th>
                  <th style="width: 15%">회원관리</th>
                </tr>
                <c:forEach items="${memberList }" var="memberList">
                <tr>
                  <td><input type="checkbox" name="check" value="${memberList.mb_id }"></td>
                  <td>
                  	<c:out value="${memberList.rn }" />
                  </td>
                  <td>
                    <a class="move" href="${memberList.mb_id }"><c:out value="${memberList.mb_id}" /></a>
                  </td>
                  <td>
                    <input type="text" name="mb_name" value="${memberList.mb_name }">
                  </td>
                  <td>
                    <input type="text" name="mb_phone" value="${memberList.mb_phone }">
                  </td>
                  <td>
                    <input type="text" name="mb_email" value="${memberList.mb_email }">
                  </td>
                  <td>
                    <fmt:formatDate value="${memberList.mb_regdate }" pattern="yyyy-MM-dd HH:mm"/>
                  </td>
                  <td>
                    <fmt:formatDate value="${memberList.mb_lastdate }" pattern="yyyy-MM-dd HH:mm"/>
                  </td>
                  <td><button type="button" name="btn_memberEdit" data-mb_id="${memberList.mb_id }" class="btn">상세</button>
                  	<button type="button" name="btn_memberDel" data-mb_id="${memberList.mb_id }" class="btn btn-danger">삭제</button>
                  </td>
                </tr>
                </c:forEach>
                
              </tbody></table>
            </div>
            <!-- /.box-body -->
            <!-- [이전] 1 2 3 4 5 [다음] 출력작업 -->
            <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin">
                <c:if test="${pageMaker.prev }">
                	<li><a href="${pageMaker.startPage - 1}">[prev]</a></li>
                </c:if>
                
                <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
                	<li ${pageMaker.cri.pageNum == pageNum ? "class='active'": ""}><a href="${pageNum }">${pageNum }</a></li>
                </c:forEach>
                
                
                <c:if test="${pageMaker.next }">
                	<li><a href="${pageMaker.endPage + 1}">[next]</a></li>
                </c:if>
              </ul>
              <!-- 페이징정보. Criteria 클래스 필드정보작업 -->
              <form id="actionForm" action="/admin/member/member_list" method="get">
                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                <input type="hidden" name="type" value="${pageMaker.cri.type}">
                <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
              </form>
            </div>
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

<!-- REQUIRED JS SCRIPTS -->

<%@include file="/WEB-INF/views/admin/include/plugin2.jsp"%>


<script>
  $(document).ready(function() {
   
    let actionForm = $("#actionForm"); // 페이징정보가 있는 form태그. Criteria클래스 필드정보

      // 리스트(목록)에서 제목 클릭-> 회원상세보기.
      $("a.move").on("click", function(e) {
        e.preventDefault(); // 

        let mb_id = $(this).attr("href");
        
        console.log("회원아이디: " + mb_id);

        // 목록에서 글번호 선택후, 다시 뒤로가기버튼 클릭시 나타나는 문제발생때문에 아래코드 작업이 필요.
        actionForm.find("input[name='mb_id']").remove();

        actionForm.append("<input type='hidden' name='mb_id' value='" + mb_id + "'>");
        actionForm.attr("action", "/admin/member/member_modify");

        actionForm.submit();

    });

    // 페이지 번호, 이전, 다음 클릭시 actionForm 태그가 전송으로 사용된다.(중요)
      //페이지번호, 이전, 다음 클릭    <ul class="pagination.  
      $("ul.pagination a").on("click", function(e) {
        e.preventDefault(); // a태그의 하이퍼링크 기능이 취소.

        // 현재 페이지번호 변경작업
        // form태그의 정보  
        // <input type="hidden" name="pageNum" value="1">
        // <input type="hidden" name="amount" value="10">
        actionForm.attr("action", "/admin/member/member_list");
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));

        actionForm.submit();
      });

      
      // 목록에서 수정버튼을 클릭
      $("button[name='btn_memberEdit']").on("click", function() {
        // 수정 회원코드
        let mb_id = $(this).data("mb_id");
        console.log(mb_id);
        
        actionForm.find("input[name='mb_id']").remove();
        actionForm.append("<input type='hidden' name='mb_id' value='" + $(this).data("mb_id") + "'>");   
        actionForm.attr("method", "get");
        actionForm.attr("action", "/admin/member/member_modify");
        actionForm.submit();
        
      });

      // 목록에서 삭제버튼을 클릭.   name="btn_memberDel"
      $("button[name='btn_memberDel']").on("click", function() {

        if(!confirm("회원을 삭제하겠습니까?")) return;

        actionForm.append("<input type='hidden' name='mb_id' value='" + $(this).data("mb_id") + "'>");
        actionForm.attr("method", "post");
        actionForm.attr("action", "/admin/member/member_delete");
        actionForm.submit();
      });

      // 리스트에서 제목행 체크박스 선택
      let isCheck = true;
      $("#checkAll").on("click", function() {
        // 데이터 행 checkbox 모두선택
        $("input[name='check']").prop("checked", this.checked);
        isCheck = this.checked;
      });

      // 리스트에서 데이터행 체크박스 선택
      $("input[name='check']").on("click", function() {
        // 제목행 checkbox
        $("#checkAll").prop("checked", this.checked);

        //데이터 행의 체크박스 상태를 확인.
        $("input[name='check']").each(function() {
          if(!$(this).is(":checked")) {
            $("#checkAll").prop("checked", false);
          }
        });
      });


      //선택회원수정
      $("#btn_checkedModify").on("click", function(){
        if($("input[name='check']:checked").length == 0){
          alert("수정할 회원을 체크하세요.");
          return;
        }

        //자바스크립트 배열
        let mb_id_arr = []; //회원 배열
        let mb_name_arr = []; //회원이름 배열
        let mb_phone_arr = []; //회원전화번호 배열
        let mb_email_arr = []; //이메일 배열
        let mb_birth_arr = []; //생일 배열

        $("input[name='check']:checked").each(function(){
          mb_id_arr.push($(this).val());
          mb_name_arr.push($(this).parent().parent().find("input[name='mb_name']").val());
          mb_phone_arr.push($(this).parent().parent().find("select[name='mb_phone']").val());
          mb_email_arr.push($(this).parent().parent().find("select[name='mb_email']").val());
          mb_birth_arr.push($(this).parent().parent().find("input[name='mb_birth']").val());
        });
        /*
        console.log("회원코드 : " + mb_id_arr);
        console.log("회원가격 : " + pro_price_arr);
        console.log("회원상태 : " + pro_status_arr);
        console.log("판매여부 : " + pro_sell_arr);
        */

        $.ajax({
          url: '/admin/member/checked_modify',
          type: 'post',
          data: {mb_id_arr: mb_id_arr, mb_name_arr: mb_name_arr, mb_phone_arr: mb_phone_arr, mb_email_arr: mb_email_arr, mb_birth_arr: mb_birth_arr},
          dataType: 'text',
          success: function(result){
            alert("수정이 완료되었습니다.");
            
            actionForm.attr("method", "post");
            actionForm.attr("action", "/admin/member/member_list");
            actionForm.submit();
          }
        });


      });

      //선택회원삭제
      $("#btn_checkedDelete").on("click", function(){
        if($("input[name='check']:checked").length == 0){
          alert("삭제할 회원을 체크하세요.");
          return;
        }

        if(!confirm("삭제하시겠습니까?")) return;

        let mb_id_arr = []; //회원아이디 배열

        $("input[name='check']:checked").each(function(){
          mb_id_arr.push($(this).val());
        });

        $.ajax({
          url: '/admin/member/checked_delete',
          type: 'post',
          data: {mb_id_arr: mb_id_arr},
          dataType: 'text',
          success: function(result){
          if(result == "success"){
            alert("선택한 회원이 삭제되었습니다.");
            actionForm.attr("method", "get");
            actionForm.attr("action", "/admin/member/member_list");
            actionForm.submit();
            }
          }
        });

      });

  }); // jquery ready event end
</script>
</body>
</html>