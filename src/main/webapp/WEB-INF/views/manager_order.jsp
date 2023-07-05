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
<link rel="stylesheet" href="css/manager/manager_order.css?after">
<title>Manager - Order</title>
</head>
<body>
<% String member_class = (String)request.getAttribute("member_class"); %>
<% if(member_class.equals("Manager")){ %>
<div id="menuTitle">주문 리스트</div>
<select id="displayPageCount">
	<option value="10" selected="selected">10</option>
	<option value="20">20</option>
	<option value="30">30</option>
</select>
<button type="button" id="btnOrderConfirm">주문확인</button>
<button type="button" id="btnOrderCancel">주문취소</button>
<table id="tblOrderList" class="orderView">
	<tr>
		<td><input type="checkbox" id="orderAllChk"></td>
		<td>주문번호</td><td>주문일자</td><td>주문상태</td><td>상품번호</td><td>주문상세정보</td>
	</tr>
</table>
<div id="pageBox"></div>
<% }else{ %>
	<%@include file="manager_error.jsp" %>
<% } %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/selectric/jquery.selectric.min.js"></script>
<script src="/js/manager/manager_order.js?after"></script>
</html>