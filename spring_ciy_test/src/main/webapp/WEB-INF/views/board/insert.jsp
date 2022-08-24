<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
	<form method="post" class="container mt-5" enctype="multipart/form-data">
		<h1>게시글 등록</h1>
		<div class="form-group">
		  <input type="text" class="form-control" name="bd_title" placeholder="제목">
		</div>
		<div class="form-group">
		  <textarea class="form-control" rows="10" name="bd_content" placeholder="내용"></textarea>
		</div>
		<div class="form-group">
       <label>첨부파일파일</label>
       <input type="file" class="form-control" name="files">
       <input type="file" class="form-control" name="files">
       <input type="file" class="form-control" name="files">
    </div>
		<button class="btn btn-outline-primary col-12 mb-5">게시글 등록</button>
	</form>
</body>
</html>