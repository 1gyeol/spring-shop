<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - SHOP - ${cat_prtcode.cat_name} - ${cat_code.cat_name}</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body>
  <div class="wrapper">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

    <div class="shop container">
      <div class="container-inner-wrap">
        <div class="category-wrap d-flex pt20">
      <a href="javascript:void(0);">${cat_prtcode.cat_name}</a>
      <span style="margin:0 10px;">/</span>
      <a href="/product/pro_list/${cat_code.cat_code}">${cat_code.cat_name}</a>    
      </div>
      <div class="row pt20">
        <div class="card-deck mb-3 text-center row">
          <c:forEach items="${proList }" var="productVO">
          <div class="col-md-3">
            <a class="move" href="${productVO.pro_num}">
            <div class="card mb30">
                <img src="/product/displayImage?folderName=${productVO.pro_up_folder }&fileName=${productVO.pro_up_img}" class="card-img-top" alt="...">
                        
              <div class="card-body">
                <div>
                  <span>${productVO.pro_name}</span>
                </div>
                <div>              
                  <ul>
                  <c:choose>
                    <c:when test="${productVO.pro_discount > 0}">
                      <li><span style="text-decoration:line-through;" ><fmt:formatNumber type="currency" pattern="KRW #,###" value="${productVO.pro_price}"/></span></li>
                      <li><span><fmt:formatNumber type="currency" pattern="KRW #,###" value="${productVO.pro_dis_price}"/></span></li>
                    </c:when>
                    <c:otherwise>
                      <li><span><fmt:formatNumber type="currency" pattern="KRW #,###" value="${productVO.pro_dis_price}"/></span></li>
                    </c:otherwise>             	
                  
                  </c:choose>
                  </ul>
                  <span><c:out value="${productVO.pro_buy == 'N' ? 'SOLD OUT' : ''}"></c:out></span>
                </div>
              </div>
            </div>
            </a> 
          </div>
          </c:forEach>
          
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
          <form id="actionForm" action="/product/pro_list" method="get">
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

<script>

    $(document).ready(function() {

      let actionForm = $("#actionForm"); // 페이징정보가 있는 form태그. Criteria클래스 필드정보

      // 상품명 또는 상품이미지 클릭
      $("a.move").on("click", function(e) {
        e.preventDefault(); // a태그의 하이퍼링크 기능이 취소.

        let pro_num = $(this).attr("href");
        
        console.log("상품코드: " + pro_num);

        //location.href = "/board/get?bno=" + bno;
        // 목록에서 글번호 선택후, 다시 뒤로가기버튼 클릭시 나타나는 문제발생때문에 아래코드 작업이 필요.
        actionForm.find("input[name='pro_num']").remove();

        actionForm.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
        actionForm.attr("action", "/product/pro_detail");

        actionForm.submit();

      });

      // 페이지 번호, 이전, 다음 클릭시 actionForm 태그가 전송으로 사용된다.(중요)
       
      $(".pagination a").on("click", function(e) {
        e.preventDefault(); // a태그의 하이퍼링크 기능이 취소.

        // /product/pro_list?pageNum=선택한페이지번호&amount=10

        // 현재 페이지번호 변경작업
        // form태그의 정보  
        // <input type="hidden" name="pageNum" value="1">
        // <input type="hidden" name="amount" value="10">
        actionForm.attr("action", "/product/pro_list/${cat_code.cat_code}");
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));

        actionForm.submit();
      });

      // 장바구니 클릭
      $("button[name=btn_cart]").on("click", function() {

        $.ajax({
          url: '/cart/cart_add',
          type: 'post',
          data: {pro_num : $(this).data("pro_num"), cart_amount : 1},
          success: function(result) {
            if(result == "success") {
              alert("장바구니에 추가됨");
              if(confirm("장바구니로 이동하겠읍니까?")) {
                location.href = "/cart/cart_list";
              }
            }
          }
        });
      });

      // 바로구매(주문정보 입력폼)
      $("button[name='btn_direct_order']").on("click", function() {


        // /cart/direct_cart_add?pro_num=1&cart_amount=1
        let url = "/cart/direct_cart_add?pro_num=" + $(this).data("pro_num") + "&cart_amount=1";
        
        console.log("url: " + url);
        
        location.href = url;
      });


    }); // ready event end 



  </script>
    
  </body>
</html>