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
  <title>관리자페이지 | 주문관리 | 주문상세</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>
  <style>
    .table {margin-bottom: 0 !important; border: 1px solid #f4f4f4;}
    .table tr td:first-child { font-weight: 600; border-right: 1px solid #f4f4f4;}
    
  	.insert-list { width: 100%; display:flex; padding: 2rem 0; flex-direction: column;}
	.insert-list .insert-lt {width: 20rem; font-size: 18px; display: flex; padding-bottom: 20px; }
	.insert-list .insert-rt {flex: 1 1 0%; position: relative; display:flex; flex-direction: column;}
	.insert-list .insert-rt p {margin-bottom: 0 !important;}
	.insert-list .insert-rt .flex-wrap { flex-wrap: wrap;}
	.insert-list .insert-rt input[type="text"] { width: 100%; height: 3rem; padding: 0px 1rem; border: 1px solid #c3c2cc;}
	.insert-list .insert-rt label { display: inline-flex; font-size: 1rem;}
	.insert-list .insert-rt table tbody tr td { vertical-align: middle; }
  	
  	#cke_contact_re {width: 100%;}
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
        주문상세
        <small>ORDER</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 주문관리</a></li>
        <li class="active">주문상세</li>
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
            <div class="box-header">
              ORDER
            </div>
            <div class="box-body">	
              <div class="form-group row">
                <div class="col-sm-3">
                  <input type="hidden" name="pageNum" value="${cri.pageNum }">
                  <input type="hidden" name="amount" value="${cri.amount }">
                  <input type="hidden" name="type" value="${cri.type }">
                  <input type="hidden" name="keyword" value="${cri.keyword }">
                </div>
                <div class="row">
                  <form method="post" action="/admin/contact/contact_reply">
                    <div class="insert-form container">
                        <ul>
                            <!-- 주문 정보 -->
                            <li class="insert-list">
                              <div class="insert-lt">주문정보<span>*</span></div>
                              <div class="insert-rt" style="flex-direction: column; align-items: flex-start;">
                                <table class="table table_borderd">
                                      <tr>
                                        <td width="20%">주문번호</td>
                                        <td>${orderVO.ord_code}</td>
                                      </tr>
                                      <tr>
                                        <td width="20%">주문일</td>
                                        <td><fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                      </tr>
                                    </table>
                              </div>
                            </li>
                            <!-- 주문 정보 -->
                            <!-- 주문 내역 -->
                            <li class="insert-list">
                                <div class="insert-lt">결제정보<span>*</span></div>
                                <div class="insert-rt">
                                  <table class="table table_borderd">
                                        <tr>
                                          <td width="20%">총 주문금액</td>
                                          <td><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.ordt_price * orderVO.ordt_amount}" /></td>
                                        </tr>
                                        <tr>
                                          <td width="20%">총 할인금액</td>
                                          <td><fmt:formatNumber type="currency" pattern="#,###" value="${(orderVO.ordt_price * orderVO.ordt_amount) - orderVO.pay_price}" /></td>
                                        </tr>
                                        
                                        <tr>
                                          <td width="20%">총 결제금액</td>
                                          <td><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.pay_price}" /></td>
                                        </tr>
                                        
                                        <tr>
                                          <td width="20%">결제수단</td>
                                          <td>${orderVO.pay_method == 'kakaopay' ? '카카오페이' : '무통장입금'}</td>
                                        </tr>
                                        
                                        <tr>
                                          <td width="20%">결제일</td>
                                          <td><fmt:formatDate value="${orderVO.pay_date}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        </tr>
                                      </table>
                                </div>
                            </li>
                            <!-- 주문 상품정보 -->
                            <li class="insert-list">
                                <div class="insert-lt">주문 상품정보<span>*</span></div>
                                <div class="insert-rt">
                                  <table class="table table_borderd" >
                                      <tr>
                                        <td width="15%">이미지</td>
                                        <td width="30%">상품명</td>
                                        <td width="15%">판매가</td>
                                        <td width="5%">수량</td>
                                        <td width="15%">총 구매금액</td>
                                        <td width="10%">주문상태</td>
                                        <td width="10%">주문취소</td>
                                      </tr>
                                        <tr>
                                          <td><a href="/product/pro_detail/${orderVO.pro_num}"><img src="/admin/order/displayImage?folderName=${orderVO.pro_up_folder }&fileName=s_${orderVO.pro_up_img}" alt=""></a></td>
                                          <td><a href="/product/pro_detail/${orderVO.pro_num}">${orderVO.pro_name}</a></td>
                                          <td><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.pro_dis_price}" /></td>
                                          <td>${orderVO.ordt_amount}</td>
                                          <td><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.pay_price}" /></td>
                                          <td>${orderVO.ord_cancel == 'Y' ? '주문취소' : '배송준비중'}</td>
                                          <td>
                                            <c:if test="${orderVO.ord_cancel == 'Y' }"></c:if>
                                            
                                            <c:if test="${orderVO.ord_cancel == 'N' }">
                                              <button type="button" data-ord_code="${orderVO.ord_code}" class="btn btn-danger">취소</button>
                                            </c:if>
                                          
                                          </td>
                                        </tr>
                                    
                                  </table>
                                </div>
                            </li>
                            <!-- 주문 상품정보 -->
                        </ul>
                    </div>
                    <div class="insert-footer">
                        <div style="display:flex; justify-content: center;">
                            <button type="button" class="btn" id="btnInsert" onclick="history.go(-1);">뒤로가기</button>
                        </div>
                    </div>
                  </form>
                </div>
            </div>
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
  <script>
    let msg = '${msg}';
      if(msg == success){
        alert("답변이 완료되었습니다.");
      }
  </script>
</body>
</html>