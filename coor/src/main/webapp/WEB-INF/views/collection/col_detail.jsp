<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>COOR - COLLECTION - ${collectionVO.col_name}</title>
    <%@ include file="/WEB-INF/views/include/common.jsp" %>
    <meta name="theme-color" content="#563d7c">
  </head>
  <body>
    
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
    <h4>${collectionVO.col_name}</h4>
  </div>

  <div class="collection container">
    <div class="pb50">
      <div>
        ${collectionVO.col_content}
      </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
  </div>
  </body>
</html>