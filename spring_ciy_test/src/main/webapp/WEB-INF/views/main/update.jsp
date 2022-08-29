<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
 <style>
 	.error{
 		color: red;
 	}
 </style>
</head>
<body>
	<div class="container mt-5">
		<form action="<%=request.getContextPath()%>/member/update" method="post">
			<h1 class="text-center">회원정보 수정</h1>
			<div class="form-group">
			  <label for="me_id">아이디:</label>
			  <input type="text" class="form-control" name="me_id" id="me_id" value="${user.me_id}" readonly>
			</div>
			<div class="form-group">
			  <label for="me_pw">비밀번호:</label>
			  <input type="password" class="form-control" name="me_pw" id="me_pw">
			</div>
			<div class="form-group">
			  <label for="me_pw2">비밀번호 확인:</label>
			  <input type="password" class="form-control" name="me_pw2" id="me_pw2">
			</div>
			<div class="form-group">
				<label>성별:</label>
			</div>
			<div class="form-group">
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" name="me_gender" value="M" <c:if test="${user.me_gender == 'M'}">checked</c:if>>남성
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" name="me_gender" value="F" <c:if test="${user.me_gender == 'F'}">checked</c:if>>여성
				  </label>
				</div>
				<div>
					<label class="error" id="me_gender-error" for="me_gender"></label>
				</div>
			</div>
			<div class="form-group">
			  <label for="me_email">이메일:</label>
			  <input type="text" class="form-control" name="me_email" id="me_email" value="${user.me_email}">
			</div>
			<div class="form-group">
			  <label for="me_birth">생년월일:</label>
			  <input type="text" class="form-control" name="me_birth" id="me_birth" value="${user.me_birth_str}">
			</div>
			<button class="btn btn-outline-success col-12 mb-5">회원정보 수정</button>
		</form>
	</div>
	
	<script type="text/javascript">
		//datepicker
		$(function(){
			$("#me_birth").datepicker({
		      changeMonth: true,
		      changeYear: true,
		      dateFormat: 'yy-mm-dd',
		      yearRange : "1900:2022"
		    });
		})
		//유효성 검사
		$(function(){
	    $("form").submit(function(){
	    	let pw = $('[name=me_pw]').val();
	    	if(pw.trim() == ''){
	    		if(!confirm('기존 비밀번호로 유지하겠습니까?')){
	    			return false;
	    		}
	    	}
	    	let pw2 = $('[name=me_pw2]').val();
	    	if(pw != pw2){
	    		alert('비밀번호와 비밀번호 확인이 다릅니다')
	    		return false;
	    	}
	    	return true;
	    })

		})
	</script>
</body>
</html>