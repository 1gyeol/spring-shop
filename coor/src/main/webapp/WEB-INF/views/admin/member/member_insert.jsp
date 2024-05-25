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
  <title>관리자페이지 | 회원관리 | 회원등록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>  
  <script src="/resources/dist/js/join.js"></script>
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
        회원등록
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 회원관리</a></li>
        <li class="active">회원등록</li>
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
     			<form id="joinForm" action="" method="post">
     			<div class="box-body">	
            <!-- 아이디 -->
            <div class="form-group row" style="display: flex; align-items: center;">
              <label for="mb_id" class="col-sm-2 col-form-label">아이디</label>
					    <div class="col-sm-6" style="display: flex;">
					      <input type="text" class="form-control" id="mb_id" name="mb_id" placeholder="아이디를 입력해주세요.">
                <button type="button" id="BtnIdChk" class="button btn-red" style="width: 150px; margin-left: 10px;"  onclick="checkId();">중복확인</button>
              </div>
            </div>
            <!-- 아이디 -->
            <!-- 비밀번호 -->
					  <div class="form-group row" style="display: flex; align-items: center;">
              <label for="mb_pw" class="col-sm-2 col-form-label">비밀번호</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" id="mb_pw" name="mb_pw" placeholder="비밀번호를 입력해주세요.">
					    
              </div>
            </div>
            <!-- 비밀번호 -->
            <!-- 비밀번호 확인 -->
					  <div class="form-group row" style="display: flex; align-items: center;">
              <label for="mb_pwChk" class="col-sm-2 col-form-label">비밀번호 확인</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" id="mb_pwChk" name="mb_pwChk" placeholder="비밀번호를 입력해주세요.">
					    
              </div>
            </div>
            <!-- 비밀번호 -->
            <!-- 이름 -->
					  <div class="form-group row" style="display: flex; align-items: center;">
              <label for="mb_name" class="col-sm-2 col-form-label">이름</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" id="mb_name" name="mb_name" placeholder="이름을 입력해주세요.">
              </div>
            </div>
            <!-- 이름 -->
            <!-- 휴대폰 번호 -->
            <div class="form-group row" style="display: flex; align-items: center;">
					    <label for="mb_phone" class="col-sm-2 col-form-label">휴대폰 번호</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" id="mb_phone" name="mb_phone" placeholder="휴대폰번호를 입력해주세요.">
              </div>
					  </div>
            <!-- 휴대폰 번호 -->

            <!-- 이메일 주소 -->
            <div class="form-group row" style="display: flex; align-items: center;">
					    <label for="mb_email" class="col-sm-2 col-form-label">이메일 주소</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" id="mb_email" name="mb_email" placeholder="이메일 주소를 입력해주세요.">
              </div>
					  </div>
            <!-- 이메일 주소 -->

            <!-- 생년월일 -->
					  <div class="form-group row" style="display: flex; align-items: center;">
					    <label for="mb_birth" class="col-sm-2 col-form-label">생년월일</label>
              <div class="col-sm-4">
					      <input type="text" class="form-control" id="mb_birth" name="mb_birth" placeholder="생년월일을 입력해주세요. 예)19930722">
              </div>
					  </div>
            <!-- 생년월일 -->  
     			</div>
     			<div class="box-footer">
     				<div class="form-group">
     					<ul class="uploadedList"></ul>
     				</div>    				
     				<div class="form-group row">
						  <div class="col-sm-12 text-center">
						  	<button type="button" class="btn btn-dark" id="btnMember"  onclick="goJoin();">회원등록</button>
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

<!-- REQUIRED JS SCRIPTS -->

<%@include file="/WEB-INF/views/admin/include/plugin2.jsp"%>
</body>
</html>