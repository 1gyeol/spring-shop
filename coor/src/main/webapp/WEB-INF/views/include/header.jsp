<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav id="skip-nav">
	<a href="#section">본문 바로가기</a>
</nav>
<header id="header" class="header">
    <div class="header-wrap container">
        <div class="header-inner-wrap">
            <div class="logo-wrap">
                <h1 class="logo">
                    <a href="/">
                        <img src="https://coor.kr/add/img/logo.svg" alt="coor logo">
                    </a>
                </h1>
            </div>
            <ul class="menu">
                <li class="op"><a href="javascript:void(0);">shop</a>
                    <div class="sub-menu category">
                        <ul>
                            <c:forEach items="${cateList}" var="categoryVO">
                                <li class="main-cate">
                                    <a href="javascript:void(0);">${categoryVO.cat_name}</a> 
                                    <ul class="sub-cate">
                                    <c:forEach items="${subCateList}" var="subCategoryVO">                                          
                                        <c:if test="${subCategoryVO.cat_prtcode == categoryVO.cat_code}">
                                        <li>
                                            <a href="/product/pro_list/${subCategoryVO.cat_code}">${subCategoryVO.cat_name}</a> 
                                        </li>
                                        </c:if>                                   
                                    </c:forEach>
                                    </ul>
                                </li>
                            </c:forEach>
                        
                        </ul>
                    </div>
                </li> 
                <li class="op"><a href="javascript:void(0);">collection</a>
                    <div class="sub-menu">
                        <div class="lookbook_list">
                            <ul>
                            	<c:forEach items="${colList}" var="collectionVO" >
                            	<li><a href="/collection/col_detail/${collectionVO.col_num}">${collectionVO.col_name}</a></li>
                            	</c:forEach>						
                            </ul>
                        </div>			
                    </div>
                </li>  
                <li><a href="/store">store</a></li>
                <li><a href="/help/help">help</a></li>	
                <!--로그인 전 -->	
                <c:if test="${sessionScope.loginStatus == null}">		
                    <li><a href="/member/login">login</a></li>
                    <li><a href="/member/login" data-selectside="cart">cart</a></li>
                </c:if>
                <!--로그인 전 -->	
                <!--로그인 후 -->	
                <c:if test="${sessionScope.loginStatus != null}">
                    <li><a href="/member/myshop">mypage</a></li>
                    <li><a href="/member/logout">logout</a></li>
                    <li><a href="/cart/cart_list" data-selectside="cart">cart<span>(${cart_amount})</span></a></li>
                </c:if>
                <!--로그인 후 -->
            </ul>
        </div>
    </div>
    
</header>
<!-- 로그아웃 팝업 -->
<div id="logoutModal" class="modal fade" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content logout-modal-content">
            <h2 class="modal-title logout-title">로그아웃</h2>
            <div>로그아웃 하시겠습니까?</div>
            <div class="modal-footer mt20">
                <button type="button" class="button red mr10" onclick="location.href='/member/logout'">확인</button>
                <button type="button" class="button" data-bs-dismiss="modal">취소</button>
            </div>	
        </div>
     </div>
</div>
