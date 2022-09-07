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
</head>
<!-- body ---------------------------------------------------------------- -->
<body>
<form class="container" enctype="multipart/form-data" method="post">
	<h2>QNA 등록</h2>
	<div class="form-group">
		 <input type="text" class="form-control" name="bd_title" placeholder="제목">
	</div>
	<div class="form-group">
		 <textarea class="form-control" name="bd_content" placeholder="내용"></textarea>
	</div>
	<!-- 비밀글 ---------------------------------------------------------------- -->
	<div class="form-check">
	  <label class="form-check-label">
	    <input type="checkbox" class="form-check-input" value="1" name="bd_secret">비밀글
	  </label>
	</div>
	<!-- 첨부파일 ---------------------------------------------------------------- -->
	<div class="form-group">
		<input type="file" class="form-control" name="files">
		<input type="file" class="form-control" name="files">
		<input type="file" class="form-control" name="files">
	</div>
	<button class="btn btn-outline-success col-12">QNA 등록</button>
</form>
<!-- 스크립트 ---------------------------------------------------------------- -->
<script type="text/javascript">
$(function(){
<!-- 이벤트 ---------------------------------------------------------------- -->
	<!-- 썸머노트 ---------------------------------------------------------------- -->
	$('[name=bd_content]').summernote({
	  placeholder: 'QNA 내용을 입력하세요.',
	  tabsize: 2,
	  height: 400
	});
	<!-- 예외 처리 ---------------------------------------------------------------- -->
	$('form').submit(function(){		
		let bd_title= $('[name=bd_title]').val();
		if(bd_title == ''){
			alert('제목을 입력하세요.');
			$('[name=bd_title]').focus();
			return false;
		}

		let bd_content= $('[name=bd_content]').val();
		if(bd_content == ''){
			alert('내용을 입력하세요.');
			$('[name=bd_content]').focus();
			return false;
		}
	})
})
</script>
</body>
</html>