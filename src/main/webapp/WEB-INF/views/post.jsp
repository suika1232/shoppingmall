<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ page session="true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<title>POST</title>
<%@ include file="./parts/form_css.jsp" %>
</head>
<style>
body {
	text-align: center;
	font-family: 'Noto Sans KR', sans-serif;
}

#tbltitle {
	border-collapse: collapse;
	width: 100%;
	margin: 10px;
}

table tr[name=post]:hover {
	background-color: #DFD3C3;
	cursor: pointer;
}

th, td {
	text-align: center;
	padding: 12px;
}

th {
	background-color: black;
	color: #FFFFFF;
	font-size: 15px;
}

td {
	color: #333333;
	font-size: 14px;
	border: 1px solid #C7BDB1;
}

a.btn {
	text-decoration: none;
	color: black;
}

a.btnWrite {
	font-size: 14px;
	text-decoration: none;
	padding: 5px;
	border: none;
	border-radius: 5px;
	background-color: black;
	color: white;
	cursor: pointer;
}

a.btnWrite:hover {
	background-color: #DFD3C3;
	color: black;
}

.write {
	text-align: right;
}

.pageIndex {
	text-align: center;
	margin-top: 15px;
	margin-bottom: 15px;
}

.bold-link {
	font-weight: bold;
}

select, input[type="text"], input[type="submit"] {
	padding: 5px;
	margin-top: 5px;
	border: none;
	border-radius: 4px;
	border: 1px solid #C7BDB1;
}

input[type="submit"] {
	background-color: white;
}
</style>
<body>
<%@ include file="./parts/head.jsp" %>
<h2><a href ="/post" class="btn">고객문의</a></h2>
<table border="1" id="tbltitle">		
	<tr>
		<th>글번호</th>
		<th>카테고리</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>답변여부</th>
	</tr>		
	<c:forEach items="${notice}" var="no">
		<tr name=post>
			<td>${no.post_seq}</td>
			<td>${no.category_name}</td>
			<td>${no.post_title}</td>
			<td>${no.member_id}</td>
			<td>${no.post_created}</td>
			<td>${no.post_answer}</td>
		</tr>
	</c:forEach>
	
	<c:forEach items="${board}" var="bbs">
		<tr name=post>
			<td>${bbs.post_seq}</td>
			<td>${bbs.category_name}</td>
			<td>${bbs.post_title}</td>
			<td>${bbs.member_id}</td>
			<td>${bbs.post_created}</td>
			<td>${bbs.post_answer}</td>
		</tr>
	</c:forEach>	
</table>

<div class="write">
	<c:if test="${sessionScope.member_id != null}">
		<a href='/post_insert' class="btnWrite">글쓰기</a>
	</c:if>
</div>

<span id="errorMessage"></span>

<form method="get" action="/post/search">
	<select name=type id="searchForm" >
		<option value="">검색 기준</option>
		<option value="a.post_title">제목</option>
		<option value="a.post_content">내용</option>
		<option value="b.member_id">작성자</option>
		<option value="c.category_name">카테고리</option>
		<option value="a.post_title||a.post_content">제목+내용</option>
	</select> 
	<input type="text" id="keyword" name="keyword"> 
	<input type="submit" id="btnsearch" value=검색>
</form>
<div class="pageIndex"> <!--페이징 -->   
   <a href="?pageNo=1&amount=${amount}" class="btn"><<</a>&nbsp
   <c:if test="${pageNo > 1}">
      <a href="?pageNo=${pageNo - 1}&amount=${amount}" class="btn"><</a>
   </c:if>
   <c:forEach var="i" begin="1" end="${endPage}">
      <a href="?pageNo=${i}&amount=${amount}" class="btn ${pageNo == i ? 'bold-link' : ''}">${i}</a>
   </c:forEach>
   <c:if test="${pageNo < endPage}">
      <a href="?pageNo=${pageNo + 1}&amount=${amount}" class="btn">></a>&nbsp
  </c:if>
   <a href="?pageNo=${endPage}&amount=${amount}" class="btn">>></a>
</div>

</body>
<%@ include file="./parts/foot.jsp" %>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function() {
    $(".main>li").mouseover(function() {
        $(this).children(".sub").stop().slideDown();
    });
    $(".main>li").mouseleave(function() {
        $(this).children(".sub").stop().slideUp();
    });
})
$(document)
.ready(function(){
   if('${errorMessage}'!='') {
	   $('#errorMessage').text('${errorMessage}');
	   $("#errorMessage").css("color", "gray");
   }
})
.on('click','#tbltitle tr:gt(0)', function() {
   let post_seq = $(this).find('td').eq(0).text();
    window.location.href = "/post_view/" + post_seq;
    })

.on("click",'#btnsearch', function(){
	if (!$('#searchForm').find('option:selected').val()) {
		alert("검색 기준을 선택하세요.");
		return false;
	}
	if ($("input[name='keyword']").val() == '') {
		alert("키워드를 입력하세요.");
		return false;
	}
	$('#searchForm').submit();
	})
	
	
</script>
</html>