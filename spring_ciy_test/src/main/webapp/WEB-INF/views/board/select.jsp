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
			<div class="form-group">
				<label>첨부파일</label>
				<c:if test="${fileList.size() == 0}">없음</c:if>
				<c:if test="${fileList.size() != 0}">
					<c:forEach items="${fileList}" var="fi">
						<a href="<c:url value="/file${fi.fi_name}"></c:url>" class="form-control" download="${fi.fi_ori_name}">${fi.fi_ori_name}</a>
					</c:forEach>
				</c:if>
			</div>
			<c:if test="${user != null && user.me_id == board.bd_me_id}">
				<a href="<c:url value="/board/update/${board.bd_num}"></c:url>" class="btn btn-outline-info">수정</a>
				<a href="<c:url value="/board/delete/${board.bd_num}"></c:url>" class="btn btn-outline-danger">삭제</a>
			</c:if>
			<c:if test="${user.me_id != board.bd_me_id}">
				<a href="<%=request.getContextPath()%>/board/insert?bd_ori_num=${board.bd_ori_num}&bd_depth=${board.bd_depth}&bd_order=${board.bd_order}" class="btn btn-outline-info">답글</a>
			</c:if>
			<hr>
			<div class="form-group">
				<textarea class="form-control" rows="5" name="co_content"></textarea>
				<button class="btn btn-outline-info col-12 btn-co-insert">댓글등록</button>
			</div>
			<div class="list-comment"></div>
		  <ul class="pagination-comment pagination justify-content-center mt-3"></ul>
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
			//추천/비추천 버튼 클릭
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
		
		//댓글
		$(function(){
			//댓글 등록 버튼 클릭
			$('.btn-co-insert').click(function(){
				let co_me_id = '${user.me_id}';
				//아이디 확인
				if(co_me_id == ''){
					//로그인 화면으로 이동할지 물어보고
					if(confirm('로그인한 회원만 댓글 작성이 가능합니다. 로그인하겠습니까?')){
						//로그인화면으로 이동
						location.href = '<%=request.getContextPath()%>/login';
						return;
					}else{
						return;
					}
				}
				//댓글 내용 확인				
				let co_bd_num = '${board.bd_num}';
				let co_content = $('[name=co_content]').val();
				//댓글 내용이 없으면 입력하라고 알려줌
				if(co_content.trim().length == 0){
					alert('내용을 입력하세요')
					$('[name=co_content]').focus();
					return;					
				}
				let comment = {
					co_content,
					co_bd_num : '${board.bd_num}'
				}
				ajaxPost(false, comment, '/ajax/comment/insert', commentInsertSuccess);
			})
			getCommentList(cri);
		})//
		
		//전역변수
		let cri = {
			page : 1,
			perPageNum : 5
		}
		
		//함수
		//댓글리스트 가져오기
		function getCommentList(cri){
			if(cri == undefined || cri == null || typeof cri != 'object'){
				cri = {};
			}
			if(isNaN(cri.page))
				cri.page = 1;
			
			ajaxPost(false, cri, '/ajax/comment/list/'+${board.bd_num}, commentListSuccess);
		}//
		
		function commentInsertSuccess(data){
			if(data.res)
				alert('댓글을 등록했습니다');
			else
				alert('댓글 등록에 실패했습니다');
			getCommentList(cri);
			$('[name=co_content]').val('');
		}//
		function commentUpdateSuccess(data){
			if(data.res)
				alert('댓글을 수정했습니다');
			else
				alert('댓글 수정에 실패했습니다');
			getCommentList(cri);
		}//
		function commentDeleteSuccess(data){
			if(data.res)
				alert('댓글을 삭제했습니다');
			else
				alert('댓글 삭제에 실패했습니다');
			getCommentList(cri);
		}//
		function commentListSuccess(data){
			let list = data.list;
			let str = '';
			//반복문을 이용해 댓글 구성
			for(co of list){
				str += '<div class="media border p-3">';
				str += 	 '<div class="media-body">';
				str +=     '<h5>'+ co.co_me_id + '<small><i>' + co.co_reg_date_str + '</i></small></h5>';
				str +=     '<p>'+ co.co_content +'</p>';      
				str +=   '</div>';
				str +=   '<div class="btn-box">';
				if(co.co_me_id == '${user.me_id}'){
					str += 	 '<button data-target="'+co.co_num+'" class="btn btn-outline-success btn-co-update" style="display:block">수정</button>';
					str +=   '<button data-target="'+co.co_num+'" class="btn btn-outline-danger btn-co-delete mt-1" style="display:block">삭제</button>';
				}
				str +=   '</div>'
				str += '</div>';	
			}
			//댓글 화면에 출력
			$('.list-comment').html(str);
			
			//댓글 삭제 이벤트
			$('.btn-co-delete').click(function(){
				let co_num = $(this).data('target');
				let comment = {co_num};
				ajaxPost(false, comment, '/ajax/comment/delete', commentDeleteSuccess);
			})
			
			//댓글 수정 이벤트
			$('.btn-co-update').click(function(){
				$('.btn-co-cancel').click();
				//기존 입력창을 감추고 textarea로 바꿈
				let contentEl = $(this).parent().siblings('.media-body').children('p');
				contentEl.hide();
				let content = contentEl.text();
				let str = '';
				str += '<div class="form-group box-content">';
				str += 	'<textarea class="form-control" rows="3">'+content+'</textarea>';
				str += '</div>';
				contentEl.after(str);
				//수정, 삭제 버튼 감춤
				$(this).parent().hide();
				//수정완료, 수정취소 버튼 추가
				let co_num = $(this).data('target');
				str = '';
				str += '<div class="btn-box2">';
				str += 	'<button data-target="'+co_num+'" class="btn btn-outline-success btn-co-complete" style="display:block">완료</button>';
				str += 	'<button class="btn btn-outline-danger btn-co-cancel mt-1" style="display:block">취소</button>';
				str += '</div>';
				$(this).parent().after(str);
				//수정 완료 버튼 클릭
				$('.btn-co-complete').click(function(){
					let co_num = $(this).data('target');
					let co_content = $(this).parent().siblings('.media-body').find('textarea').val();
					let comment = {co_num, co_content};
					ajaxPost(false,comment,'/ajax/comment/update', commentUpdateSuccess)
				})
				//수정 취소 버튼 클릭
				$('.btn-co-cancel').click(function(){
					 $(this).parent().siblings('.media-body').find('p').show();
					 $(this).parent().siblings('.media-body').find('.box-content').remove();
					 $(this).parent().siblings('.btn-box').show();
					 $(this).parent().remove();
				})
			})
			//댓글 페이지네이션
			let pm = data.pm;
			let pmStr = '';
			//댓글 페이지네이션 구성
			if(pm.prev){
				pmStr += '<li class="page-item" data-page="'+ (pm.startPage-1)+'">';
				pmStr +=	'<a class="page-link" href="javascript:0;">이전</a>';
				pmStr += '</li>';
			}
			for(let i = pm.startPage; i<=pm.endPage; i++){
				if(i == pm.cri.page){
					pmStr += '<li class="page-item active" data-page="'+ i +'">';
					pmStr +=	'<a class="page-link" href="javascript:0;">' + i + '</a>';
					pmStr += '</li>';	
				}else{
					pmStr += '<li class="page-item" data-page="'+ i +'">';
					pmStr +=	'<a class="page-link" href="javascript:0;">' + i + '</a>';
					pmStr += '</li>';
				}
			}	    			
			if(pm.next){
				pmStr += '<li class="page-item" data-page="'+ (pm.endPage+1) +'">';
				pmStr += 	'<a class="page-link" href="javascript:0;">다음</a>';
				pmStr += '</li>';
			}
			//댓글 페이지네이션 화면에 출력
			$('.pagination-comment').html(pmStr);
			//페이지네이션에서 페이지 이동 이벤트
			$('.pagination-comment .page-item').click(function(){
				cri.page = $(this).data('page');
				getCommentList(cri);
			})

		}//
		
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