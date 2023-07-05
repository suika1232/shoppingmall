<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="./parts/form_css.jsp" %>
</head>
<style>
#pageBox{
	font-weight: 1000;
}
#tblList{
	border-right:none;
	border-left:none;
	border-top:none;
	border-bottom:none;	
	margin: 0 auto;	
	margin-left:100px;
}

#tblList td{
	width:150px;
	height:100px;
	font-size:20px;
	font-weight: 1000;
	color:black;
	border-collapse:collapse;
	border-right:none;
	border-left:none;
}
.nulltd{
	border-top:none;
	border-bottom:none;	
}
#tblList th{
	width:450px;
	height:100px;
	
	font-size:20px;
	color:black;
	border-collapse:collapse;
	border:0;
}
.section{

	 padding-right:3%;
     padding-bottom:5%;
	 background-color:white;
	 display:flex;	
 	 outline-style:solid;
 	 outline-width:thin;
 	 outline-color:gray;
 	 
}
.pageDiv{
	display: inline-block;
	 margin-left: 5px;
	 }

.jh{
	float:left;
	background-color:white;
	font-size:20px;
	position: sticky;
	width: 180px;
	top: 150px;
	left: 20px;
	margin-right:30px;
}

section a{
	text-decoration-line:none;
 	font-weight:bold;color:black
}
table td img{
	width: 40px;
	heigth: 40px;	
}
#pageBox div {
	cursor:pointer;
	font-size:20px;
}
.myMenu{
	transform:scale(1.0); transition-duration:0.5s; display: inline-block;
}
.myMenu:hover{
	transform:scale(1.2); transition-duration:0.5s; cursor:pointer;
}
.myMenu img{
	width:40px; height:40px; position:relative; top:5px; right:5px;
}
</style>
<body>
<%@ include file="./parts/head.jsp" %>

<section>
<%String id=(String)session.getAttribute("member_id"); %>
<div class=jh>
		<p style="font-weight: 900; ">My Page</p>
				<span class="myMenu"><img src="/img/myinfo.png"><a href="/member_update">MyInfo</a></span><br><br>
				<span class="myMenu"><img src="/img/order_icon.png"><a href="/order_list">OrderList</a></span><br><br>
				<span class="myMenu"><img src="/img/review.png"><a href="/review">Reviews</a></span>
</div>
<div class=section>
	
	<div class=list>
 		<h1>주문 리스트</h1><input type=hidden id=id value=<%=id %>>
 		<h2><%=id %>님의 주문목록입니다.</h2>
  		<table id=tblList border=1 class=table_list>
        	<thead>
           	 <tr>
            		<th></th>
            		<th class=th>NO.</th>
                	<th class=th>제품사진</th>
                	<th class=th> 제품명 </th>
                	<th class=th>배송상태</th>
                	<th class=th>결제방식</th>
            </tr>
        	</thead>
    	</table>
   <div id=pageBox></div>
   </div>
</div>
</section>

<%@ include file="./parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
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
let date=''
$(document)
.ready(function(){
	displayOrder(1);
})
.on("click", "#pageBox div", function(){
   let pageNum = $(this).text();
   console.log(pageNum);
   displayOrder(pageNum);
   
})
function selectAll(selectAll){ //체크박스 all 
	//for문돌면서 selectAll 의 value 와 동일하게 만들어준다 
	const checkboxes = document.getElementsByName('a');

	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
		})	
}
function displayOrder(pageNum){
	$.ajax({url:'/select_order',
		type:'post',
		dataType:'json',
		data:{member_id:$('#id').val(), pageNum:pageNum},
		beforeSend:function(){
			console.log($('#id').val())
		},
		success:function(data){
			$("#tblList tr:gt(0)").remove();
			$("#pageBox").empty();
			for(let i=0; i<data.length; i++){
				let list=data[i]
				let str='<tr>'
				if(date!=list['order_created']){
				date=list['order_created']
				year=date.substring(2,4)
				month=date.substring(4,6)
				day=date.substring(6,8)
				str+='<td>'+year+'년'+month+'월'+day+'일'+'</td>'
				}else if($("#tblList td:eq(0)").text()==""){
					str+='<td>'+year+'년'+month+'월'+day+'일'+'</td>'
				}
				else{
					str+='<td class=nulltd>'+'&nbsp'+'</td>'
				}
				str+='<td class=td>'+(i+1)+'</td>'
				let img=list['prod_img']
				str+='<td class=td><img src='+img+'></td>'
				str+='<td class=td>'+list['prod_name']+'</td>'
				if(list['order_status']=='y'){
					str+='<td class=td>'+'배송완료'+'</td>'	
				}else if(list['order_status']=='n'){
					str+='<td class=td style="color:blue;">'+'배송중'+'</td>'	
				}
				order_payment = list['order_payment'];
				str+='<td class=td>'+ order_payment +'</td></tr>'
				
				$('#tblList').append(str);
			}
			let total = data[0]["totalPage"];
			for(i=1; i<=total; i++){
	        	let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
	            $("#pageBox").append(str);
	        }

			
		}
	})
}
</script>
</html>