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
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>
  <style>
  	.insert-list { width: 100%; display:flex; padding: 2rem 0; border-bottom: 1px solid #dcdbe4;}
	.insert-list .insert-lt {width: 20rem; font-size: 18px; display: flex; }
	.insert-list .insert-rt {flex: 1 1 0%; position: relative; display:flex; flex-direction: column;}
	.insert-list .insert-rt p {margin-bottom: 0 !important;}
	.insert-list .insert-rt .flex-wrap { flex-wrap: wrap;}
	.insert-list .insert-rt input[type="text"] { width: 100%; height: 3rem; padding: 0px 1rem; border: 1px solid #c3c2cc;}
	.insert-list .insert-rt label { display: inline-flex; font-size: 1rem;}
	.insert-list .insert-rt div.insert-category { width: 100%; display:flex; height: 19rem; overflow:hidden; border: 1px solid rgb(220, 219, 228);}
	.insert-list .insert-rt div.insert-category div { width: 100%; display:flex; position:relative;}
  	.insert-list .insert-rt div.insert-category div table tbody tr td { vertical-align: middle;}
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
        문의하기
        <small>CONTACT US</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 문의관리</a></li>
        <li class="active">문의하기</li>
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
              CONTACT US
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
                            <!-- 문의 유형 -->
                            <li class="insert-list">
                              <div class="insert-lt">문의유형<span>*</span></div>
                              <div class="insert-rt" style="flex-direction: column; align-items: flex-start;">
                                  <div class="form-check">
                                    <p>
                                      <c:choose>
                                        <c:when test="${contactVO.contact_type == 1}">배송</c:when>
                                        <c:when test="${contactVO.contact_type == 2}">주문/결제</c:when>
                                        <c:when test="${contactVO.contact_type == 3}">취소/환불</c:when>
                                        <c:otherwise>서비스</c:otherwise>
                                      </c:choose>
                                    </p>
                                  </div>
                              </div>
                            </li>
                            <!-- 문의 유형 -->
                            <!-- 주문 내역 -->
                            <li class="insert-list">
                                <div class="insert-lt">주문번호<span>*</span></div>
                                <div class="insert-rt">
                                  <div class="insert-category">
                                        <div class="main-category">
                                          <table class="table table_borderd" style="height:100px;">
                                            <thead>
                                              <tr>
                                                <td width="5%"></td>
                                                <td width="60%">상품정보</td>
                                                <td width="15%">주문번호</td>
                                                <td width="20%">주문일자</td>	
                                              </tr>
                                            </thead>
                                            <tbody>
                                                  <tr style="cursor: pointer;" >
                                                    <td></td>
                                                    <td class="text-start d-flex align-items-center"><img src="/help/displayImage?folderName=2024/04/11&amp;fileName=s_9371d5bd-0fd3-41eb-ac00-720746964954_00502597_20190212.jpg" style="margin-right: 30px;"><span>테스트</span></td>
                                                    <td>79</td>
                                                    <td>2024-04-26 17:03</td>
                                                  </tr>
                                            </tbody>
                                          </table>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <!-- 주문 내역 -->
                            <!-- 제목 -->
                            <li class="insert-list">
                                <div class="insert-lt">제목<span>*</span></div>
                                <div class="insert-rt">
                                  <p>${contactVO.contact_title }</p>
                                </div>
                            </li>
                            <!-- 내용 -->
                            <li class="insert-list">
                                <div class="insert-lt">내용<span>*</span></div>
                                <div class="insert-rt">
                                  <p>${contactVO.contact_content }</p>
                                  <br><br><br>
                                  <p>문의 시간 : <fmt:formatDate value="${contactVO.contact_regdate}" pattern="yyyy-MM-dd HH:mm"/></p>
                                </div>
                            </li>
                            
                            <!-- 관리자 답변 start -->
                            <li class="insert-list">
                              <div class="insert-lt">답변<span>*</span></div>
                              <div class="insert-rt">
                                <input type="hidden" name="contact_num" id="contact_num" value="${contactVO.contact_num}" />
                              	<textarea class="form-control" id="contact_re" name="contact_re" rows="3"  wrap="hard">${contactVO.contact_re}</textarea>
                              	<br><br><br>
                              	<p>답변 시간 : <fmt:formatDate value="${contactVO.contact_re_date}" pattern="yyyy-MM-dd HH:mm"/></p>
                              </div>
                             </li>
                          
                            <!-- 관리자 답변 end -->
                        </ul>
                    </div>
                    <div class="insert-footer">
                        <div style="display:flex; justify-content: center;">
                            <button type="submit" class="btn btn-dark" id="btnReply" style="margin-right: 15px;">답변하기</button>
                            <button type="button" class="btn" id="btnInsert" onclick="history.go(-1);">취소</button>
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

<!-- REQUIRED JS SCRIPTS -->

<%@include file="/WEB-INF/views/admin/include/plugin2.jsp"%>
<script src="/bower_components/ckeditor/ckeditor.js"></script>

<script>
  $(document).ready(function() {
    // ckeditor 버전: 4.12.1 (Standard)환경설정. javascript object구문사용
    let ckeditor_config = {
      resize_enabled : false,
      enterMode : CKEDITOR.ENTER_BR,
      shiftEnterMode : CKEDITOR.ENTER_P,
      toolbarCanCollapse : true,
      removePlugins : "elementspath",
      filebrowserUploadUrl : '/admin/contact/imageUpload' // 업로드 탭 표시
    }

    // <textarea class="form-control" id="contact_re" name="contact_re" rows="3"></textarea>
    CKEDITOR.replace("contact_re", ckeditor_config);

    console.log("버전: " + CKEDITOR.version);

  });
</script>

  <script>
    let msg = '${msg}';
      if(msg == success){
        alert("답변이 완료되었습니다.");
      }
  </script>
</body>
</html>