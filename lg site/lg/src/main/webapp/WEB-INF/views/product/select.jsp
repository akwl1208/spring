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
<script src="https://kit.fontawesome.com/38e579569f.js" crossorigin="anonymous"></script>
<style type="text/css">
[name="file"]{
	display: none;
}
.box-thumb{
	width: 150px; height: 150px; border: 1px solid red;
	text-align: center; font-size: 50px; line-height: 148px;
	cursor: pointer; box-sizing: border-box;
}
.fa-regular{
	line-height : 1;
}
.display-none{
	display: none;
}
.likes{
	color: red; cursor: pointer;
}
</style>
</head>
<!-- body ---------------------------------------------------------------- -->
<body>
<div class="container">
	<h2 class="clearfix">
		<span class= "float-left">제품 상세</span>
		<i class="fa-regular fa-heart float-right likes likes <c:if test="${li!= null}">display-none</c:if>"></i>
		<i class="fa-solid fa-heart float-right likes likes-ok <c:if test="${li == null}">display-none</c:if>"></i>
	</h2>
	<div class="clearfix">
	<!-- 제품 이미지 입력 ---------------------------------------------------------------- -->	
		<div class="float-left" style="width:auto; height:auto;">
			<img id="preview" width="150px" height="150px" src="<c:url value="${p.pr_thumb_url}"></c:url>">
		</div>
	<!-- 제품 정보 입력 ---------------------------------------------------------------- -->
		<div class="float-right" style="width:calc(100% - 150px - 10px)">
			<div class="form-group">
			  <input type="text" class="form-control" value="제품종류: ${p.pr_ca_name}" readonly>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" value="제품코드: ${p.pr_code}" readonly>		
			</div>
			<div class="form-group">
			  <input type="text" class="form-control" value="제품가격: ${p.pr_price}" readonly>
			</div>
		</div>
	</div>
	<!-- 제품 설명 입력 ---------------------------------------------------------------- -->
	<div class="form-group">
		<input type="text" class="form-control" value="${p.pr_title}">
	</div>
	<div class="form-group">
		<div class="form-control" style="height:auto">${p.pr_content}</div>
	</div>
	<div class="form-group">
		<label>제품스펙</label>
		<div class="form-control" style="height:auto">${p.pr_spec}</div>
	</div>
	<!-- QNQ ---------------------------------------------------------------- -->
	<div class="box-qna">
		<h4>QNA</h4>
		<!-- QNQ 목록 ---------------------------------------------------------------- -->
		<table class="table table-hover">
	    <thead>
	      <tr>
	        <th>제목</th>
	        <th>작성자</th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
	        <td class="box-qna">
	        	<a href="<%=request.getContextPath()%>/board/select?bd_num=" class="link-qna" data-secret="1">
		        	<i class="fa-solid fa-lock"></i><span>제목</span>
	        	</a>
        	</td>
	        <td>Doe</td>
	      </tr>
	    </tbody>
	  </table>
  <!-- 페이지네이션 ------------------------------------------------------------------------------------------- -->
  <ul class="pagination justify-content-center">
  	<li class="page-item <c:if test="${!pm.prev}">disabled</c:if>">
  		<a class="page-link" href="<c:url value="/board/list?page=1&search=${pm.cri.search}&bd_type=${bd_type}"></c:url>">처음</a>
 		</li>
 	  <li class="page-item <c:if test="${!pm.prev}">disabled</c:if>">
 	  	<a class="page-link" href="<c:url value="/board/list?page=${pm.startPage-1}&search=${pm.cri.search}&bd_type=${bd_type}"></c:url>">이전</a>
	  </li>  	
  	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
	  	<li class="page-item <c:if test="${pm.cri.page == i}">active</c:if>">
  			<a class="page-link" href="<c:url value="/board/list?page=${i}&search=${pm.cri.search}&bd_type=${bd_type}"></c:url>">${i}</a>
 		</li>
  	</c:forEach>
 	  <li class="page-item <c:if test="${!pm.next}">disabled</c:if>">
 	  	<a class="page-link" href="<c:url value="/board/list?page=${pm.endPage+1}&search=${pm.cri.search}&bd_type=${bd_type}"></c:url>">다음</a>
	  </li>
   	<li class="page-item" <c:if test="${!pm.next}">disabled</c:if>>
   		<a class="page-link" href="<c:url value="/board/list?page=${pm.finalPage}&search=${pm.cri.search}&bd_type=${bd_type}"></c:url>">마지막</a>
  	</li>
  </ul>
  <!-- QNA 등록 버튼 ------------------------------------------------------------------------------------------- -->
  <a href="<c:url value="/board/insert?bd_type=QNA&bd_pr_code=${p.pr_code}"></c:url>" class="btn btn-outline-success">QNA 등록</a>
	</div>
</div>
<!-- 스크립트 ---------------------------------------------------------------- -->
<script type="text/javascript">
<!-- 이벤트 ---------------------------------------------------------------- -->
$(function(){
	<!-- 찜하기 클릭---------------------------------------------------------------- -->
	$('.likes').click(function(){
		let li_me_email = '${user.me_email}';
		if(li_me_email == ''){
			alert('로그인이 필요한 서비스입니다.');
			return;
		}
		let li_pr_code = '${p.pr_code}';
		let likes = {
			li_me_email,
			li_pr_code
		}
		ajaxPost(false, likes, '/likes', function(data){
			if(data.res == 0){
				$('.likes').removeClass('display-none');
				$('.likes-ok').addClass('display-none');
				alert('찜한 제품을 취소했습니다.');
			} else if(data.res == 1){
				$('.likes').addClass('display-none');
				$('.likes-ok').removeClass('display-none');
				alert('해당 제품을 찜했습니다.');			
			} else{
				alert('잘못된 접근입니다.');
			}
		})
	})
	<!-- QNA 제목 클릭 ---------------------------------------------------------------- -->
	$(document).on('click', '.link-qna', function(e){
		if($(this).data('secret') == 1 && $(this).parent().text() == '${user.me_email}'){
			alert('비밀문의는 작성자와 관리자만 확인할 수 있습니다.');
			e.preventDefault();
		}
	})
	<!-- 페이지네이션 클릭 ---------------------------------------------------------------- -->
	$(document).on('click', '.pagenation .page-link', function(){
		if($(this).data('secret') == 1 && $(this).parent().text() != '${user.me_email}'){
			cri.page = $(this).data('page');
			loadQNA(cri);
		}
	})
	loadQNA(cri);
})
<!-- 함수 ---------------------------------------------------------------- -->
let page = 1;
let cri = {
	page : page,
	perPageNum : 2,
	search : '${p.pr_code}'
}
<!-- loadQNA ---------------------------------------------------------------- -->
function loadQNA(cri){
	ajaxPost(false, cri, '/qna/list', function(data){
		createQNAList(data.list, '.box-qna tbody');
		createPagenation(data.pm, '.pagination');
	})
}
<!-- createQNAList ---------------------------------------------------------------- -->
function createQNAList(list, target){
	let str = '';
	for(b of list){
		str +=	'<tr>';
		str += 		'<td class="box-qna">';
		str +=  		'<a href="<%=request.getContextPath()%>/board/select?bd_num='+b.bd_num+'" class="link-qna" data-secret="'+b.bd_secret+'">';
		if(b.bd_secret == '1')
			str +=   			'<i class="fa-solid fa-lock"></i>';
		str +=   			'<span>'+b.bd_title+'</span>';
		str +=  		'</a>';
		str += 		'</td>';
		str +=	  '<td>'+b.bd_me_email+'</td>';
		str +=	'</tr>';
	}
	$(target).html(str);
}
<!-- createPagenation ---------------------------------------------------------------- -->
function createPagenation(pm, target){
	let str = '';
	let prev = pm.prev ? '' : 'disabled';
	
	str +=	'<li class="page-item '+prev+'">';
	str +=		'<a class="page-link" href="javascript:0;" data-page="1">처음</a>';
	str +=	'</li>'
	str +=  '<li class="page-item '+prev+'">';
	str += 		'<a class="page-link" href="javascript:0;" data-page="'+(pm.startPage-1)+'">이전</a>';
	str +=	'</li>';  	
	for(i = pm.startPage; i<=pm.endPage; i++){
		let active = pm.cri.page = i ? 'active' : '';
		str +='<li class="page-item '+active+'">';
		str +=	'<a class="page-link" href=href="javascript:0;" data-page="'+i+'">'+i+'</a>';
		str +='</li>';
	}
	let next = pm.next ? '' : 'disabled'; 
	str +=	'<li class="page-item '+next+'">';
	str +=		'<a class="page-link" href="javascript:0;" data-page="'+(pm.endPage+1)+'">다음</a>';
	str +=	'</li>'
	str +=  '<li class="page-item '+prev+'">';
	str += 		'<a class="page-link" href="javascript:0;" data-page="'+pm.finalPage+'">마지막</a>';
	str +=	'</li>'; 
	
	$(target).html(str);
}
</script>	
</body>
</html>