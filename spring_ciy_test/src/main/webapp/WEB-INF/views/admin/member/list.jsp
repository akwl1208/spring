<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
	<div class="container">
	  <h2>회원등급관리</h2>
	  <table class="table table-bordered table-hover">
	    <thead>
	      <tr>
	        <th>아이디</th>
	        <th>등급</th>
	      </tr>
	    </thead>
	    <tbody>
	   		 <c:forEach items="${list}" var="member">
	      	 <tr>
		        <td class="id">${member.me_id}</td>
		        <td class="form-group">
			        <select class="form-control authority">
				      	<c:forEach begin="1" end="${user.me_authority - 1}" var="i">
				      		<option <c:if test="${i == member.me_authority}">selected</c:if>>${i}</option>
				      	</c:forEach>
				      </select>
		        </td>
		      </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	</div>
	<script type="text/javascript">
	$(function(){
		$('.authority').change(function(){
			let me_id = $(this).parent('tr').find('.id').text();
			let me_authority = $(this).val();
			let obj={
				me_id,
				me_authority
			};
			$.ajax({
		    async: false,
		    type:'POST',
		    data: JSON.stringify(obj),
		    url: '<%=request.getContextPath()%>/admin/authority/update',
		    dataType:"json", 
		    contentType:"application/json; charset=UTF-8",
		    success : function(data){
					if(data.res)
						alert('회원등급을 변경했습니다')
					else
						alret('잘못된 접근입니다')
		    }
			});
		})		
	})
	</script>
</body>
</html>