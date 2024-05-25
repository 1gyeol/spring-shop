<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - ORDER</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
    <meta name="theme-color" content="#563d7c">

    


    <!-- Favicons 
<link rel="apple-touch-icon" href="/docs/4.6/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/4.6/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/4.6/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/4.6/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/4.6/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
<link rel="icon" href="/docs/4.6/assets/img/favicons/favicon.ico">
<meta name="msapplication-config" content="/docs/4.6/assets/img/favicons/browserconfig.xml">
-->
<meta name="theme-color" content="#563d7c">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
   
    
  </head>
  <body>

<div class="wrapper">
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="order container">
  <div class="container-inner-wrap"> 
    <div class="pricing-header py-3 pt-md-5 pb-md-4 mx-auto text-left">
      <h4 class="display-4">주문 상세내역</h4>
    </div>
    <div class="row pt20">
      <div class="col-md-12">
        <div class="box">
          <!-- 주문정보 start -->
          <h4 class="mb-3">주문정보</h4>
          <div class="row border-top pt-3">
              <div class="col-md-2">
                <label for="mb_name">주문자 이름</label>
              </div>
              <div class="col-md-10" id="d_mb_name">
                ${orderVO.ord_name }
              </div>
          </div>
          <div class="row pt-3">
            <div class="col-md-2">
              <label for="mb_phone">주문번호</label>
            </div>
            <div class="col-md-10">
              <p>${orderVO.ord_code }</p>
            </div>
          </div>
          <div class="row pt-3">
            <div class="col-md-2">
              <label for="mb_phone">주문일</label>
            </div>
            <div class="col-md-10">
              <p><fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy-MM-dd HH:mm"/></p>
            </div>
          </div>
          <div class="row pt-3">
            <div class="col-md-2">
              <label for="mb_email">배송지</label>
            </div>
            <div class="col-md-10">
              <p>
              	${orderVO.ord_zipcode} <br>
              	${orderVO.ord_addr} <br>
              	${orderVO.ord_deaddr}
              </p>
            </div>
          </div>
          <!-- 주문정보 end -->


          <!-- 결제 정보 start -->
          <h4 class="mb-3 mt-3 pt80">결제정보</h4>
          <div class="row border-top pt-3">
              <div class="col-md-2">
                <label for="ord_name">총 주문금액</label>
              </div>
              <div class="col-md-10">
                <p><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.ordt_price * orderVO.ordt_amount}" /></p>
              </div>
          </div>
          
          <div class="row pt-3">
            <div class="col-md-2">
              <label for="ord_name">총 할인금액</label>
            </div>
            <div class="col-md-10">
              <p><fmt:formatNumber type="currency" pattern="#,###" value="${(orderVO.ordt_price * orderVO.ordt_amount) - orderVO.pay_price}" /></p>
            </div>
        </div>
        <div class="row pt-3">
            <div class="col-md-2">
              <label for="ord_name">총 결제금액</label>
            </div>
            <div class="col-md-10">
              <fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.pay_price}" />
            </div>
        </div>
        <div class="row pt-3">
            <div class="col-md-2">
              <label for="ord_name">결제수단</label>
            </div>
            <div class="col-md-10">
              <p>${orderVO.pay_method == 'kakaopay' ? '카카오페이' : '무통장입금'}</p>
            </div>
        </div>
        <div class="row pt-3">
            <div class="col-md-2">
              <label for="ord_name">결제일</label>
            </div>
            <div class="col-md-10">
              <fmt:formatDate value="${orderVO.pay_date}" pattern="yyyy-MM-dd HH:mm"/>
            </div>
        </div>
        <!-- 결제 정보 end -->

        
        <!-- 주문 상품정보 start -->
        <h4 class="mb-3 mt-3 pt80">주문 상품정보</h4>
        <div class="row">
          <div class="col-md-12">
      
            <table class="table table-bordered">
              <tbody><tr>
                <th style="width: 50%">상품</th>
                <th style="width: 10%">수량</th>
                <th style="width: 10%">포인트</th>
                <th style="width: 10%">배송비</th>
                <th style="width: 10%">주문금액</th>
              </tr>
              
              <tr>
                <td>
                  <img src="/order/displayImage?folderName=${orderVO.pro_up_folder }&fileName=s_${orderVO.pro_up_img}" alt="">
                  ${orderVO.pro_name}
                  <input type="hidden" name="ord_code" value="${orderVO.pro_num}">
                </td>
                <td>${orderVO.ordt_amount}</td>
                <td>포인트 : 0</td>
                <td>
                  [기본배송조건]
                </td>
                <td><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.pay_price}" /></td>               
              </tr>
              
              
            </tbody>
            <tfoot>
              <tr>
                <td colspan="6" class="text-right">총 구매금액 : KRW <fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.pay_price}" /></td>
              </tr>
            </tfoot>
            </table>
          </div>
        </div>
        <!-- 주문 상품정보 end -->

        </div>
      </div>
    </div>
  </div> 

</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>
  </body>
</html>