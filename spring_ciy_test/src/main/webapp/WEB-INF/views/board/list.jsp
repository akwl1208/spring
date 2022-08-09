<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
</head>
<body>
	<div class=container>
		<h1>게시글</h1>
		<table class="table table-striped table-hover">
		    <thead>
		      <tr>
		        <th>번호</th>
		        <th>제목</th>
		        <th>작성자</th>
		        <th>작성일</th>
		        <th>조회수</th>
		        <th>추천</th>
		      </tr>
		    </thead>
		    <tbody>
		      <c:forEach items="${list}" var="board">
		      	  <tr>
			        <td>${board.bd_num}</td>
			        <td>
			        	<a href="#">${board.bd_title}</a>
			        </td>
			        <td>${board.bd_me_id}</td>
			        <td>${board.bd_reg_date_str}</td>
			        <td>${board.bd_views}</td>
			        <td>${board.bd_up}/${board.bd_down}</td>
			      </tr>
		      </c:forEach>
		    </tbody>
		</table> 
	</div>
</body>
</html>