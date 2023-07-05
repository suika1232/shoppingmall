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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<title>Order_info</title>
<%@ include file="./parts/form_css.jsp" %>
</head>
<style>
table{border:1px solid green;border-collapse:collapse;}
td{border:1px solid rgb(235, 219, 219)}
th{border:1px solid rgb(235, 219, 219)}
#order_check{left:35%;top:5%;margin:0 auto}
button{width:110px;height:70px;font-size:25px;font-weight:bold}
</style>
<body>
<%@ include file="./parts/head.jsp" %>
<section>
<br>
<div id="section">	

<table id="order_check">
	<tr><td><h1>주문이 완료되었습니다!</h1></td></tr>
	<tr><td><button id=toHome>홈으로</button></td></tr>
</table>

</div>
</section>		




<%@ include file="./parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function() {
    $(".main>li").mouseover(function() {
        $(this).children(".sub").stop().slideDown();
    });
    $(".main>li").mouseleave(function() {
        $(this).children(".sub").stop().slideUp();
    });
});
$(document)
.on('click','#toHome',function(){
	document.location="/home";
})
// 뒤로가기 막는 code 만들어야함

// 출처: https://vicki.tistory.com/1487 [불친절한자수씨]
</script>
</html>

