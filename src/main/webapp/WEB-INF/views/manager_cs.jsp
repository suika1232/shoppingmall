<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/selectric/selectric.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/manager/manager_cs.css?after">
<title>Manager - CS</title>
</head>
<body>
<% String member_class = (String)request.getAttribute("member_class"); %>
<% if(member_class.equals("Manager")){ %>
<div id="menuTitle">문의 리스트</div>
<select id="displayPageCount">
	<option value="10" selected="selected">10</option>
	<option value="20">20</option>
	<option value="30">30</option>
</select>
<table id="tblCs" class="csView">
	<tr><td>번호</td><td>제품분류</td><td>아이디</td><td>작성일</td><td>문의내용</td><td>문의상태</td><td>답변작성</td></tr>
</table>
<div id="pageBox"></div>
<div id="csModal">
<input type="hidden" id="postSeq" readonly="readonly">
<table id="tblCsComment">
	<tr><td>제품분류</td><td></td></tr>
	<tr><td>제목</td><td></td></tr>
	<tr><td>내용</td><td></td></tr>
	<tr><td>답변</td><td></td></tr>
	<tr><td colspan="2"><textarea id="csComment"></textarea></td></tr>
</table>
<button type="button" id="btnModalSubmit">작성</button>
<button type="button" id="btnModalClose">닫기</button>
</div>
<% }else{ %>
	<%@include file="manager_error.jsp" %>
<% } %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/selectric/jquery.selectric.min.js"></script>
<script src="/js/manager/manager_cs.js?ver=1"></script>
</html>