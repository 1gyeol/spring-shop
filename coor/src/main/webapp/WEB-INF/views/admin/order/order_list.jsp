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
  <title>관리자페이지 | 주문관리 | 주문 목록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>
<style>
  
.pagination {
  display: flex;
  justify-content: center;
}
  </style>
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
        주문 목록
        <small>Order List</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 주문관리</a></li>
        <li class="active">주문 목록</li>
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
                <div class="form-group row">
                  <div class="col-md-12">
                  <form id="searchForm" action="" method="get">
                    <div class="form-group" style="display:flex; align-items: center; justify-content: space-between; ">
                      <div>
                        주문일 : <input type="date" name="sDate" value="${sDate}"> ~ <input type="date" name="eDate" value="${eDate}">
                        <select name="type">
                          <option value="" <c:out value="${pageMaker.cri.type == null? 'selected':'' }" />>-----</option>
                          <option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected':'' }" />>주문번호</option>
                          <option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected':'' }" />>주문자ID</option>    
                          <option value="R" <c:out value="${pageMaker.cri.type eq 'R'? 'selected':'' }" />>수령인</option>
                        </select>
                        <input type="text" name="keyword" placeholder="검색어를 입력하세요." value='<c:out value="${pageMaker.cri.keyword }" />'>
                        <input type="hidden" name="pageNum" value="1">
                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                        <button type="button" id="btn_order_search" class="btn btn-success">Search</button>
                        </div>
                        <div>
                          <button type="button" id="btn_checkedCancel" class="btn btn-danger">선택주문취소</button>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
             
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table class="table table-bordered">
                <tbody><tr>
                  <th style="width: 2%"><input type="checkbox" id="checkAll"></th>
                  <th style="width: 13%">주문번호</th>
                  <th style="width: 15%">주문일시</th>
                  <th style="width: 20%">주문자/수령인</th>
                  <th style="width: 20%">주문금액/배송비</th>
                  <th style="width: 15%">결제방식</th>
                  <th style="width: 15%">주문관리</th>
                </tr>
                <c:forEach items="${orderList }" var="orderVO">
                <tr>
                  <td><input type="checkbox" name="check" value="${orderVO.ord_code }"></td>
                  <td>
                    ${orderVO.ord_code }
                  </td>
                  <td>
                  	<fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy-MM-dd HH:mm"/>
                  </td>
                  <td>
                    ${orderVO.mb_id } / ${orderVO.ord_name }
                  </td>
                  <td>
                  	${orderVO.ord_price }
                  </td>
                  <td name="pay_method">${orderVO.pay_method }</td>
                  <td>
                    <button type="button" name="btn_orderDetail" data-ord_code="${orderVO.ord_code }" class="btn">상세</button>
                    <button type="button" name="btn_orderCancel" data-ord_code="${orderVO.ord_code }" class="btn btn-danger">취소</button>
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
              <form id="actionForm" action="" method="get">
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
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp"%>

<script>
  $(document).ready(function() {

    let actionForm = $("#actionForm");
   
    // 상세 버튼을 클릭 
    $("button[name='btn_orderDetail']").on("click", function() {

      
      let ord_code = $(this).data("ord_code");

      actionForm.append("<input type='hidden' name='ord_code' value='" + $(this).data("ord_code") + "'>");

      actionForm.attr("method", "get");
      actionForm.attr("action", "/admin/order/order_detail");
      actionForm.submit();
      

     });

     // 주문삭제
     $("button[name='btn_orderCancel']").on("click", function() {
      
      if(!confirm("주문을 취소하시겠습니까?")) return;

      let ord_code = $(this).data("ord_code");
      let pay_method = $(this).parent().siblings().find("td[name='pay_method']").val();

      $.ajax({
          url: '/admin/order/orderCancel',
          type: 'post',
          data: {ord_code : ord_code, pay_method : pay_method},
          dataType: 'text',
          success: function(result) {
            if(result == 'success') {
              alert("주문이 취소되었습니다.");
              location.href = "/admin/order/order_list";
              
            }
          }

        });
     });


     // 검색 클릭
     let searchForm = $("#searchForm");
     $("#btn_order_search").on("click", function() {
      searchForm.attr("action", "/admin/order/order_list");
      searchForm.find("input[name='pageNum']").val(1);
      searchForm.submit();
     });


     $("ul.pagination a").on("click", function(e) {
      e.preventDefault(); // a태그의 하이퍼링크 기능이 취소.

      // 현재 페이지번호 변경작업
      // form태그의 정보  
      // <input type="hidden" name="pageNum" value="1">
      // <input type="hidden" name="amount" value="10">
      actionForm.attr("action", "/admin/order/order_list");
      actionForm.find("input[name='pageNum']").val($(this).attr("href"));

      actionForm.find("input[name='sDate']").remove();
      actionForm.find("input[name='eDate']").remove();

      actionForm.append("<input type='hidden' name='sDate' value='${sDate}'>");
      actionForm.append("<input type='hidden' name='eDate' value='${eDate}'>");

      actionForm.submit();
      });
      
      
      $("#btn_checkedCancel").on("click", function(){
        if($("input[name='check']:checked").length == 0){
          alert("삭제할 주문번호를 체크하세요.");
          return;
        }

        if(!confirm("삭제하시겠습니까?")) return;

        let ord_code_arr = []; //주문번호 배열

        $("input[name='check']:checked").each(function(){
          ord_code_arr.push($(this).val());
        });

        $.ajax({
          url: '/admin/order/checked_cancel',
          type: 'post',
          data: {ord_code_arr: ord_code_arr},
          dataType: 'text',
          success: function(result){
          if(result == "success"){
            alert("선택한 주문이 취소되었습니다.");
            actionForm.attr("method", "get");
            actionForm.attr("action", "/admin/order/order_list");
            actionForm.submit();
            }
          }
        });

      });
    

  }); // jquery ready event end
</script>


</body>
</html>