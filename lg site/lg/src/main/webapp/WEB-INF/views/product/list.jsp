<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.product-box{
	height: 300px; border-radius: 16px; box-shadow: 2px 4px 16px 0 rgba(0,0,0,0.14);
	margin-botton : 20px; padding : 20px; display: block;
}
.product-box>.float-right{
	width : calc(100% - 200px - 100px); height: 200px;
	padding: 30px; box-sizing: border-box;
}
.btn-more{
 	border-radius: 16px; box-shadow: 2px 4px 16px 0 rgba(0,0,0,0.14);
}
</style>
</head>
<body>
<div class="container product-container">
  <h2>${pr_ca_name}</h2>
</div>
<!-- 스크립트 ------------------------------------------------------------------------------------------ -->
<script>
	let pr_ca_name = '${pr_ca_name}';
	let page = 1;
	let cri = {
		pr_ca_name,
		page,
		perPageNum : 2
	}
	$(function(){
		getProductList(cri);
		$(document).on('click','.btn-more',function(){
			page++;
			cri.page = page;
			$(this).remove();
			getProductList(cri);
		})
	})
<!-- 함수 ------------------------------------------------------------------------------------------ -->
function getProductList(cri){
	ajaxPost(false, cri, '/ajax/product/list', function(data){
		let str = '';
		let cp = '<%=request.getContextPath()%>';
		for(p of data.list){
			str += '<a class="product-box clearfix" href="'+cp+'/product/select?pr_code='+p.pr_code+'">';
			str += 	'<div class="float-left">';
			str += 		'<img src="'+cp+ p.pr_thumb_url+'" width="200px" height="200px">';
			str +=	'</div>';
			str +=	'<div class="float-right">';
			str +=		'<h3 class="pr_title">'+p.pr_title+'</h3>';
			str +=		'<h4 class="pr_code">'+p.pr_code+'</h4>';
			str +=		'<h5 class="pr_price">'+p.pr_price_str+'</h5>';
			str +=	'</div>';
			str +=	'<hr class="float-left w-100">';
			str += '</a>';	
		}
		if(page < data.pm.finalPage)
			str += '<button class="btn btn-more col-12 mb-2">더보기</button>';
		$('.product-container').append(str);
		console.log(data.pm);
	})
}
</script>
</body>
</html>