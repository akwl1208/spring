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
	<div class="container mt-5" >
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
			        	<a href="<c:url value="/board/select/${board.bd_num}"></c:url>">${board.bd_title}</a>
			        </td>
			        <td>${board.bd_me_id}</td>
			        <td>${board.bd_reg_date_str}</td>
			        <td>${board.bd_views}</td>
			        <td>${board.bd_up}/${board.bd_down}</td>
			      </tr>
		      </c:forEach>
		    </tbody>
		</table>
	  <ul class="pagination justify-content-center">
	  	<c:if test="${pm.prev}">
	  		 <li class="page-item"><a class="page-link" href="<c:url value="/board/list?page=${pm.startPage-1}"></c:url>">이전</a></li>
	  	</c:if>
	   	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
		  	<li class="page-item <c:if test="${i == pm.cri.page}">active</c:if>">
		  		<a class="page-link" href="<c:url value="/board/list?page=${i}"></c:url>">${i}</a>
		  	</li>
		  </c:forEach>
   	  <c:if test="${pm.next}">
		  	<li class="page-item"><a class="page-link" href="<c:url value="/board/list?page=${pm.endPage+1}"></c:url>">다음</a></li>
		  </c:if>
	  </ul>
		<c:if test="${user != null}">
			<a href="<c:url value="/board/insert"></c:url>" class="btn btn-outline-primary mb-5">글쓰기</a> 
		</c:if>
	</div>
</body>
</html>