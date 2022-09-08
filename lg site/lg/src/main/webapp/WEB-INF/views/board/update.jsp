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
	<h2>QNA 수정</h2>
	<div class="form-group">
		 <input type="text" class="form-control" name="bd_title" placeholder="제목" value="${bo.bd_title}">
	</div>
	<div class="form-group">
		 <textarea class="form-control" name="bd_content" placeholder="내용">${bo.bd_content}</textarea>
	</div>
	<!-- 비밀글 ---------------------------------------------------------------- -->
	<div class="form-check">
	  <label class="form-check-label">
	    <input type="checkbox" class="form-check-input" value="1" name="bd_secret" <c:if test="${bo.bd_secret == '1'}">checked</c:if>>비밀글
	  </label>
	</div>
	<!-- 첨부파일 ---------------------------------------------------------------- -->
	<div class="form-group box-files">
		<c:forEach items="${fileList}" var="file">
			<a class="form-control" href="javascript:0;">
				<span>${file.fi_ori_name}</span>
				<span class="btn-close" data-target="${file.fi_num}">X</span>
			</a>
		</c:forEach>
		<c:forEach begin="1" end="${3-fileList.size()}">
			<input type="file" class="form-control" name="files">
		</c:forEach>
	</div>
	<button class="btn btn-outline-success col-12">QNA 수정</button>
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
	<!-- 첨부파일 닫기 버튼 클릭 ---------------------------------------------------------------- -->
	$(document).on('click', '.btn-close', function(){
		let fi_num =$(this).data('target');
		$(this).parent().remove();
		let str = '';
		str += '<input type="file" class="form-control" name="files">';
		str += '<input type="hidden" name="nums" value="'+fi_num+'">';
		$('.box-files').append(str);
	})
})
</script>
</body>
</html>