<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
  <h2>카테고리 목록</h2>
  <form method="post">
		<div class="input-group mb-3">
		  <input type="text" class="form-control" name="ca_name" placeholder="카테고리명">
		  <input type="text" class="form-control" name="ca_code" placeholder="카테고리코드">
		  <div class="input-group-append">
		  	<button class="btn btn-outline-success">등록</button>
		  </div>
		</div>
  </form>
  <table class="table table-hover">
    <thead>
      <tr>
        <th>카테고리명</th>
        <th>카테고리코드</th>
      </tr>
    </thead>
    <tbody>
    	<c:forEach items="${list}" var="ca">
    		<tr>
        	<td>${ca.ca_name}</td>
        	<td>${ca.ca_code}</td>
      	</tr>
    	</c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>