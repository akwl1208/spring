<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<script src="https://kit.fontawesome.com/38e579569f.js" crossorigin="anonymous"></script>
<style type="text/css">
.home{
	background-image : url(<%=request.getContextPath()%>/resources/img/logo.svg);
	background-size: 100% 100%; width: 100px; height:29px; display: block; 
}
.member .dropdown-toggle::after{
	display: none;
}
.member .dropdown-toggle .fa-user{
	line-height: 1.5em;
}
</style>
</head>

<body>
</body>
<nav class="navbar navbar-expand-md bg-dark navbar-dark">
	<div class="container" style="position:relative;">
	 	<a class="navbar-brand home" href="<c:url value="/"></c:url>"></a>
	 	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
	   	<span class="navbar-toggler-icon"></span>
	 	</button>
	 	<div class="collapse navbar-collapse" id="collapsibleNavbar">
    	<ul class="navbar-nav category">
    		<!-- 회원 메뉴 ------------------------------------------------------------------------ -->
	      <li class="nav-item dropdown member" style="position:absolute; right: 0;">
					<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa-regular fa-user"></i></a>
					<div class="dropdown-menu">
						<c:if test="${user == null}">
							<a class="dropdown-item" href="<c:url value="/signup"></c:url>">회원가입</a>
							<a class="dropdown-item" href="<c:url value="/login"></c:url>">로그인</a>
						</c:if>
						<c:if test="${user != null}">
							<a class="dropdown-item" href="<c:url value="/mypage"></c:url>">회원정보 수정</a>
							<a class="dropdown-item" href="<c:url value="/logout"></c:url>">로그아웃</a>
						</c:if>
					</div>
				</li>
				<!-- 관리자 메뉴 ------------------------------------------------------------------------ -->
				<c:if test="${user != null && user.me_authority == 10}">
					<li class="nav-item">
	       		<a class="nav-link" href="<c:url value="/admin"></c:url>">관리자</a>
	     		</li>
				</c:if>
	     	<li class="nav-item">
	       	<a class="nav-link" href="#">Link</a>
	     	</li>
    	</ul>
		</div> 
	</div> 
</nav>
<!-- 스크립트 ------------------------------------------------------------------------ -->
<script>
$(function(){
	<!-- 카테고리 메뉴 ------------------------------------------------------------------------ -->
	ajaxPost(false, null, '/category/list', function(data){
		if('$(user.me_authority)' == 10){
			return;
		}
		let str = '';
		for(c of data.list){
	   	str += '<li class="nav-item">';
	    str += 	'<a class="nav-link" href="<%=request.getContextPath()%>/product/list?ca_name='+c.ca_name+'">'+c.ca_name+'</a>';
	   	str += '</li>';
		}
		$('.category').prepend(str);
	})
})
//ajaxPost
function ajaxPost(async, dataObj, url, success){
	$.ajax({
		async: async,
		type:'POST',
		data: JSON.stringify(dataObj),
		url: "<%=request.getContextPath()%>" + url,
	  contentType:"application/json; charset=UTF-8",
	  success : function(data){
			success(data)
	  }
	});
}//
</script>