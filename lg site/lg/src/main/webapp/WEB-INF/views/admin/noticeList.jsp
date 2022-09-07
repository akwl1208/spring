<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.btn-del{
	padding: 0; border: none; background-color: transparent; color:#ffc107;
}
form.btn:hover .btn-del{
	color: #fff
}
from.btn{
	margin-bottom: 0;
}
</style>
</head>
<body>
<div class="container">
  <h2>공지사항</h2>
  <!-- 공지사항 등록 ------------------------------------------------------------------------------------------- -->
  <a href="<c:url value="/admin/notice/insert"></c:url>" class="btn btn-outline-success mb-3">공지사항 등록</a>
  <!-- 공지사항 리스트 ------------------------------------------------------------------------------------------- -->
  <table class="table table-hover">
    <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성일</th>
        <th>기능</th>
      </tr>
    </thead>
    <tbody>
    	<c:forEach items = "${list}" var="pro" >
	    	<tr>
	        <td>${num}</td>
	        <td>
	        	<a href="<c:url value="/product/select?pr_code=${pro.pr_code}"></c:url>">${title}</a>	
       		</td>
	        <td>${reg_date}</td>
	        <td>
	        	<a class="btn btn-outline-success" href="<c:url value="/admin/product/update?pr_code=${pro.pr_code}"></c:url>">수정</a>
	        	<form class="btn btn-outline-warning" action="<c:url value="admin/product/delete"></c:url>" method="post">
	        		<button class="btn-del">삭제</button>
	        		<input type="hidden" name="pr_code" value="${pro.pr_code}">
	        	</form>
	        </td>
	      </tr>
    	</c:forEach>
    </tbody>
  </table>
  <!-- 페이지네이션 ------------------------------------------------------------------------------------------- -->
  <ul class="pagination justify-content-center">
  	<li class="page-item <c:if test="${!pm.prev}">disabled</c:if>">
  		<a class="page-link" href="<c:url value="/admin/product/list?page=1&search=${pm.cri.search}&pr_ca_name=${pm.cri.pr_ca_name}"></c:url>">처음</a>
 		</li>
 	  <li class="page-item <c:if test="${!pm.prev}">disabled</c:if>">
 	  	<a class="page-link" href="<c:url value="/admin/product/list?page=${pm.startPage-1}&search=${pm.cri.search}&pr_ca_name=${pm.cri.pr_ca_name}"></c:url>">이전</a>
	  </li>  	
  	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
	  	<li class="page-item <c:if test="${pm.cri.page == i}">active</c:if>">
  			<a class="page-link" href="<c:url value="/admin/product/list?page=${i}&search=${pm.cri.search}&pr_ca_name=${pm.cri.pr_ca_name}"></c:url>">${i}</a>
 		</li>
  	</c:forEach>
 	  <li class="page-item <c:if test="${!pm.next}">disabled</c:if>">
 	  	<a class="page-link" href="<c:url value="/admin/product/list?page=${pm.endPage+1}&search=${pm.cri.search}&pr_ca_name=${pm.cri.pr_ca_name}"></c:url>">다음</a>
	  </li>
   	<li class="page-item" <c:if test="${!pm.next}">disabled</c:if>>
   		<a class="page-link" href="<c:url value="/admin/product/list?page=${pm.finalPage}&search=${pm.cri.search}&pr_ca_name=${pm.cri.pr_ca_name}"></c:url>">마지막</a>
  	</li>
  </ul>
  <!-- 검색 ------------------------------------------------------------------------------------------- -->
  <form>
  	<div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="제목으로 검색하세요" name="search" value="${pm.cri.search}">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="submit">검색</button>
		  </div>
		</div>
  </form>
</div>
</body>
</html>