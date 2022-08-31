<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://kit.fontawesome.com/38e579569f.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
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
				  <textarea class="form-control" rows="10" name="bd_content" id="summernote" >${board.bd_content}</textarea>
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
		
    $('#summernote').summernote({
     placeholder: 'Hello Bootstrap 4',
     tabsize: 2,
     height: 500,
     callbacks: {
   	   onImageUpload: function(files) {	
   	  	if(files == null || files.length ==0)
   	  		return;
   			for(file of files){
	   	  	let data = new FormData();
  	    	data.append('file',files[0]);
  	    	let thisObj = $(this);
  	    	$.ajax({
  	    		data : data,
  	    		type : 'post',
  	    		url : '<%=request.getContextPath()%>/board/img/upload',
  	    		contentType : false,
  	    		processData : false,
  	    		dataType : "json",
  	    		success : function(data){
  	    			let url = '<%=request.getContextPath()%>/simg' + data.url;
  	    			thisObj.summernote('insertImage', url);
  	    		}
  	    	});
   			}
   	   }
   	 }
   });
	})
	</script>
</body>
</html>