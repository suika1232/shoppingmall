<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	  rel="stylesheet">
<link rel="stylesheet" href="css/manager/manager_home.css">
<title>Manager Menu</title>
</head>
<%@include file="parts/form_css2.jsp" %>
<body>
<%@include file="parts/head.jsp" %>
<% String member_class = (String)request.getAttribute("member_class"); %>
<% if(member_class.equals("Manager")){ %>
	<aside>
	<div id="aside">
	<span id="managerMenuTitle">관리자메뉴</span><br><br>
	<span class="managerMenu" id="memberManage"><img src="img/menu_icon/person_icon.png">회원관리</span><br><br>
	<span class="managerMenu" id="orderManage"><img src="img/menu_icon/order_icon.png">주문관리</span><br><br>
	<span class="managerMenu" id="prodManage"><img src="img/menu_icon/package_thin_icon.png">제품관리</span><br><br>
	<span class="managerMenu" id="csManage"><img src="img/menu_icon/customer service_icon.png">문의관리</span>
	</div>
	</aside>
	<section>
	<div id="section"><iframe id="sectionView" src="/manager_user"></iframe></div>
	</section>
<% }else{ %>
	<%@include file="manager_error.jsp" %>
<% } %>
<%@include file="parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/manager/manager_home.js?after"></script>
</html>