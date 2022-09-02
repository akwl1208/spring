<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="container">
		<form class="mt-3" method="post">
			<h1>로그인</h1>
			<div class="form-group">
	 			<input type="text" class="form-control" name="me_email" placeholder="이메일">
			</div>
			<div class="form-group">
		 		<input type="password" class="form-control" name="me_pw" placeholder="비밀번호">
			</div>
			<div class="form-check">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="true" name="autoLogin">자동로그인
			  </label>
			</div>
			<button class="btn btn-outline-success mb-3 col-12">로그인</button>
		</form>
		<a href="<c:url value="/find?type=id"></c:url>">아이디 찾기</a>/
		<a href="<c:url value="/find?type=pw"></c:url>">비번 찾기</a>
	</div>
</body>
</html>