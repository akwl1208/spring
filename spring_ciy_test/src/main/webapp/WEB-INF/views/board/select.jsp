<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<script src="https://kit.fontawesome.com/38e579569f.js" crossorigin="anonymous"></script>
<style>
	.btn-up, .btn-down{
		border : 1px solid black; color : red;
	}
	.btn-up.red, .btn-down.red{
		background : red; color : white;
	}
</style>
</head>
<body>
	<div class="container mt-5 mb-5">
		<c:if test="${board.bd_del == 'N'}">
			<h1>게시글 상세</h1>
			<div class="form-group">
			  <input type="text" class="form-control" name="bd_title" value="${board.bd_title}" readonly>
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" name="bd_me_id" value="${board.bd_me_id}" readonly>
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" name="bd_reg_date" value="${board.bd_reg_date_time_str}" readonly>
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" name="bd_up_date" value="${board.bd_up_date_time_str}" readonly>
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" name="bd_views" value="${board.bd_views}" readonly>
			</div>
			<div class="from-group mb-3">
				<button class="btn btn-up <c:if test="${likes.li_state == 1}">red</c:if>" data-value="1"><i class="fa-solid fa-thumbs-up"></i></button>
				<button class="btn btn-down <c:if test="${likes.li_state == -1}">red</c:if>" data-value="-1"><i class="fa-solid fa-thumbs-down"></i></button>
			</div>
			<div class="form-group">
			  <textarea class="form-control" rows="10" name="bd_content" readonly>${board.bd_content}</textarea>
			</div>
			<c:if test="${user != null && user.me_id == board.bd_me_id}">
				<a href="<c:url value="/board/update/${board.bd_num}"></c:url>" class="btn btn-outline-info">수정</a>
				<a href="<c:url value="/board/delete/${board.bd_num}"></c:url>" class="btn btn-outline-danger">삭제</a>
			</c:if>	
		</c:if>
		<c:if test="${board.bd_del == 'Y'}">
			<h1>작성자에 의해 삭제된 게시글입니다</h1>
		</c:if>
		<c:if test="${board.bd_del == 'A'}">
			<h1>관리자에 의해 삭제된 게시글입니다</h1>
		</c:if>
	</div>
		<script>
		$(function(){
			$('.btn-up, .btn-down').click(function(){
				let id = '${user.me_id}';
				if(id ==''){
					if(confirm('로그인이 필요한 기능입니다. 로그인 화면으로 이동하겠습니까?')){
						location.href = '<%=request.getContextPath()%>/login';
						return;
					}
				}
				
				let li_state = $(this).data('value');
				let li_bd_num = '${board.bd_num}';
				let obj = {
						li_bd_num : li_bd_num,
						li_state : li_state,
				}
				$.ajax({
	        async:false,
	        type:'POST',
	        data: JSON.stringify(obj),
	        url: '<%=request.getContextPath()%>/check/likes',
	        contentType:"application/json; charset=UTF-8",
	        success : function(data){
	        	$('.btn-up, .btn-down').removeClass('red');
	        	if(data.state == '1'){
	        		$('.btn-up').addClass('red')
	        		alert('해당 게시글을 추천했습니다');
	        	}else if(data.state == '-1'){
	        		$('.btn-down').addClass('red')
	        		alert('해당 게시글을 비추천했습니다');
	        	}else if(data.state == '10'){
	        		alert('해당 게시글의 추천을 취소했습니다');
	        	}else if(data.state == '-10'){
	        		alert('해당 게시글의 비추천을 취소했습니다');
	        	}else{
	        		alert('잘못된 접근입니다')
	        	}
	        }
				});
			})
		})
	</script>
</body>
</html>