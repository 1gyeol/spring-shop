<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - SHOP - ${productVO.cat_name}</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
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
	  /* 상품후기 쓰기에서 별 표시 */
      a.rv_score {
        font-size: 22px;
        text-decoration: none;
        color: lightgray;
      }
	   /* 상품후기 쓰기에서 별 클릭시 적용 */
      a.rv_score.on {
        color: #ff972c;
      }
    </style>
	  
    
</head>
<body>
    
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="container">
  <div class="detail-wrap pt50 pb50">
    <div class="row detailArea d-flex">
      <div class="col-md-8 detail-img">        
		${productVO.pro_img_content}
      </div>
      <div class="col-md-4 detail-info">
        <p>${productVO.pro_name}</p>
        
        <c:choose>
        <c:when test="${productVO.pro_discount > 0}">
           <p style="text-decoration:line-through;" ><fmt:formatNumber type="currency" pattern="KRW #,###" value="${productVO.pro_price}"/></p>
           <p><fmt:formatNumber type="currency" pattern="KRW #,###" value="${productVO.pro_dis_price}"/></p>
        </c:when>
        <c:otherwise>
           <p><fmt:formatNumber type="currency" pattern="KRW #,###" value="${productVO.pro_price}"/></p>
        </c:otherwise>            	
              
        </c:choose>        
        <div class="d-flex" style="padding: 10px 0;">
          <span style=" padding-right:60px;">SIZE</span>
          <ul class="d-flex size-wrap">       	
            <li><a href="javascript:void(0);" value="S" style="padding: 0 20px; margin-right:5px; " ${productVO.pro_size_s != 0 ? '' : 'class="not-allowed" disabled'}>S</a></li>
            <li><a href="javascript:void(0);" value="M" style="padding: 0 20px; margin-right:5px; " ${productVO.pro_size_m != 0 ? '' : 'class="not-allowed" disabled'}>M</a></li>
            <li><a href="javascript:void(0);" value="L" style="padding: 0 20px;" ${productVO.pro_size_l != 0 ? '' : 'class="not-allowed" disabled'}>L</a></li>
          </ul>
        </div>
        <p class="pb40">
        ${productVO.pro_content}
        </p>
        <c:if test="${sessionScope.loginStatus == null}">
        	<button type="button" class="btn btn-dark" onclick="location.href='/member/login'">ADD TO CART</button>
        	<button type="button" class="btn btn-Light" style="border: 1px solid #333;" onclick="location.href='/member/login'">바로구매</button>
        </c:if>
       	<c:if test="${sessionScope.loginStatus != null}">
        	<button type="button" name="btn_cart" data-pro_num="${productVO.pro_num}" class="btn btn-dark">ADD TO CART</button>
        	<button type="button" name="btn_direct_order" data-pro_num="${productVO.pro_num}" class="btn btn-Light" style="border: 1px solid #333;">바로구매</button>
        </c:if>
        </div> 
    </div>
  </div>

  <div class="review-wrap">
    <div class="row">
      <div class="col-md-12"> 
        <div id="tabs">
          <h2 class="pb20">REVIEWS</h2>
          <div id="pro_review" class="d-flex flex-column">            
            <!-- 상품후기목록및페이징작업 -->
            <!-- 상품후기목록이 출력되는 위치 -->
            <div id="replyList">
            </div>
            <div class="mt30">
            	<c:if test="${sessionScope.loginStatus == null}">
          		<button type="button" class="btn btn-dark float-end" onclick="location.href='/member/login'">글쓰기</button>
        		</c:if>
        
        		<c:if test="${sessionScope.loginStatus != null}">
          		<button type="button" class="btn btn-dark float-end" data-bs-toggle="modal" data-bs-target="#reviewModal">글쓰기</button>
        		</c:if>
            </div>
            <!-- 페이징 출력되는 위치 -->
            <div id="replyPaging" class="pagination mt30"></div>	    
          </div>
        </div>
      </div>
    </div>
  </div> 
</div>
<%@include file="/WEB-INF/views/include/footer.jsp" %>
<!-- 댓글쓰기 모달-->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reviewModalLabel">상품리뷰 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="rew_title" class="col-form-label">제목</label>
            <input type="text" class="form-control" id="rew_title">
          </div>
          <div class="mb-3">
            <label for="star_rv_score" class="col-form-label">평점</label>
            <div>
              <p id="star_rv_score" class="d-flex mr10">
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
                <a class="rv_score" href="#">★</a>
              </p>
            </div>
          </div>
          <div class="mb-3">
            <label for="rew_content" class="col-form-label">내용</label>
            <textarea class="form-control" id="rew_content"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" id="btn_review_write" class="btn btn-dark">등록</button>
      </div>
    </div>
  </div>
</div>
<!-- 댓글쓰기 모달-->
<!-- 댓글수정 모달-->

<div class="modal fade" id="reviewModifyModal" tabindex="-1" aria-labelledby="reviewModifyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reviewModifyModalLabel">상품리뷰 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
<!-- 댓글수정 모달-->

<!-- 1)Include Handlebars from a CDN -->
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<!-- 2)handlebars template. 댓글UI -->
<script id="replyViewTemplate" type="text/x-handlebars-template">
  <table class="table table-bordered">
    <thead>
      <tr>
        <th style="width: 10%">번호</th>
        <th style="width: 10%">별점</th>
        <th style="width: 40%">제목</th>
        <th style="width: 10%">작성자</th>
        <th style="width: 15%">작성일</th>
        <th style="width: 15%">비고</th>
      </tr>  
    </thead>
    <tbody>
      {{#each .}}
      <tr class="contact-header">
        <td>{{rn}}</td>
        <td class="rew_score">{{displayStar rew_score}} <input type="hidden" name="rew_score" value="{{rew_score}}"></td>
        <td style="text-align: left;"><a href="javascript:void(0);" data-rew_num="{{rew_num}}" class="rewBtn">{{rew_title}}</a></td>
        <td>{{mb_id}}</td>
        <td>{{convertDate rew_regdate}}</td>
        <td>
      {{authority mb_id rew_num}}
        </td>
      </tr>
      <tr class="moreView" id="rew_{{rew_num}}">
      	<td></td>      	
      	<td></td>
        <td>
        	<div class="view">{{rew_content}}</div>
        </td>
      	<td></td>
      	<td></td>
      	<td></td>
      </tr>
      {{/each}}
    </tbody>
  </table>
  
  <script>
    $(document).ready(function() {
      
    let noTextStr = '<tr><td colspan="6" class="text-center"><div style="padding:25px 0;">[작성된 후기가 없습니다.]</div></td></tr>';
      
    if( $(".table").find("tbody > tr").length == 0){
      $("tbody").append(noTextStr);
    }
    });

  </script>
</script>
<!-- 댓글 UI-->

<script>
  
  $(document).ready(function() {

    $(document).on("click", ".rewBtn", function(){
    
      let data = $(this).data("rew_num");
      let content = $(this).parent().parent().next();
      
      if (content.hasClass("on") == false){
          content.addClass("on");
      }else{
          content.removeClass("on");      	
      }
    });

  });    
</script>
<!-- Handlebar의 사용자정의 Helper. milisecond를 자바스크립트의 Date객체작업. -->
<script>
  // 날짜데이터가 json으로 변환되어, 밀리세컨드 단위로 된것을 다시 날짜로 변환작업.
  Handlebars.registerHelper("convertDate", function(timeValue) {
    const date = new Date(timeValue);

    return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
  })
  
  // 평점을 별로 표시하는 함수.
  Handlebars.registerHelper("displayStar", function(rating) {
    
	  let starStr = "";
	  switch(rating) {
	  	case 1:
		  	starStr = "★";
		  	break;
	  	case 2:
		  	starStr = "★★";
		  	break;
	  	case 3:
		  	starStr = "★★★";
		  	break;
	  	case 4:
		  	starStr = "★★★★";
		  	break;
	  	case 5:
		  	starStr = "★★★★★";
		  	break;
	  }
	  
	  return starStr;
  })
  
  Handlebars.registerHelper("authority", function(mb_id, rew_num) {
	  let str = "";
    let login_id = '${sessionScope.loginStatus.mb_id}';
    if(mb_id == login_id) {
      str += "<button type='button' class='btn btn-dark mr5' name='btn_re_edit' data-rew_num='" + rew_num + "' data-bs-toggle='modal' data-bs-target='#reviewModifyModal'>수정</button>";
      str += "<button type='button' class='btn btn-danger' name='btn_re_delete' data-rew_num='" + rew_num + "'>삭제</button>";
    }

    return new Handlebars.SafeString(str);
  })
</script>

<!-- 댓글 폼 및 ajax -->

<script>

  // jQuery 이벤트 설정
  $(document).ready(function() {

    //댓글페이지 번호 클릭
    // 동적으로 추가된 태그로 인하여 click이벤트 설정안됨.
    /*
    $("#replyPaging li a").on("click", function(e) {
        e.preventDefault(); // 링크기능 취소.
        console.log("댓글 페이지번호 클릭");
    });
    */
   // 동적으로 추가된 태그를 click 이벤트 설정시 하는 작업
    $("#replyPaging").on("click", "li a", function(e) {
        e.preventDefault(); // 링크기능 취소.
        //console.log("댓글 페이지번호 클릭");
        // 선택한 댓글 페이지번호.
        reviewPage = $(this).attr("href");
        url = "/review/list/" + pro_num + "/" + reviewPage + ".json";
        getPage(url); // 스프링에서 댓글번호에 해당하는 댓글데이타 가져오기.
    });

    // 평점 별 클릭
    $("p#star_rv_score a.rv_score").on("click", function(e){
      e.preventDefault();
      $(this).parent().children().removeClass("on");
      $(this).addClass("on").prevAll("a").addClass("on"); 
    });


    //댓글쓰기
    $("#btn_review_write").on("click", function() {
      let rew_title = $("#rew_title").val(); // 상품후기제목
      let rew_content = $("#rew_content").val(); // 상품후기내용
      let rv_score = 0;

      // 별평점 체크
      $("p#star_rv_score a.rv_score").each(function(index, item) {
        if($(this).attr("class") == "rv_score on") {
          rv_score += 1;
        }
      });

      if(rv_score == 0) {
        alert("별 평점을 선택하세요.");
        return;
      }

      if(rew_content == "") {
        alert("상품후기를 입력하세요");
        return;
      }


      console.log("별평점: " + rv_score);
      console.log("댓글 제목" + rew_title);
      console.log("댓글 내용" + rew_content);

      // {"pro_num": 275, "replyer": "홍길동", "reply":"댓글내용"}
      let reviewData = JSON.stringify({pro_num: '${productVO.pro_num}', rew_score : rv_score, rew_title: rew_title, rew_content: rew_content});

      //console.log(replyData);

      $.ajax({
        type: 'post',
        url: '/review/new',  // 매핑주소의 컨트롤러 클래스가 @RestController 이므로, 전송데이타를 JSON 형식으로 사용함.
        headers: {
          "Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
        },
        dataType: 'text', // 스프링 메서드의 리턴타입
        data: reviewData, // 서버로 보내는 JSON데이타.
        success: function(result) {
          if(result == "success") {
            alert("상품후기 등록됨");
            $("#rew_content").val("");
            $("p#star_rv_score a.rv_score").removeClass("on");

            reviewPage = 1;
            url = "/review/list/" + pro_num + "/" + reviewPage + ".json";

            getPage(url);
          }
        }
      });
    }); // 댓글쓰기

    



    // 댓글수정
    $("div#replyList").on("click", "button[name='btn_re_edit']",function() {

      let cur_tr = $(this).parent().parent(); // 선택한 edit버튼의 현재 tr
      let next_tr = $(this).parent().parent().next().children();
      let rew_rn = cur_tr.children().eq(0).text();
      let rew_num = $(this).data("rew_num");      
      let rew_score = cur_tr.children().eq(1).find("input[name='rew_score']").val();
      let rew_title = cur_tr.children().eq(2).text();
      let rew_content = next_tr.find("div").text();
      let rew_regdate =  cur_tr.children(4).eq().text();

      console.log("rn: " + rew_rn + "\n댓글번호: " + rew_num + "\n별 평점: " + rew_score + "\n타이틀: " + rew_title + "\n내용: " + rew_content);

      let displayStar = "";
      for(let i=0; i<5; i++) {
        
        if(i < rew_score) {
          displayStar += "<a href='javascript:void(0);' class='rv_score on'>";
          displayStar += "★";
        }else {
          displayStar += "<a href='javascript:void(0);' class='rv_score'>";
          displayStar += "★";
        }

        displayStar += "</a>";

      }

      let modifyModal = $("#reviewModifyModal");      

      let contentStr = "<form>";
      contentStr += "<div class='mb-3'><label for='edit_rew_title' class='col-form-label'>제목</label><input type='text' class='form-control' id='edit_rew_title' value='"+ rew_title +"'/><input type='hidden' id='edit_rew_num' value='" + rew_num + "'/></div>";
      contentStr += "<div class='mb-3'><label for='edit_star_rv_score' class='col-form-label'>평점</label><div><p id='edit_star_rv_score' class='d-flex mr10'>" + displayStar + "</p></div></div>";
      contentStr += "<textarea class='form-control' id='edit_rew_content' wrap='hard' rows='5'>" + rew_content + "</textarea>";
      contentStr += "</form>";

      let btn_str = "<button type='button' id='btn_re_cancel' class='btn' data-bs-dismiss='modal'>취소</button>";
      btn_str += "<button type='button' id='btn_re_register' class='btn btn-dark'>수정</button>";

      modifyModal.find(".modal-body").empty();
      modifyModal.find(".modal-footer").empty();
      modifyModal.find(".modal-body").append(contentStr);
      modifyModal.find(".modal-footer").append( btn_str);
      

    }); // 댓글수정폼

    // 평점 별 클릭 - 동적으로 생성된 태그에 이벤트 설정
    $("div#reviewModifyModal").on("click", "#edit_star_rv_score a.rv_score", function(e){
      e.preventDefault();
      $(this).parent().children().removeClass("on");
      $(this).addClass("on").prevAll("a").addClass("on");        
    });
    
    //상품후기 수정하기
    $("div#reviewModifyModal").on("click", "#btn_re_register", function() {
      let edit_rew_num = $("#edit_rew_num").val();
      let edit_rew_title = $("#edit_rew_title").val();
      let edit_rew_content = $("#edit_rew_content").val();
      
      let rv_score = 0;

      // 별평점 수정 읽어오기
      // 별평점 체크
      $("#edit_star_rv_score a.rv_score").each(function(index, item) {
        if($(this).attr("class") == "rv_score on") {
          rv_score += 1;
        }


      });

      console.log("별 평점: " + rv_score);

      let reviewData = JSON.stringify({rew_num: edit_rew_num, rew_title: edit_rew_title, rew_content: edit_rew_content, rew_score : rv_score});

      console.log("JSON데이타: " + reviewData);
      

      $.ajax({
        type: 'patch',
        url: '/review/modify/',
        headers: {
          "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PATCH"
        },
        data: 'text',
        data: reviewData,
        success: function(result) {
          if(result == "success") {
            alert("상품후기 수정됨");

            url = "/review/list/" + pro_num + "/" + reviewPage + ".json";

            getPage(url);
            $("#reviewModifyModal").modal('hide');
          }
        }
      });
    }); // 댓글수정하기

    // 댓글 삭제하기
    $("div#replyList").on("click", "button[name='btn_re_delete']",function() {
      console.log("상품후기삭제");

      if(!confirm("상품후기 삭제를 하시겠습니까?")) return;

      $.ajax({
        type: 'delete',
        url: '/review/delete/' + $(this).data("rew_num"),
        headers: {
          "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
        },
        data: 'text',
        success: function(result) {
          if(result == "success") {
            alert("상품후기삭제 성공");

            url = "/review/list/" + pro_num + "/" + reviewPage + ".json";

            getPage(url);
          }
        }
      });
    }); // 댓글삭제하기


  }); // Jquery ready


  //댓글목록과 페이징작업.  ajax관련 내용.  https://www.w3schools.com/jquery/jquery_ref_ajax.asp

  let pro_num = '${productVO.pro_num}'; // 상품코드
  let reviewPage = 1;
  let url = "/review/list/" + pro_num + "/" + reviewPage + ".json";

  getPage(url);

  function getPage(url) {
    $.getJSON(url, function(data) {

      // data.list,   data.pageMaker
      
      //상품후기목록 출력하는 함수
      printReplyData(data.list, $("#replyList"), $("#replyViewTemplate"));
      // 페이징기능 출력하는 함수
      printReplyPaging(data.pageMaker, $("#replyPaging")); 
    });
  }

    // 댓글목록 출력기능.  replyArr : 댓글목록데이타(json), target : 댓글삽입위치, template: 핸들바 문법이 삽입된 댓글디자인
    function printReplyData(replyArr, target, template){
      let templateObj = Handlebars.compile(template.html());
      let replyHtml = templateObj(replyArr); // 테이블과 댓글데이타가 바인딩된 결과
      target.empty();
      target.append(replyHtml);


      //console.log(replyHtml);
    }
    // 페이징 출력기능
    function printReplyPaging(pageMaker, target) {
      
      let pageInfoStr = '<nav aria-label="Page navigation example">';
         pageInfoStr += '<ul>';
      
      if(pageMaker.prev) {
        pageInfoStr += '<li class="page-item">';
        pageInfoStr += '<a class="page-link" href="' + (pageMaker.startPage - 1 ) + '" aria-label="Previous">';
        pageInfoStr += '<span aria-hidden="true">&laquo;</span>';
        pageInfoStr += '</a>';  
        pageInfoStr += '</li>';  
      }

      for(let i=pageMaker.startPage; i<= pageMaker.endPage; i++) {
        let currPageClass = (pageMaker.cri.pageNum == i) ? 'active' : '';
        pageInfoStr += '<li class="page-item ' + currPageClass + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
      }

      if(pageMaker.next) {
        pageInfoStr += '<li class="page-item">';
        pageInfoStr += '<a class="page-link" href="' + (pageMaker.endPage + 1) + '" aria-label="Next">';
        pageInfoStr += '<span aria-hidden="true">&raquo;</span>';
        pageInfoStr += '</a>';
        pageInfoStr += '</li>';
      }
      //console.log(pageInfoStr);
      target.html(pageInfoStr);
    }


</script>



  <script>

    $(document).ready(function() {
    
    /*
      let pro_size = $(".size-wrap").find("a");
      let select_size = null;
      
      pro_size.on("click", function(e){
      	
      if($(this).hasClass("not-allowed") == true){
      	e.preventDefault();
      	console.log($(this).html());
      
      }else{
      	console.log("클래스 O");
          pro_size.removeClass("selected");
          $(this).addClass("selected");
          select_size = $(".size-wrap").find("a.selected").attr("value");
          console.log("선택 사이즈는 " + select_size);
      }
          
      });
    */
    
      
	    	
      // 장바구니 클릭
      $("button[name=btn_cart]").on("click", function() {
		
    	console.log("장바구니");


        $.ajax({
          url: '/cart/cart_add',
          type: 'post',
          data: {pro_num : $(this).data("pro_num"), cart_amount : 1 },
          success: function(result) {
            if(result == "success") {
              alert("장바구니에 추가됨");
              if(confirm("장바구니로 이동하겠습니까?")) {
                location.href = "/cart/cart_list";
              }
            }
          }
        });
      });


      // 주문하기 클릭
      $("button[name=btn_direct_order]").on("click", function() {
		
      console.log("주문하기");


        $.ajax({
          url: '/cart/cart_add',
          type: 'post',
          data: {pro_num : $(this).data("pro_num"), cart_amount : 1, pro_size : select_size },
          success: function(result) {
            if(result == "success") {
              if(confirm("주문하시겠습니까?")) {
                location.href = "/cart/cart_list";
              }
            }
          }
        });
      });

    });



  </script>
  
  <!-- 상품 설명 스크롤-->
  <script>
    $(function() {

    let w = $(window),
      footerHei = $('#footer').outerHeight() + 200;
      btn = $('.detail-info');

      w.on('scroll', function() {

        var sT = w.scrollTop();
        var val = $(document).height() - w.height() - footerHei;

        if (sT >= val)
          btn.addClass('on');
        else
          btn.removeClass('on');
      });

    });
  </script>
  
    
  </body>
</html>