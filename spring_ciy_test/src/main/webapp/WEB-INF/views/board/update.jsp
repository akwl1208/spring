<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://kit.fontawesome.com/38e579569f.js" crossorigin="anonymous"></script>
<style type="text/css">
	.delete{
		font-size : 24px; line-height: 24px;
	}
	.delete:hover{
		color: red;
	}
</style>
</head>
<body>
	<c:if test="${board.bd_del == 'N'}">
		<div class=container>
			<form method="post" class="mt-5" enctype="multipart/form-data">
				<h1>게시글 수정</h1>
				<div class="form-group">
				  <input type="text" class="form-control" name="bd_title" placeholder="제목" value="${board.bd_title}">
				</div>
				<div class="form-group">
				  <textarea class="form-control" rows="10" name="bd_content" placeholder="내용">${board.bd_content}</textarea>
				</div>
				<div class="form-group">
					<label>첨부파일</label>
					<c:forEach items="${fileList}" var="fi">
						<a href="javascript:0;" class="form-control">${fi.fi_ori_name}<i data-target="${fi.fi_num}" class="fa-solid fa-square-xmark delete float-right"></i></a>
					</c:forEach>
					<c:forEach begin="1" end="${3-fileList.size()}">
						<input type="file" class="form-control" name="files">
					</c:forEach>
				</div>
				<button class="btn btn-outline-primary col-12 mb-5">게시글 수정</button>
			</form>
		</div>
	</c:if>
	<c:if test="${board.bd_del == 'Y'}">
		<h1 class="container mt-5">작성자에 의해 삭제된 게시글입니다</h1>
	</c:if>
	<c:if test="${board.bd_del == 'A'}">
		<h1 class="container mt-5">관리자에 의해 삭제된 게시글입니다</h1>
	</c:if>
	<script type="text/javascript">
	$(function(){
		$('.delete').click(function(){
			let fi_num = $(this).data('target');
			let str = '<input type="file" class="form-control" name="files">';
			let delStr = '<input type="hidden" name="nums" value="'+fi_num+'">';
			$(this).parents('.form-group').append(str);
			$(this).parents('.form-group').append(delStr);
			$(this).parent().remove();
		})
	})
	</script>
</body>
</html>