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
    <style>
    #cke_contact_content {width: 100%;}
    </style>
</head>
<body>
  <div class="wrapper">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="contact container">
      <div class="container-inner-wrap">        
        <div class="pricing-header py-3 pt-md-5 pb-md-4 mx-auto text-left">
          <h4 class="display-4">문의하기</h4>
        </div>
        <div class="row">
          <form method="post" action="/help/contact">
            <div class="insert-form container" >
                <ul>
                    <!-- 문의 유형 -->
                    <li class="insert-list">
                      <div class="insert-lt">문의유형<span>*</span></div>
                      <div class="insert-rt" style="flex-direction: column; align-items: flex-start;">
                          <div class="form-check">
                            <input class="form-check-input" type="radio" name="contact_type" id="flexRadioDefault1" value="1" checked>
                            <label class="form-check-label" for="contact_type">
                              배송
                            </label>
                          </div>
                          <div class="form-check">
                            <input class="form-check-input" type="radio" name="contact_type" id="flexRadioDefault2" value="2">
                            <label class="form-check-label" for="contact_type">
                              주문/결제
                            </label>
                          </div>
                          
                          <div class="form-check">
                            <input class="form-check-input" type="radio" name="contact_type" id="flexRadioDefault3" value="3">
                            <label class="form-check-label" for="contact_type">
                              취소/환불
                            </label>
                          </div>
                          
                          <div class="form-check">
                            <input class="form-check-input" type="radio" name="contact_type" id="flexRadioDefault4" value="4">
                            <label class="form-check-label" for="contact_type">
                              서비스
                            </label>
                          </div>
                      </div>
                    </li>
                    <!-- 문의 유형 -->
                    <!-- 주문 내역 -->
                    <li class="insert-list">
                        <div class="insert-lt">주문번호<span>*</span></div>
                        <div class="insert-rt">
                           <div class="insert-category">
                                <div class="main-category">
                                	<table class="table table_borderd"  style="height:100px;">
                                		<thead>
                                			<tr>
                                				<td width="5%"></td>
                                				<td width="60%">상품정보</td>
                                				<td width="15%">주문번호</td>
                                				<td width="20%">주문일자</td>	
                                			</tr>
                                		</thead>
                                		<tbody>
                                    		<c:forEach items="${orderList}" var="orderVO">
                                    			<tr style="cursor: pointer;" data-ord_code="${orderVO.ord_code}" class="ordBtn">
                                    				<td></td>
                                    				<td class="text-start d-flex align-items-center"><img src="/help/displayImage?folderName=${orderVO.pro_up_folder }&fileName=s_${orderVO.pro_up_img}" class="mr15"><span>${orderVO.pro_name}</span></td>
                                    				<td>${orderVO.ord_code }</td>
                                    				<td><fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    			</tr>
                                    		</c:forEach>
                                		</tbody>
                                	</table>
                                </div>
                            </div>
                            <input type="hidden" name="ord_code" id="ord_code_val" value="">
                        </div>
                    </li>
                    <!-- 주문 내역 -->
                    <!-- 제목 -->
                    <li class="insert-list">
                        <div class="insert-lt">제목<span>*</span></div>
                        <div class="insert-rt">
                            <input type="text"  name="contact_title" id="contact_title" placeholder="제목을 입력해주세요.">
                        </div>
                    </li>
                    <li class="insert-list">
                        <div class="insert-lt">설명<span>*</span></div>
                        <div class="insert-rt">
                            <textarea name="contact_content" id="contact_content" cols="30" rows="6" placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)"></textarea>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="insert-footer">
                <div class="container">
                    <button  button type="submit" class="btn btn-dark" id="btnInsert">등록하기</button>
                </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
  </div>
</body>

<!-- REQUIRED JS SCRIPTS -->
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
      filebrowserUploadUrl : '/contact/imageUpload' // 업로드 탭 표시
    }

    CKEDITOR.replace("contact_content", ckeditor_config);

    console.log("버전: " + CKEDITOR.version);

  });
</script>

<script>
  

  $(document).on("click",".ordBtn", function(){
      if($(this).hasClass("selected") == false){

          let ord_code = $(this).data('ord_code');

          $(".ordBtn").removeClass("selected");
          $(this).addClass("selected"); 
          console.log(ord_code);
          
          $("#ord_code_val").val('');
          $("#ord_code_val").val(ord_code);
      }
      return false;
  });
</script>

</html>