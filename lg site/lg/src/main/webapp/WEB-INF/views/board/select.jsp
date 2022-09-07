<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- body ---------------------------------------------------------------- -->
<body>
<div class="container">
	<h2>게시글 상세</h2>
	<div class="form-group">
		<div class="form-control">${bo.bd_title}</div>
	</div>
	<div class="form-group">
		<div class="form-control" style="height:auto; min-height: 300px;">${bo.bd_content}</div>
	</div>
</div>
</body>
</html>