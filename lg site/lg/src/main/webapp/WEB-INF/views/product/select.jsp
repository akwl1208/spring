<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<style type="text/css">
[name="file"]{
	display: none;
}
.box-thumb{
	width: 150px; height: 150px; border: 1px solid red;
	text-align: center; font-size: 50px; line-height: 148px;
	cursor: pointer; box-sizing: border-box;
}
#preview{
	display: none;
}
</style>
</head>
<!-- body ---------------------------------------------------------------- -->
<body>
<div class="container">
	<h2>제품 상세</h2>
	<div class="clearfix">
	<!-- 제품 이미지 입력 ---------------------------------------------------------------- -->	
		<div class="float-left" style="width:auto; height:auto;">
			<img id="preview" width="150px" height="150px" src="<c:url value="${p.pr_thumb_url}"></c:url>">
		</div>
	<!-- 제품 정보 입력 ---------------------------------------------------------------- -->
		<div class="float-right" style="width:calc(100% - 150px - 10px)">
			<div class="form-group">
			  <input type="text" class="form-control" value="제품종류: ${p.pr_ca_name}" readonly>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" value="제품코드: ${p.pr_code}" readonly>		
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" value="제품가격: ${p.pr_price}" readonly>
			</div>
		</div>
	</div>
	<!-- 제품 설명 입력 ---------------------------------------------------------------- -->
	<div class="form-group">
		<input type="text" class="form-control" value="${p.pr_title}">
	</div>
	<div class="form-group">
		<div class="form-control" style="height:auto">${p.pr_content}</div>
	</div>
	<div class="form-group">
		<label>제품스펙</label>
		<div class="form-control" style="height:auto">${p.pr_spec}</div>
	</div>
</div>
</body>
</html>