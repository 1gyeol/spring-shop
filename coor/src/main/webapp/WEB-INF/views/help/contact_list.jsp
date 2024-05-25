<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - HELP - CONTACT</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
</head>
<body>
  <div class="wrapper">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <div class="contact container">
    <div class="container-inner-wrap">   
      <div class="pricing-header py-3 pt-md-5 pb-md-4 mx-auto text-left">
        <h4 class="display-4">문의목록</h4>
      </div>
      <div class="row pt20">    
        <div class="col-md-12">
          <div class="box">
            <div class="box-body">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th style="width: 5%"></th>
                    <th style="width: 60%">내용</th>
                    <th style="width: 10%">주문번호</th>
                    <th style="width: 15%">작성일</th>
                    <th style="width: 10%">처리상태</th>
                  </tr>  
                </thead>
                <tbody>             
                    <c:forEach items="${contactList}" var="contactVO">
                      <tr class="contact-header">
                        <td></td>
                        <td class="contact-title">${contactVO.contact_title}</td>
                        <td>
                          ${contactVO.ord_code}	
                        </td>
                        <td><fmt:formatDate value="${contactVO.contact_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                          <c:choose>
                            <c:when test="${contactVO.contact_status == 'Y'}">
                              <span style="color: #14aaff;">답변 완료 </span>
                            </c:when>
                            <c:otherwise>
                              <span style="color: #ff20aa;">미답변</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                      <!-- 내용 -->
                      <tr class="moreView">
                        <td></td>
                        <td>${contactVO.contact_content}</td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                      <!-- 내용 -->
                      <!-- 답변 내용 -->
                        <c:choose>
                          <c:when test="${contactVO.contact_status == 'Y'}">
                            
                          <tr class="moreView">
                            <td></td>
                            <td>답변 : <br/>
                            ${contactVO.contact_re}
                            </td>
                            <td>&nbsp;</td>
                            <td class="text-center"><fmt:formatDate value="${contactVO.contact_re_date}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td class="text-center">
                              <span style="color: #14aaff;">답변 완료 </span>
                            </td>
                          </tr>
                          </c:when>
                          <c:otherwise>
                          </c:otherwise>
                        </c:choose>
                      <!-- 답변 내용 -->
                    </c:forEach>  
                </tbody>
                
                <c:if test="${empty contactList}">  
                  <tfoot>         	
                    <tr>
                      <td colspan="5" class="text-center" style="padding:25px 0;">[문의 내역이 없습니다.]</td>
                    </tr>
                  </tfoot>
                </c:if>
              </table>
              
            </div>
          </div>
        </div>
        <div class="col-md-12">
          <button type="button" class="btn btn-dark float-end mt30" onclick="location.href='/help/contact'">글쓰기</button>        
        </div>
      </div>
      <div class="row mt30">
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
          <form id="actionForm" action="/help/contact_list" method="get">
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
  
    $(document).ready(function() {
  
      $(".contact-title").on("click", function(){
  
        let content = $(this).parent().next();
        let reply = $(this).parent().next().next();
          
        if (content.hasClass("on") == false){
            content.addClass("on");
            reply.addClass("on");
            
        }else{
            content.removeClass("on"); 
            reply.removeClass("on");    	
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
        actionForm.attr("action", "/help/contact_list");
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));

        actionForm.submit();
      });
  
  </script>
  
</html>