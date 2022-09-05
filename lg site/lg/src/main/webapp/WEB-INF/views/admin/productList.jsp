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
  <h2>제품 리스트</h2>
  <!-- 제품 등록 ------------------------------------------------------------------------------------------- -->
  <a href="<c:url value="/admin/product/insert"></c:url>" class="btn btn-outline-success mb-3">제품 등록</a>
  <!-- 제품 리스트 ------------------------------------------------------------------------------------------- -->
  <table class="table table-hover">
    <thead>
      <tr>
        <th>Firstname</th>
        <th>Lastname</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
      </tr>
    </tbody>
  </table>
  <!-- 페이지네이션 ------------------------------------------------------------------------------------------- -->
  <ul class="pagination justify-content-center">
  	<li class="page-item"><a class="page-link" href="javascript:void(0);">처음</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">이전</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">2</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">다음</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">마지막</a></li>
  </ul>
  <!-- 검색 ------------------------------------------------------------------------------------------- -->
  <form>
  	<div class="input-group mb-3">
  		<select class="form-control">
  			<option>카테고리</option>
  		</select>
		  <input type="text" class="form-control" placeholder="검색">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="submit">검색</button>
		  </div>
		</div>
  </form>
</div>
</body>
</html>