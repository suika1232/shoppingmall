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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/css/myPage.css">
<title>Insert title here</title>
<%@ include file="./parts/form_css.jsp" %>
</head>

<body>
<%@ include file="./parts/head.jsp" %>
<br>
<div class=section>
<div id="click"></div>
<div id="clickMe">click me!</div>
<div>
<a href="/member_update" class="coco1 hidden" id="coco1"></a>
<div class="info hidden">myInfo</div>
</div>
<div>
<a href="/order_list" class="coco2 hidden" id="coco2"></a>
<div class="info2 hidden">OrderList</div>
</div>
<div>
<a href="/review" class="coco3 hidden" id="coco3"></a>
<div class="info3 hidden">Review</div>
</div>
	<div class=img><img src="/img/Digital Oasis-logo-black.png"></div>
</div>

<%@ include file="./parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
var intervalId=setInterval(toggleElement, 1000);
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
.on("click", ".img", function(){
	console.log("div clicked");
	$("#coco1").toggleClass("hidden");
	$("#coco2").toggleClass("hidden");
	$("#coco3").toggleClass("hidden");
	$(".info").toggleClass("hidden");
	$(".info2").toggleClass("hidden");
	$(".info3").toggleClass("hidden");
	$("#click").addClass("hidden");
	$("#clickMe").addClass("hidden");
	clearInterval(intervalId);
})
.on("click","#coco1",function(){
	$("#coco1").toggleClass("hidden2");
	document.location='/member_update'
})
.on('click','#coco2',function(){
	document.location='/order_list'
})
.on('click','#coco3',function(){
	document.location='/review'
})
function toggleElement() {
  var element = document.getElementById("click");
  if (element.style.display === "none") {
    element.style.display = "block";
  } else {
    element.style.display = "none";
  }
}
</script>
</html>