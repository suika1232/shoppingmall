<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/selectric/selectric.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	  rel="stylesheet">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/manager/manager_product.css?after">
<title>Manager - Product</title>
</head>
<body>
<% String member_class = (String)request.getAttribute("member_class"); %>
<% if(member_class.equals("Manager")){ %>
<div id="menuTitle">제품 리스트</div>
<select id="displayPageCount">
	<option value="10" selected="selected">10</option>
	<option value="20">20</option>
	<option value="30">30</option>
</select>
<button type="button" id="btnProdInsert">제품등록</button>
<button type="button" id="btnProdDel">제품삭제</button>
<button type="button" id="btnProdUpdate">제품수정</button>
<br>
<table id="tblProdList" class="prodView">
	<tr>
		<td><input type="checkbox" id="prodAllChk"></td>
		<td>번호</td>
		<td>카테고리</td>
		<td>코드</td>
		<td>제품명</td>
		<td>가격</td>
		<td>수량</td>
	</tr>
</table>
<div id="pageBox"></div>
<input type="hidden" id="currPage">
<div id="prodAmountModal">
<table id="tblProdAmount">
	<tr>
		<td>제품번호</td><td></td>
	</tr>
	<tr>
		<td>제품명</td><td></td>
	</tr>
	<tr>
		<td>재고</td><td></td>
	</tr>
</table>
<label for="inputAddProdAmount" id="labelAmount">추가수량</label><br>
<input type="text" id="inputAddProdAmount" onkeyup="inputNumberFormat(this)"><br>
<button type="button" id="btnEmptyProdAmount">재고비우기</button>
<button type="button" id="btnAddProdAmount">추가</button>
<button type="button" id="btnCloseModal">취소</button>
</div>
<% }else{ %>
	<%@include file="manager_error.jsp" %>
<% } %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/selectric/jquery.selectric.min.js"></script>
<script src="/js/manager/manager_product.js?after"></script>
</html>