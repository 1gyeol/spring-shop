<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - MYPAGE</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
    <style>
        .move { cursor: pointer;}
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- header start -->
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <!-- header end -->
        <section id="section" class="section">
            <div class="profile-wrap">
                <div class="profile-inner-wrap">
                    <!-- col-wrap -->
                    <div class="col-wrap">
                        <!-- col -->
                        <div class="col">
                        	<div class="d-flex justify-content-between mb30">
                        		<span>MY PROFILE</span>
                        		<a class="btn-link" href="/member/modify">수정</a>
                        	</div>
                            <!--
                            <div class="d-flex justify-content-between mb10">
                                <span>적립금</span>
                                <span><fmt:formatNumber type="currency" pattern="KRW #,###" value="${totalPrice}"/>원</span>
                            </div>
                            -->
                            <div class="d-flex justify-content-between mb10">
                                <span>문의내역</span>
                                <div class="d-flex">
                                    <span class="mr5">(<a href="/help/contact_list" class="btn-link" style="display:inline-block;">${contactCount}</a>) 건</span>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mb30">
                                <span>총 주문</span>
                                <span><fmt:formatNumber type="currency" pattern="KRW #,###" value="${orderInfo.totalPrice}"/>(${orderInfo.totalCount})회</span>
                            </div>
                            <div>
                                <div class="d-flex justify-content-between">
                                    <span>ORDER</span>
                                    <a class="btn-link" href="/order/order_list">모두보기</a>
                                </div>
                                <div>
                                    <c:choose>  
                                        <c:when test="${empty orderList}">
                                            <p style="padding:50px 0; text-align: center;">EMPTY</p>
                                        </c:when>
                                        <c:otherwise>
                                            <table class="table table-bordered">
                                            	<thead>
                                                    <tr>
                                                        <th style="width: 20%">주문번호</th>
                                                        <th style="width: 20%">상품명</th>
                                                        <th style="width: 20%">주문금액</th>
                                                        <th style="width: 20%">결제방식</th>     
                                                        <th style="width: 20%">주문일시</th> 
                                                    </tr> 
                                            	</thead>
                                                <tbody>                                                           
                                                    <c:forEach items="${orderList}" var="orderVO">                                        
                                                        <tr class="move" data-ord_code="${orderVO.ord_code}">
                                                            <td>${orderVO.ord_code}</td>
                                                            <td>${orderVO.pro_name}</td>                                                            
                                                            <td><fmt:formatNumber type="currency" pattern="KRW #,###" value="${orderVO.ord_price}"/></td>
                                                            <td>${orderVO.pay_method == 'kakaopay' ? '카카오페이' : '무통장입금'}</td>
                                                            <td><fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                        </tr>                                	
                                                    </c:forEach>
                                                </tbody>
                                            </table>           
                                        </c:otherwise>
                                    </c:choose>  
                                    
                                </div>
                            </div>
                        </div>
                        <!--// col -->
                    </div>
                    <!--// col-wrap -->
                </div>
            </div>
             <form id="actionForm" action="" method="get"></form>
        </section>
        <!-- footer start -->
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
        <!-- footer end -->
    </div>
</body>
<script>
    $(document).on("click",".move", function(){
    
    	let actionForm = $("#actionForm");
        let ord_code = $(this).data("ord_code");
        
        actionForm.append("<input type='hidden' name='ord_code' value='" + ord_code + "'>");
        actionForm.attr("method", "get");
        actionForm.attr("action", "/order/order_detail");
      	
        actionForm.submit();  
    });
</script>
</html>