<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<header>
<a href="/home" style="width:50%;">
<img id=logo src="/img/Digital Oasis-logo-black.png" style="width:50%;height:50%;max-width:600px;max-height:300px;margin:0 auto">
</a>
</header>
	

<nav>
	<div id="nav">
		<ul class="main">
			<li><a href="/goods_list">전체상품</a>
				<ul class="sub">
					<li><a href="/goods_list_kitchen">주방가전</a></li>
					<li><a href="/goods_list_home">생활가전</a></li>
					<li><a href="/goods_list_season">계절가전</a></li>
				</ul>
			</li>
			
			<li><a href="/goods_list_best">베스트상품</a></li>
			<li><a href="/goods_list_new">신상품</a></li>
			<li><a href="/post">고객문의</a></li>
			

			<% if(session.getAttribute("member_class")==null){ %>
			<li><a href="#">내 계정</a>
				<ul class="sub">
					<li><a href="/login">로그인</a></li>
					<li><a href="/signin">회원가입</a></li>
					<li><a href="/cart2">비회원 장바구니</a></li>
				</ul>
			</li>
			<% } else if(session.getAttribute("member_class").equals("User")){%>
			<li><a href="#">내 계정</a>
				<ul class="sub">
					<li><a href="/mypage">마이페이지</a></li>
					<li><a href="/cart">장바구니</a></li>
					<li><a href="/logout">로그아웃</a></li>
				</ul>
			</li>
			<% } else if(session.getAttribute("member_class").equals("Manager")){ %>
			<li><a href="#">내 계정</a>
				<ul class="sub">
					<li><a href="/manager_home">관리페이지</a></li>
					<li><a href="/logout">로그아웃</a></li>
				</ul>
			</li>
			<% } %>
		</ul>
	</div>
</nav>