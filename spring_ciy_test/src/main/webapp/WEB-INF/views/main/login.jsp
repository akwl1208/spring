<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
</head>
<body>
	<div class="container">
		<form class="mt-5" method="post">
			<h1>로그인</h1>
			<div class="form-group mt-3">
	 			<input type="text" class="form-control" name="me_id" placeholder="아이디">
			</div>
			<div class="form-group">
		 		<input type="password" class="form-control" name="me_pw" placeholder="비밀번호">
			</div>
			<button class="btn btn-outline-success mb-5 col-12">로그인</button>
		</form>
	</div>
</body>
</html>

