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
  <title>관리자페이지 | 컬렉션 관리 | 컬렉션 목록</title>
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
  		alert("상품이 수정되었읍니다.");
  	}else if(msg == 'delete') {
  		alert("상품이 삭제되었읍니다.");
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
        콜렉션 목록
        <small>COLLECTION LIST</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 콜렉션 관리</a></li>
        <li class="active">콜렉션 목록</li>
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
              <form id="searchForm" action="/admin/collection/col_list" method="get">
                <div class="form-group" style="display:flex; align-items: center; justify-content: space-between; ">
                  <div>
                    <select name="type"> 
                      <option value="CT" <c:out value="${pageMaker.cri.type eq 'CT'? 'selected':'' }" />>컬렉션명</option>   
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력하세요." value='<c:out value="${pageMaker.cri.keyword }" />'>
                    <input type="hidden" name="pageNum" value="1">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <button type="submit"  class="btn btn-success">Search</button>
                  </div>
                  <div>
                    <button type="button" id="btn_checkedDelete" class="btn btn-danger">선택컬렉션삭제</button>
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
                  <th style="width: 30%">컬렉션명</th>
                  <th style="width: 10%">게시노출여부</th>
                  <th style="width: 15%">등록일</th>
                  <th style="width: 15%">수정일</th>
                  <th style="width: 20%">문의 관리</th>
                </tr>
                <c:forEach items="${colList }" var="collectionVO">
                <tr>
                  <td><input type="checkbox" name="check" value="${collectionVO.col_num }"></td>
                  <td>${collectionVO.col_num }</td>
                  <td>
                    <a class="move" href="${collectionVO.col_num }"><c:out value="${collectionVO.col_name }" ></c:out></a>
                  </td>
                  <td>
                  	<select id="col_show" name="col_show">
                            <option value="Y" ${collectionVO.col_show == 'Y' ? 'selected':''}>노출</option>
                            <option value="N" ${collectionVO.col_show == 'N' ? 'selected':''}>미노출</option>
                    </select>
                 </td>
                 <td><fmt:formatDate value="${collectionVO.col_regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
                 <td><fmt:formatDate value="${collectionVO.col_updatedate }" pattern="yyyy-MM-dd HH:mm"/></td>
                 <td>
                  <button type="button" name="btn_productEdit" data-col_num="${collectionVO.col_num }" class="btn">수정</button>
				  <button type="button" name="btn_productDel" data-col_num="${collectionVO.col_num }" class="btn btn-danger">삭제</button>
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
              <form id="actionForm" action="/admin/collection/col_list" method="get">
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

      // 리스트(목록)에서 제목 클릭-> 상품상세보기.
      $("a.move").on("click", function(e) {
        e.preventDefault(); // a태그의 하이퍼링크 기능이 취소.

        let col_num = $(this).attr("href");
        
        console.log("글번호: " + col_num);

        // 목록에서 글번호 선택후, 다시 뒤로가기버튼 클릭시 나타나는 문제발생때문에 아래코드 작업이 필요.
        actionForm.find("input[name='col_num']").remove();

        actionForm.append("<input type='hidden' name='col_num' value='" + col_num + "'>");
        actionForm.attr("action", "/admin/collection/col_modify");

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
        actionForm.attr("action", "/admin/collection/col_list");
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));

        actionForm.submit();
      });

      
      // 목록에서 수정버튼을 클릭
      $("button[name='btn_productEdit']").on("click", function() {
        // 수정 상품코드
        actionForm.append("<input type='hidden' name='col_num' value='" + $(this).data("col_num") + "'>");

        let cat_code = $(this).parent().parent().find("input[name='cat_code']").val();
        actionForm.append("<input type='hidden' name='cat_code' value='" + cat_code + "'>");
        
        actionForm.attr("method", "get");
        actionForm.attr("action", "/admin/collection/col_modify");
        actionForm.submit();
        
      });

      // 목록에서 삭제버튼을 클릭.   name="btn_productDel"
      $("button[name='btn_productDel']").on("click", function() {

        if(!confirm("상품을 삭제하겠습니까?")) return;

        actionForm.append("<input type='hidden' name='col_num' value='" + $(this).data("col_num") + "'>");

        actionForm.attr("method", "post");
        actionForm.attr("action", "/admin/collection/col_delete");
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

      //선택상품수정
      $("#btn_checkedModify").on("click", function() {
        if($("input[name='check']:checked").length == 0) {
          alert("수정할 상품을 체크하세요.");
          return;
        }

        // 자바스크립트 배열문법
        let col_num_arr = []; // 수정상품코드 배열
        let col_name_arr = []; //수정상품명 배열
        let col_show_arr = []; // 게시글노출여부 배열

        $("input[name='check']:checked").each(function() {
          col_num_arr.push($(this).val());
          col_name_arr.push($(this).parent().parent().find("input[name='col_name_arr']").val());
          col_show_arr.push($(this).parent().parent().find("select[name='col_show']").val());
        });
        

        $.ajax({
          url: '/admin/collection/col_checked_modify',
          type:'post',
          data: {col_num_arr: col_num_arr, col_name_arr:col_name_arr, col_show_arr:col_show_arr},
          dataType: 'text',
          success: function(result) {
            if(result == 'success') {
              alert("선택 게시글이 수정되었습니다.");

              actionForm.attr("method", "get");
              actionForm.attr("action", "/admin/collection/col_list");
              actionForm.submit();
            }
          }
        });



      });

      //선택상품삭제
      $("#btn_checkedDelete").on("click", function() {
        
        if($("input[name='check']:checked").length == 0) {
          alert("삭제할 게시글을 체크하세요.");
          return;
        }

        if(!confirm("삭제를 하시겠습니까?")) return;

        let col_num_arr = []; // 삭제상품코드 배열

        $("input[name='check']:checked").each(function() {
          col_num_arr.push($(this).val());
        });

        $.ajax({
          url: '/admin/collection/col_checked_delete',
          type:'post',
          data: {col_num_arr: col_num_arr},
          dataType: 'text',
          success: function(result) {
            if(result == "success") {
              alert("선택게시글이 삭제되었습니다.");
              // location.href = "/admin/collection/col_list";

              actionForm.attr("method", "get");
              actionForm.attr("action", "/admin/collection/col_list");
              actionForm.submit();
            }
          }
        });

      });
      
   // 1차카테고리 선택
   $("#firstCategory").change(function() {

     let cat_code = $(this).val();

     //console.log("1차 카테고리코드: " + cat_code);

     let url = "/admin/collection/subCategory/" + cat_code + ".json";

     $.getJSON(url, function(subCategoryData){

       //console.log(subCategoryData);

       let optionStr = "";
       let secondCategory = $("#secondCategory");

       secondCategory.find("option").remove(); // 카테고리 변경에 따른 이전 상태를 제거
       secondCategory.append("<option value=''>2차 카테고리 선택</option");

       for(let i=0; i<subCategoryData.length; i++) {
         optionStr += "<option value='" + subCategoryData[i].cat_code + "'>" + subCategoryData[i].cat_name + "</option>";
       }

       //console.log(optionStr);

       secondCategory.append(optionStr);



     });
   });

   // 카테고리 검색
   $("#categorySearch").on("click", function() {
    actionForm.attr("action", "/admin/collection/col_list");
    actionForm.append("<input type='hidden' name='cat_code' value='" + $("#secondCategory").val() + "'>");

    actionForm.submit();
   });

  }); // jquery ready event end
</script>
</body>
</html>