<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="/resources/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p><c:out value="${sessionScope.adminStatus.admin_name}"/></p>
          <!-- Status -->
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>

      <!-- search form (Optional) -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
              </button>
            </span>
        </div>
      </form>
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu tree" data-widget="tree">
        <li class="header">메뉴</li>
        <!-- Optionally, you can add icons to the links -->

        <!-- 회원관리 시작 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i><span>회원관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/member/member_insert">회원등록</a></li>
            <li><a href="/admin/member/member_list">회원목록</a></li>
            <li><a href="/admin/member/member_del_list">탈퇴회원목록</a></li>
          </ul>
        </li>
        <!-- 회원관리 끝 --> 

        <!-- 상품관리 시작 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i><span>상품관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/product/pro_insert">상품등록</a></li>
            <li><a href="/admin/product/pro_list">상품목록</a></li>
          </ul>
        </li>
        <!-- 상품관리 끝 -->

        <!-- 주문관리 시작 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i><span>주문관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/order/order_list">주문목록</a></li>
            <li><a href="/admin/order/order_cancel_list">주문취소목록</a></li>
            <li><a href="#">장바구니 관리</a></li>
          </ul>
        </li>
        <!-- 주문관리 끝 -->
         
        <!-- 컬렉션관리 시작 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i><span>컬렉션관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/collection/col_insert">컬렉션등록</a></li>
            <li><a href="/admin/collection/col_list">컬렉션목록</a></li>
          </ul>
        </li>
        <!-- 컬렉션관리 끝 -->

        <!-- 문의관리 시작 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i><span>문의관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/contact/contact_list">문의목록</a></li>
          </ul>
        </li>
        <!-- 문의관리 끝 -->
        
        <!-- 통계관리 시작 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i><span>통계관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/chart/overall">매출통계</a></li>
          </ul>
        </li>
        <!-- 통계관리 끝  -->

      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>