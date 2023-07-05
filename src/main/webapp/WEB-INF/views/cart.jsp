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
	position: relative; bottom: 22px;
	}
.chk{
	
}
.cdk{
	position: relative; bottom: 38px;
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
	text-align: center;
    border:0px;
    
    width:120px;
    height:50px;
}
.table {
		font-size:26px;
		font-family: 'Noto Sans KR', sans-serif;
		margin-left: 10px;
		margin-right: 10px;
        display: table;
        width: 100%;
      }
.row {
       display: table-row;
       text-align:center;
}
.cell {
        display: table-cell;
        border: 1px solid gray;
        border-right:none;
        border-left:none;
        padding: 5px;
    	font-size:20px;
 	 	text-align: center;
      }

.custom-bg{
	background-color:black;
	color : white;
}
.pageDiv{
	display: inline-block;
	 margin-left: 5px;
}
#pageBox div {
	cursor:pointer;
	font-size:20px;
	font-weight:bold;
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
	font-size:15px;
	font-weight: bold;
}
#delete{
	flex:1;
	width:120px;
	height:30px;
	font-size:15px;
	font-weight: bold;
}
#select{
	flex:1;
	width:80px;
	height:30px;
}
.cell img{
	width:60px;
	height:60px;
	position: relative;
    top: 15px;
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
			<select id=select>
				<option class=num value=10>10</option>
				<option class=num value=20>20</option>
				<option class=num value=30>30</option>
			</select>
			<div><button id=buy>선택제품 구매</button></div><div><button id=delete>선택제품 삭제</button></div>
		</div>
	</div>
	<div id="tableBox">
 	<div class="table" id="tbl">
	<br>
      <div class="row"><!--헤더 -->
      	<br><div class="check"><input type = checkbox id="chk" class="chk" value=checkAll name=selectAll onclick='selectAll(this)'>
      	<label class="ch" for="chk"></label>
      	</div>
      	<div class="cell  custom-bg">NO</div>
        <div class="cell  custom-bg">상품정보</div>
        <div class="cell  custom-bg">수량</div>
         <div class="cell  custom-bg">상품금액</div>
      </div>
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
let price=0
let count=0
let seq2=new Array()
$(document)
.ready(function(){
	selectCart(10,1)
})
.on("change","#select",function(){
 	count=$('#select option:selected').text();
	console.log(count)
	selectCart(count,1);
})
.on("click", "#pageBox div", function(){
	count=$('#select option:selected').text();
   let pageNum = $(this).text();
   console.log(pageNum);
   selectCart(count,pageNum);
})
.on('click','#delete',function(){
	
	for(var i=0;i<$('input[name="b"]:checked').length;i++){
		
		
		cart_seq = parseInt( $('input[name="b"]:checked:eq('+i+')').val() );
		
		$.ajax({url:'/delete_cart',
			type:'post',
			dataType:'text',
			data:{cart_seq:cart_seq},
			success:function(data){
				if(data=='ok'){}else{}
		}})
	}

	
	document.location = "/cart";
	
})
.on('click','#buy',function(){
	cart_seq = "";
	
	if($('input[name="b"]:checked').length==0){
		alert('구매할 제품을 선택해주세요');return false;
	}
	
	for(var i=0; i<$('input[name="b"]:checked').length; i++){
		cart_seq += "," + parseInt($('input[name="b"]:checked:eq('+i+')').val())
		cart_seq = cart_seq.replace("NaN,","");	
	}
	
	cart_seq = cart_seq.replace(",","");
	
	document.location="/order_info2/"+cart_seq  
	// document.location = "/order_info/" + str
	
	// str => cart_seq 의 나열  1,2,3
})
function selectAll(selectAll){ //체크박스 all 
	//for문돌면서 selectAll 의 value 와 동일하게 만들어준다 
	const checkboxes = document.getElementsByName('b');

	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
		})	
}
function selectCart(count,pageNum){	
	$.ajax({url:'/select_cart',
			type:'post',
			dataType:'json',
			data:{member_id:$('#member_id').val(),pageNum:pageNum,count:count},
			beforeSend:function(){
				console.log($('#member_id').val()),
				console.log(pageNum)
				console.log(count)
			},
			success:function(data){
				 $('div[name=cart]').remove();  ////////////////////// 
				 $("#pageBox").empty();
				for(let i=0; i<data.length; i++){
					let cart=data[i]
					let seq=cart['cart_seq']
					$('#cart_seq').val(seq)
					let str='<div class="row" name="cart">'
					str+='<br><div class="check2"><input type="checkbox" value='+seq+' name="b" id="cdk'+i+'" class="cdk"><label for="cdk'+i+'"></label></div>'
					let image=cart['prod_image']
					str+='<div class="cell">'+i+'</div>'
					str+='<div class="cell"><img src="'+image+'"></div>'
				   	qty=cart['cart_qty']
					str+='<div class="cell"><input type=number class=order_qty value='+qty+' id=qty readonly></div>'
				    price=cart['cart_price']
				    str+='<div class="cell"><input type=text value='+price+' class="total" id="total" readonly></div></div>'
				    $(".table").append(str);
				}
				let total = data[0]["totalPage"];
				for(i=1; i<=total; i++){
		        	let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
		            $("#pageBox").append(str);
		        }
			}})
}
</script>
</html>
