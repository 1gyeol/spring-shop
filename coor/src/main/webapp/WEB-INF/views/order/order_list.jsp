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
</head>
<body>
  <div class="wrapper">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <div class="order container">
    <div class="container-inner-wrap"> 
      <div class="pricing-header py-3 pt-md-5 pb-md-4 mx-auto text-left">
        <h4 class="display-4">주문목록</h4>
      </div>
      <div class="row pt20">    
        <div class="col-md-12">
          <div class="box">
            <div class="box-body">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th style="width: 15%">주문번호</th>
                    <th style="width: 15%">주문일시</th>
                    <th style="width: 40%">상품정보</th>
                    <th style="width: 5%">수량</th>
                    <th style="width: 15%">구매금액</th>
                    <th style="width: 10%">취소/교환/반품</th>
                  </tr>  
                </thead>
                <tbody>             
                      <c:forEach items="${orderList}" var="orderVO">
                        <tr>
                          <td><button type="button" id="ordDetailBtn" class="btn btn-link" data-ord_code="${orderVO.ord_code}">${orderVO.ord_code}</button></td>
                          <td><fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                          <td>
                            <a href="/product/pro_detail/${orderVO.pro_num}">
                              <img src="/order/displayImage?folderName=${orderVO.pro_up_folder }&fileName=s_${orderVO.pro_up_img}" alt="" class="mr15">
                              <span>${orderVO.pro_name}</span>
                            </a>
                          </td>
                          <td>${orderVO.ordt_amount}</td>
                          <td>
                            <input name="pay_method" type="hidden" value="${orderVO.pay_method}" />
                            <fmt:formatNumber type="currency" pattern="KRW #,###" value="${orderVO.ord_price}"/>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${orderVO.ord_cancel == 'N'}">
                                <button type="button" name="btn_orderCancel" data-ord_code="${orderVO.ord_code }" class="btn btn-link">주문취소</button>
                              </c:when>
                              <c:otherwise>
                                취소 완료
                              </c:otherwise>
                            </c:choose>
                            
                          </td>
                        </tr>
                      </c:forEach>  
                </tbody>
                
                <c:if test="${empty orderList}">  
                  <tfoot>         	
                    <tr>
                      <td colspan="6" class="text-center">[주문 내역이 없습니다.]</td>
                    </tr>
                  </tfoot>
                </c:if>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="row pt100">
        <div class="col-md-12">
          <div class="pagination">        
            <ul>
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
          </div>
          <!-- 페이징정보. Criteria 클래스 필드정보작업 -->
          <form id="actionForm" action="/order/order_list" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <!-- 
            <input type="hidden" name="type" value="${pageMaker.cri.type}">
            <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
            -->              
          </form>
        </div>
      </div>
    </div>  
  </div>
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>
  </body>
  <script>

    $("button[name='btn_orderCancel']").on("click", function(){

      let ord_code = $(this).data("ord_code");      
      let pay_method = $(this).parent().siblings().find("input[name='pay_method']").val();
	    
	  
      console.log(ord_code);      
      console.log(pay_method);
      
      if(!confirm("주문을 취소하시겠습니까?")) return;

      $.ajax({
        url: '/order/pay_cancel',
        type: 'get',
        contentType: 'application/json',
        data: {"ord_code" : ord_code, "pay_method" : pay_method},
        success:function(result){
            if(result == "success"){ 
                alert("주문이 취소되었습니다.");
                location.reload(true);
            }else{
                alert("이미 주문 최소되었습니다.");
                location.reload(true);         
            }
        },
        error:function(request,status,error){        
        console.log("code:"+request.status+"\n"+"\n"+"error:"+error);       
        }
      });

    });
    
  </script>
  
  <script>
      let actionForm = $("#actionForm"); // 페이징정보가 있는 form태그. Criteria클래스 필드정보

      // 페이지 번호, 이전, 다음 클릭시 actionForm 태그가 전송으로 사용된다.(중요)
      //페이지번호, 이전, 다음 클릭    <ul class="pagination.  
      $(".pagination a").on("click", function(e) {
        e.preventDefault(); // a태그의 하이퍼링크 기능이 취소.

        // /board/list?pageNum=선택한페이지번호&amount=10

        // 현재 페이지번호 변경작업
        // form태그의 정보  
        // <input type="hidden" name="pageNum" value="1">
        // <input type="hidden" name="amount" value="10">
        actionForm.attr("action", "/order/order_list");
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));

        actionForm.submit();
      });
      
      
      $("#ordDetailBtn").on("click", function(){
      
      	let ord_code = $(this).data("ord_code");    
      	
        actionForm.append("<input type='hidden' name='ord_code' value='" + ord_code + "'>");
        actionForm.attr("method", "get");
        actionForm.attr("action", "/order/order_detail");
      	
        actionForm.submit();    	
      
      });
  
  </script>
</html>