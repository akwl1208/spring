<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<form method="post" class="container mt-5" enctype="multipart/form-data">
		<h1>게시글 등록</h1>
		<div class="form-group">
		  <input type="text" class="form-control" name="bd_title" placeholder="제목">
		</div>
		<div class="form-group">
		  <textarea class="form-control" rows="10" name="bd_content" id="summernote"></textarea>
		</div>
		<div class="form-group">
       <label>첨부파일파일</label>
       <input type="file" class="form-control" name="files">
       <input type="file" class="form-control" name="files">
       <input type="file" class="form-control" name="files">
    </div>
		<button class="btn btn-outline-primary col-12 mb-5">게시글 등록</button>
	</form>
		<script>
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
	  </script>
</body>
</html>