<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.alert{
		postion: fixed; top: 0; left: 0; right: 0; bottom: 0;
		background: rgba(0,0,0,0.3); line-height: 100vh; font-size: 40px;
		text-align: center; color: #fff;
	}
</style>
</head>
<body>
<div class="container">
  <br>
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" data-toggle="tab" href="#id">아이디 찾기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" href="#pw">비번 찾기</a>
    </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div id="id" class="container tab-pane active"><br>
      <h3>아이디 찾기</h3>
      <div class="form-group">
      	<input type="text" name="me_birth" class="form-control" placeholder="생년월일을 입력하세요(2000-01-01)">
      </div>
      <div class="form-group">
      	<input type="text" name="me_email" class="form-control" placeholder="이메일을 입력하세요">
      </div>
      <button class="btn btn-success col-12 btn-find-id">아이디 찾기</button>
    </div>
    <div id="pw" class="container tab-pane fade"><br>
      <h3>비번 찾기</h3>
      <div class="form-group">
      	<input type="text" name="me_birth" class="form-control" placeholder="생년월일을 입력하세요(2000-01-01)">
      </div>
      <div class="form-group">
      	<input type="text" name="me_email" class="form-control" placeholder="이메일을 입력하세요">
      </div>
      <button class="btn btn-success col-12 btn-find-pw">비번 찾기</button>
    </div>
  </div>
</div>
<script type="text/javascript">
	$(function(){
		let type = '${type}';
		$('[href="#'+type+'"]').click();
		
		$('.btn-find-id').click(function(){
			let me_birth = $('#id [name=me_birth]').val();
			let me_email = $('#id [name=me_email]').val();
			
			let birthRegex = /^\d{4}-\d{2}-\d{2}$/
			if(!birthRegex.test(me_birth)){
				alert('생일을 올바르게 입력하세요.');
				$('#id [name=me_birth]').focus();
				return;
			}
			if(me_email.trim() == ''){
				alert('이메일을 입력하세요');
				$('#id [name=me_email]').focus();
				return;
			}
			
			let member = {
				me_birth,
				me_email,
			}
			
			ajaxPost(false, member,'/ajax/find/id',findIdSuccess);
		})
		
		$('.btn-find-pw').click(function(){
			let me_birth = $('#pw [name=me_birth]').val();
			let me_email = $('#pw [name=me_email]').val();
			
			let birthRegex = /^\d{4}-\d{2}-\d{2}$/
			if(!birthRegex.test(me_birth)){
				alert('생일을 올바르게 입력하세요.');
				$('#pw [name=me_birth]').focus();
				return;
			}
			if(me_email.trim() == ''){
				alert('이메일을 입력하세요');
				$('#pw [name=me_email]').focus();
				return;
			}
			
			let member = {
				me_birth,
				me_email,
			}
			
			ajaxPost(false, member,'/ajax/find/pw',findPwSuccess);
		})
	})
	function findIdSuccess(data){
   	if(data.id == null){
   		alert('가입된 아이디가 없습니다');
   		return;
   	}else{
   		alert('회원님의 아이디는 다음과 같습니다\n'+data.id);
   	}
	}
	function findPwSuccess(data){
		if(data.res){
			alert('메일로 임시 비밀번호를 전송했습니다. 확인하세요')
		}else{
			alert('입력한 정보가 잘못됐거나 없는 회원 정보입니다')
		}
	}
	//ajaxPost
	function ajaxPost(async, dataObj, url, success){
		$.ajax({
    async: async,
    type:'POST',
    data: JSON.stringify(dataObj),
    url: "<%=request.getContextPath()%>" + url,
    contentType:"application/json; charset=UTF-8",
    success : function(data){
				success(data)
    }
		});
	}//
	
</script>
</body>
</html>