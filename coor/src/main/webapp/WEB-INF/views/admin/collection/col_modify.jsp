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
  <title>관리자페이지 | 컬렉션 관리 | 컬렉션 목록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp"%>
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
      <h1>컬렉션 수정
        <small>Modify Collection</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
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
     			<form id="productForm" action="" method="post" enctype="multipart/form-data">
     			<div class="box-header">
     				MODIFY COLLECTION
     			</div>
     			<div class="box-body">	
					  <div class="form-group row">
					    <div class="col-sm-3">
					    	<input type="hidden" name="pageNum" value="${cri.pageNum }">
					    	<input type="hidden" name="amount" value="${cri.amount }">
					    	<input type="hidden" name="type" value="${cri.type }">
					    	<input type="hidden" name="keyword" value="${cri.keyword }">
					    </div>
					  <div class="form-group row">
					    <label for="col_name" class="col-sm-2 col-form-label">컬렉션명</label>
					    <div class="col-sm-4">
					      <input type="hidden" class="form-control" id="col_num" name="col_num" value="${collectionVO.col_num}">
					      <input type="text" class="form-control" id="col_name" name="col_name" value="${collectionVO.col_name}">
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="col_content" class="col-sm-2 col-form-label">컬렉션 설명</label>
					    <div class="col-sm-10">
					      <textarea class="form-control" id="col_content" name="col_content" rows="3">${collectionVO.col_content}</textarea>
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="col_show" class="col-sm-2 col-form-label">게시글 노출여부</label>
					    <div class="col-sm-4">
					      <select id="col_show" name="col_show">
					      	<option value="Y" ${collectionVO.col_show == 'Y' ? 'selected':''}>보이기</option>
					      	<option value="N" ${collectionVO.col_show == 'N' ? 'selected':''}>숨기기</option>
					      </select>
					    </div>
					  </div>	  
				 
     			</div>
     			<div class="box-footer">
     				<div class="form-group">
     					<ul class="uploadedList"></ul>
     				</div>    				
     				<div class="form-group row">
						  <div class="col-sm-12 text-center">
						  	<button type="submit" class="btn btn-dark" id="btnProduct">컬렉션 수정</button>
						  	<button type="button" name="btnCancel" class="btn btn-danger" onclick="history.go(-1);">취소</button>
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
      filebrowserUploadUrl : '/admin/collection/imageUpload' // 업로드 탭 표시
    }

    // <textarea class="form-control" id="col_content" name="col_content" rows="3"></textarea>
    CKEDITOR.replace("col_content", ckeditor_config);

    console.log("버전: " + CKEDITOR.version);

    //파일첨부 이미지 미리보기.  <input type="file" class="form-control" id="uploadFile" name="uploadFile">
    $("#uploadFile").on("change", function(e) {
      let file = e.target.files[0];  // 선택한 파일들중 첫번째 파일

      let reader = new FileReader(); // 첨부된 파일을 읽기위한 파일입력객체.

      // reader객체가 파일을 로딩했을 때.
      reader.onload = function(e) {
        $("#change_img").attr("src", e.target.result);
      }

      reader.readAsDataURL(file); // reader객체에 파일객체를 할당
    });

  });
</script>
</body>
</html>