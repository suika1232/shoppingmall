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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
      rel="stylesheet">    
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
     <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

    <title>cart_list</title>
    <%@ include file="./parts/form_css.jsp" %>
</head>
<style>
section a{text-decoration-line:none; font-weight:bold;color:black}
.ch{
	text-align:center;
}
.check{
	text-align:center;
	}
.cell {
  padding: 10px;
  text-align: center;
  display: table-cell;
  vertical-align: middle;";
}
#qty{
	font-weight:bold;
	font-size:26px;
	text-align:center;
    margin-bottom:0px;
    border-radius:150px;
    border:0px;
    margin:0 auto;
    display:block;
}
#total{
	font-weight:bold;
	font-size:26px;
    text-align:center;
    margin-bottom:0px;
    border-radius:150px;
    border:0px;
    margin:0 auto;
    display:block;   
}
.table {
		font-size:26px;
		font-family: 'Noto Sans KR', sans-serif;
		border-radius:10%;
		margin-left: 10px;
		margin-right: 10px;
        display: table;
        width: 95%;
        border-collapse:separate;
      }
.row {
        display: table-row;
}
.cell {
		margin:auto;
        display: table-cell;
        border: 1px solid black;
        padding: 5px;
    	font-size:20px;
      }

.custom-bg {
  background-color: black; 
  color : white;
   border: 1px solid white;
}
.pageDiv{
	display: inline-block;
	 margin-left: 5px;
}
#pageBox div {
	cursor:pointer;
	font-size:20px;
}
#buttons{position: absolute; left: 45px;}
#buttons div{display: inline-block;}
.button{
  	bottom: 10px;
  	left: 10px;
  	font-size:26px;/* 버튼 폰트 크기 */
  	width:200px;	
}
#buttons button{
	margin-right:10px;
}
.imgdiv{
	max-height: 200px;
	overflow: hidden;
}
.bimg{
	max-height: initial;
	margin-top: -10%;
}
.imgbox{
	text-align:center;
	display:block;
	border:1px solid #cecece;
	width:500px;
	height:100px;
}
#buy{
	flex:1;
	width:120px;
	height:30px;
}
#delete{
	flex:1;
	width:120px;
	height:30px;
}
#select{
	flex:1;
	width:80px;
	height:30px;
}
.cell img{
	width:60px;
	height:60px;
}
#tableBox{margin: 0 auto;}
</style>
<body>
<%@ include file="./parts/head.jsp" %>

<%String id=(String)session.getAttribute("member_id"); %>
	<input type=hidden id=member_id value=<%=id %>>
<!-- ////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<!--  ////////////////////////////////////////// body //////////////////////////////////////////////////// -->
<section>
<div id="section">
	<br>
	<div class=box>
		<div class=imgdiv>
			<img class=bimg src="/img/cart11.png">
		</div>
		<div id=buttons> 
			<div><button id=buy>구매하기</button></div><div><button id=delete>선택 제품삭제</button></div>
		</div>
	</div>
	<div id="tableBox">
 	<div class="table" id="tbl">
	<br>
      <div class="row"><!--헤더 -->
      	<br><div class="check"><input type = checkbox id="chk" class="chk" value=checkAll name=selectAll>
      	<label class="ch" for="chk"></label>
      	</div>
      	<div class="cell  custom-bg">제품코드</div>
        <div class="cell  custom-bg">상품정보</div>
        <div class="cell  custom-bg">수량</div>
        <div class="cell  custom-bg">상품금액</div>
      </div> 
      
      
	      <c:forEach items="${carts}" var="cart">
		      <div class="row">
		      	 <div class="check2"><input name=cdk type=checkbox></div>
		      	 <div class="cell">${cart.pid}</div>
		     	 <div class="cell"><img src="${cart.prod_image}"></div>
		     	 <div class="cell">${cart.cart_qty}</div>
		     	 <div class="cell">${cart.cart_price}</div>
		     </div>
	      </c:forEach>
      
   
    </div>
   	</div>
</div>
 <div id=pageBox></div> 
</section>
<!-- ////////////////////////////////////////// body ///////////////////////////////////////////////////// -->

<!--////////////////////////////////////////// footer ////////////////////////////////////////////////////-->
<%@ include file="./parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/jquery.cookie.js"></script>
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
.on('click','#buy',function(){
	alert('로그인을 먼저 해 주세요');
	document.location = "/login";
})
.on('click','#delete2',function(){
	
	alert($('[name=cdk]:checked').length);
	for(var i=0;i<$('[name=cdk]:checked').length;i++){
		
		pid = $('[name=cdk]:checked').parent().parent().find('div').eq(1).text();
		qty = $('[name=cdk]:checked').parent().parent().find('div').eq(3).text();
		price = $('[name=cdk]:checked').parent().parent().find('div').eq(4).text();
		
		
		$.ajax({url:'/deleteCookie', type:'post', 
			
			data:{pid:pid, qty:qty, price:price},
			success:function(){
				alert('삭제성공!');
			}
			
		})
	}
	
})
.on('click','#delete',function(){
	
	alert($('[name=cdk]:checked').length);
	
	str = '';
	for(var i=0;i<$('[name=cdk]:checked').length;i++){
		
		pid = $('[name=cdk]:checked:eq('+i+')').parent().parent().find('div').eq(1).text();
		qty = $('[name=cdk]:checked:eq('+i+')').parent().parent().find('div').eq(3).text();
		price = $('[name=cdk]:checked:eq('+i+')').parent().parent().find('div').eq(4).text();
		
		str = str + 'and' + pid +"-"+ qty +"-"+ price;
	
	}
	
	str = str.replace("and","");
	
	$.ajax({url:'/deleteCookie2', type:'post', 
		
		data:{cartsToDelete:str},
		
		success:function(){
			alert('삭제성공!');
			document.location = "/cart2";
		}
		
	})
	
})
.on('click','[name=selectAll]',function(){
	if( $('[name=selectAll]').prop('checked') ){
		for(var i=0;i<$('[name=cdk]').length;i++){
			$('[name=cdk]:eq('+i+')').prop('checked',true);
		}
	} else{
		for(var i=0;i<$('[name=cdk]').length;i++){
			$('[name=cdk]:eq('+i+')').prop('checked',false);
		}
	}

})


function setCookie(name, value, exp){
   var date = new Date()
   date.setTime(date.getTime()+exp*24*60*60*1000)
   document.cookie=name+'='+value+';expires='+date.toUTCString()+';path=/'
}
function getCookie(name){
   var value=document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)')
   return value? value[2]:null
}
function deleteCookie(name){
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
}
</script>
</html>