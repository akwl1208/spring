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
	cursor: pointer; box-sizing: border-box; display:none;
}
</style>
</head>
<!-- body ---------------------------------------------------------------- -->
<body>
<form class="container" enctype="multipart/form-data" method="post" action="<c:url value="/admin/product/update"></c:url>">
	<h2>제품 등록</h2>
	<div class="clearfix">
	<!-- 제품 이미지 입력 ---------------------------------------------------------------- -->	
		<div class="float-left" style="width:auto; height:auto;">
			<div class="box-thumb">+</div>
			<input type="file" name="file">
			<img id="preview" width="150px" height="150px" src="<c:url value="${pr.pr_thumb_url}"></c:url>">
		</div>
	<!-- 제품 정보 입력 ---------------------------------------------------------------- -->
		<div class="float-right" style="width:calc(100% - 150px - 10px)">
			<div class="form-group">
			  <input class="form-control" name="pr_ca_name" type="text" readonly value="${pr.pr_ca_name}">
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" readonly name="pr_code" readonly value="${pr.pr_code}">
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" name="pr_price" placeholder="제품 가격(정수)" value="${pr.pr_price}">
			</div>
		</div>
	</div>
	<!-- 제품 설명 입력 ---------------------------------------------------------------- -->
	<div class="form-group">
	  <input type="text" class="form-control" name="pr_title" placeholder="제품 제목" value="${pr.pr_title}">
	</div>
	<div class="form-group">
	  <textarea class="form-control" name="pr_content" placeholder="제품 설명">${pr.pr_content}</textarea>
	</div>
	<div class="form-group">
	  <textarea class="form-control" name="pr_spec" placeholder="제품 스펙">${pr.pr_spec}</textarea>
	</div>
	<button class="btn btn-outline-success col-12">제품 수정</button>
</form>
<!-- 스크립트 ---------------------------------------------------------------- -->
<script type="text/javascript">
$(function(){
<!-- 이벤트 ---------------------------------------------------------------- -->
	<!-- 썸네일 ---------------------------------------------------------------- -->
	$('.box-thumb, #preview').click(function(){
		$('[name=file]').click();
	})

	$('[name=file]').on('change', function(event) {
		if(event.target.files.length == 0){
			$('.box-thumb').show();
			$('#preview').hide();
			return;
		} else{
			$('.box-thumb').hide();
			$('#preview').show();			
		}
	  var file = event.target.files[0];
	  var reader = new FileReader(); 
	  
	  reader.onload = function(e) {
	      $('#preview').attr('src', e.target.result);
	  }
	  reader.readAsDataURL(file);
	});
	<!-- 썸머노트 ---------------------------------------------------------------- -->
	$('[name=pr_content]').summernote({
	  placeholder: '제품 설명을 입력하세요.',
	  tabsize: 2,
	  height: 400
	});
	
	$('[name=pr_spec]').summernote({
	  placeholder: '제품 설명을 입력하세요.',
	  tabsize: 2,
	  height: 400
	});
	<!-- 제품번호 입력 ---------------------------------------------------------------- -->
	$('[name=pr_ca_name]').change(function(){
		$('[name=pr_code]').val($(this).val());
	})
	<!-- 예외 처리 ---------------------------------------------------------------- -->
	$('form').submit(function(){
		let pr_ca_name= $('[name=pr_ca_name]').val();
		if(pr_ca_name == '0'){
			alert('제품 종류를 선택하세요.');
			$('[name=pr_ca_name]').focus();
			return false;
		}

		let pr_price = $('[name=pr_price]').val();
		if(pr_price == '' || !/\d+/.test(pr_price)){
			alert('올바른 가격을 입력하세요.');
			$('[name=pr_price]').focus();
			return false;
		}
		
		let pr_title= $('[name=pr_title]').val();
		if(pr_title == ''){
			alert('제품 제목을 입력하세요.');
			$('[name=pr_title]').focus();
			return false;
		}

		let pr_content= $('[name=pr_content]').val();
		if(pr_content == ''){
			alert('제품 내용을 입력하세요.');
			$('[name=pr_content]').focus();
			return false;
		}
		
		let pr_spec= $('[name=pr_spec]').val();
		if(pr_spec == ''){
			alert('제품 스펙을 입력하세요.');
			$('[name=pr_spec]').focus();
			return false;
		}
	})
})
</script>

</body>
</html>