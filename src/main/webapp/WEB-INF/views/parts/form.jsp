<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <title>form</title>
</head>
<style>
header{
     min-width:1250px; min-height:200px;
     width: 100%; text-align: center; margin: 0 auto;
     margin-top:10px; 
     background-color:white; border-bottom:2px solid gray;
}
nav{
     width: 100%; text-align: center; margin: 0 auto;
     line-height:50px; font-size:20px; font-weight:bold;
     min-width:1250px;
}
aside{
     height: 600px; width: 19%; outline: dashed 1px green; text-align: center;
     float: left ; margin-top: 110px; position:fixed;
} 
section{
     height: 100%; width:100%; text-align: center; margin-bottom: 15px;
     position:relative; min-width:1250px;
     padding-bottom:15%;overflow:auto; background-color:white;
     border-top:2px solid gray;}
footer{
     height:100%; width: 100%; text-align: center; margin-bottom: 50px;
     margin: 0 auto; position:relative;min-width:1250px;
     border-top:2px solid gray;border-bottom:2px solid gray;
	}
/*RESET*/
#nav *{ margin: 0; padding: 0;}
#nav a{ text-decoration: none;}

li{list-style:none;}	
#nav{width:100%; background-color:white;font: 20px 'Nanum Gothic', sans-serif; }
#nav:after{content:"";display:block;clear:both;}
.main {margin:30px;}
.main > li {
    position: relative;
    float: left;
    width: 245px;		
    height: 30px;
    box-sizing: border-box;
    line-height: 30px;
    text-align: center;
    background: white;
}
.main > li:hover .sub { /*display: block;*/ }
.main > li a { display: block;transition: all 0.3s;}
.main > li a:hover {background: black; color: white;}
.sub {
    display: none;
    position: absolute;
    top: 30px;
    left: 0;
    z-index: 1;
    width: 100%;
    background: white;
    opacity: 0.8;
}
#logo{display:block;
	width:100%;
	height:auto;}
</style>
<body>

<header>
<a href="/home">
<img id=logo src="/img/Digital Oasis-logo-black.png" style="width:50%;height:50%">
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
			<li><a href="/customer_service">고객문의</a></li>
			

			<% if(session.getAttribute("member_class")==null){ %>
			<li><a href="#">내 계정</a>
				<ul class="sub">
					<li><a href="/login">로그인</a></li>
					<li><a href="/signin">회원가입</a></li>
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


<section>	

	<!--  내용 입력부분  -->
	
</section>
	

<footer class="footer">
  <div class="container">
    <div class="row">
      <div class="col-md-4">
        <h4>About Digital Oasis</h4>
        <p>At Digital Oasis, we strive to provide the latest and greatest in electronics. Our goal is to create a one-stop shop for all your digital needs.</p>
      </div>
      <div class="col-md-4">
        <h4>Contact Us</h4>
        <ul class="list-unstyled">
          <li><i class="fa fa-map-marker"></i> 123 Main St, Anytown Korea</li>
          <li><i class="fa fa-phone"></i> (555) 555-5555</li>
          <li><i class="fa fa-envelope"></i> info@digitaloasis.com</li>
        </ul>
      </div>
      <div class="col-md-4">
        <h4>Connect With Us</h4>
        <ul class="list-unstyled">
          <li><a href="#"><i class="fa fa-facebook"></i> Facebook</a></li>
          <li><a href="#"><i class="fa fa-twitter"></i> Twitter</a></li>
          <li><a href="#"><i class="fa fa-instagram"></i> Instagram</a></li>
          <li><a href="#"><i class="fa fa-youtube"></i> YouTube</a></li>
        </ul>
      </div>
    </div>
  </div>
</footer>


</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document).ready(function() {
    $(".main>li").mouseover(function() {
        $(this).children(".sub").stop().slideDown();
    });
    $(".main>li").mouseleave(function() {
        $(this).children(".sub").stop().slideUp();
    });
});

</script>
</html>




