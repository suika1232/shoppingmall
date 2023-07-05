<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<title>리뷰 작성 페이지</title>
<%@ include file="./parts/form_css.jsp" %>
<style>
#dig{
	background-color:#E3DFFD; 
	color:black;
}
#ynDig{
	background-color:#E3DFFD; 
	color:black;
}

.jh{
	background-color:white;
	font-size:20px;
 	width: 200px;
	position: sticky;
	margin-top: 20px;
	top: 150px;
	left: 20px;
	float: left; 

}
.section{
	background-color:#white;
	text-align: center;
	display:flex;
	flex-direction:column;
	margin-left:220px;
	outline-style:solid;
 	outline-width:thin;
 	outline-color:gray;
}
.h3{
	width:200px;
	margin-right: 800px;
	font-weight: 100px;
	font-size:20px;
	
}
.ok tr:hover {
   background-color:#E3DFFD;
}
.ok{
	display: flex;
	background-color:white;
	justify-content: center;
	
}
.ok2 tr:hover {
   background-color: #E3DFFD;
}
.ok2{
	display: flex;
	background-color:white;
	justify-content: center;
	
}
#tblPost td{	
	width:150px;
	height:50px;
	font-size:20px;
	font-weight: 1000;
	color:black;
	border: thin solid gray;
	border-right:none;
	border-left:none;
	border-top:none;
}
#tbldone td{	
	width:150px;
	height:50px;
	font-size:20px;
	font-weight: 1000;
	color:black;
	border-color:gray;
	border: thin solid gray;
	border-right:none;
	border-left:none;
	border-top:none;
	 
}
#tblPost th{
	width:150px;
	height:50px;
	color:black;
	border: thin solid gray;
	border-right:none;
	border-left:none;
	border-top:none;
}
#tbldone th{
	width:150px;
	height:50px;
	color:black;
	border: thin solid gray;
	border-right:none;
	border-left:none;
	border-top:none;
}
#tbldone{
	width: 100%;
}
#tblPost{
	width: 100%;
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
a{text-decoration-line:none; font-weight:bold;color:black}
#p_id{display:none;}
#ord{display:none;}
#m_seq{display:none;}
.pageDiv{display: inline-block;}
#pageBox div {
	cursor:pointer;
	font-weight:bold;
}
#pageBox2 div {
	cursor:pointer;
	font-weight:bold;
}
[name=review_content]{
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  word-break: break-all;
  width:180px;
}

</style>
</head>
<body>
<%@ include file="./parts/head.jsp" %>
<%String id=(String)session.getAttribute("member_id"); %>
<section>
<div class=jh>
	<p style="font-weight: 900;">My Page</p>
				<span class="myMenu"><img src="/img/myinfo.png"><a href="/member_update">MyInfo</a></span><br><br>
				<span class="myMenu"><img src="/img/order_icon.png"><a href="/order_list">OrderList</a></span><br><br>
				<span class="myMenu"><img src="/img/review.png"><a href="/review">Reviews</a></span>
</div>
<div class=section style="display:flex;">
   <h1>리뷰 작성 페이지</h1>
    <input type=hidden id=id_insert value=<%=id%>>	
  	<h2><%=id %>의 리뷰목록</h2>  
    <h3 class=h3>작성 가능한 리뷰</h3>
	<div class=ok>
    <br>
	  	  <table id=tblPost>
	        	<thead>
	            	<tr>
	            		<th>NO</th>
		                <th>제품번호</th>
		                <th>제품사진</th>
		                <th>제품이름</th>
		                <th>최근주문날짜</th>
	            	</tr>
	        	</thead>
	        	<tbody>
	        		
	        	</tbody>
	   	 </table>
    </div>
    <br>
    <div id=pageBox></div>
    <br>
    <br>
    
   <h3 class=h3>작성한 리뷰</h3>
    <div class=ok2>
   
     <table id=tbldone>
        <thead>
            <tr>
            	<th>NO</th>
                <th>리뷰 번호</th>
                <th>제품이름</th>
                <th>제품사진</th>
                <th>별점</th>
                <th>리뷰내용</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    </div>
    <br>
    <div id=pageBox2></div>
  </div>
    <div id=Dig>
    </div>
    <div id=ynDig style="display:none;">
    	 <table>
    		<tr>
        	    <td>회원번호<input type=number id=member_seq value="${member_seq}" readonly></td>
        	</tr>
    	  	<tr>
        	    <td>주문번호<input type=number id=o_seq readonly></td>
        	</tr>
       		 <tr>
        	    <td>평점<br><input type=number id=review_rate max=5 min=1 value=5></td>
        	</tr>
       		<tr>
         	   <td>내용<br><textarea id=review_content maxlength="40" style="width:300px; height:250px;" placeholder="최대40자"></textarea></td>
       		 </tr>
    	</table>
    </div>
    <div id=udig>
    </div>
    <div id=dig style=display:none;>
    	 <table>
    		 <tr>
        	    <td>
        	    	리뷰번호<input type=number id=review_seq readonly>
        	    	<input type=hidden id=order_seq readonly>
        	    </td>
        	</tr>
    		<tr>
        	    <td>제품이름<input type=text id=pname readonly></td>
        	</tr>
    	  	<tr>
        	    <td>평점<br><input type=number id=U_rate max=5 min=1></td>
        	</tr>
       		<tr>
         	   <td>내용<br><textarea id=U_content maxlength="40"  style="width:300px; height:250px;"></textarea></td>
       		 </tr>
    	</table>
    </div>
</section>
<%@ include file="./parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
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
$(document)
.ready(function(){
	loadReviewY(1)
	loadReviewDone(1)
})
.on('click', '#pageBox div', function(){
   let pageNum = $(this).text();
   console.log(pageNum);
   loadReviewY(pageNum);
})
.on('click', '#pageBox2 div', function(){
   let pageNum2 = $(this).text();
   console.log(pageNum2);
   loadReviewDone(pageNum2);
})
.on('click','#tblPost tbody tr',function(){//테이블 클릭시 주문번호 인풋 
	order_seq = $(this).find('td:eq(0)').find('input').val();
	prod_id = $(this).find('td:eq(1)').text();
// 	alert(seq)
	showDig(order_seq, prod_id)
})
.on('click','#tbldone tbody tr',function(){ //테이블 클릭시 리뷰번호 인풋
	r_seq = $(this).find('td:eq(1)').text();
	o_seq = $(this).find('td:eq(0) input').val();
	pname = $(this).find('td:eq(2)').text();
	r_rate = $(this).find('td:eq(4)').text();
	r_content = $(this).find('td:eq(5)').text();
	update_review(r_seq,o_seq,pname,r_rate,r_content)
})
function showDig(order_seq, prod_id){//작성가능한 리뷰 선택시 선택창 다이얼로그 함수
	$('#o_seq').val(order_seq)
	$('#Dig').dialog({
		'title':'선택창',
		modal:true,
		buttons:[
			{
				text:'리뷰작성',
				click:function(){
					showRiview(prod_id)
				}
			},
			{
				text:'상품보기',
				click:function(){
// 					let seq=$('#tblPost tr:gt(0)').closest('tr').find('input[name="a"]').val()
					document.location='/goods_info/'+prod_id;
				}
			}
		]
	})
}
function showRiview(){//리뷰작성 다이얼로그 함수 
	$('#ynDig').dialog({
		'title':'리뷰-^-^-작성',
		modal:true,
		width:350,
		height:550,
		buttons:[
			{
				text:'완료',
				click:function(){
					$.ajax({url:'/insert_review',
							dataType:'text',
							type:'post',
							data:{order_seq:$('#o_seq').val(),
									member_seq:$('#member_seq').val(),
									prod_id:prod_id,
									review_rate:$('#review_rate').val(),
									review_content:$('#review_content').val()},
							beforeSend:function(){
								console.log($('#o_seq').val())
							},
							success:function(data){
								if(data=='ok'){
									location.href ='/review'
								}else{
									alert('실패')
								}
							}})
				}
			}
		]
	})
}
function loadReviewDone(pageNum2){//작성한 리뷰 목록
	$.ajax({url:'/select_reviewDone',
		type:'post',
		dataType:'json',
		data:{member_id:$('#id_insert').val(),pageNum:pageNum2},
		beforeSend:function(){
			console.log($('#id_insert').val())
		},
		success:function(data){
			$("#tbldone tr:gt(0)").remove();
			$("#pageBox2").empty();
			for(let i=0; i<data.length; i++){
				let re=data[i]
					let str='<tr>'
					str+='<td>'+i+'<input type=hidden name=order_id value='+re['order_id']+'></td>'
					str+='<td>'+re['review_seq']+'</td>'
					str+='<td>'+re['prod_name']+'</td>'
					str+='<td><img src='+re['prod_img']+' style="width:40px;height:40px"></td>'
					str+='<td>'+re['review_rate']+'</td>'
					str+='<td><div name=review_content>'+re['review_content']+'</div></td></tr>'
					
					$('#tbldone').append(str)
				
			}
			let total = data[0]['totalPage'];
			for(i=1; i<=total; i++){
	        	let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
	            $("#pageBox2").append(str);
	        }
		}
	})
}
function loadReviewY(pageNum){//리뷰가능한 목록 불러오는거 
	$.ajax({url:'/select_reviewY',
		type:'post',
		dataType:'json',
		data:{member_id:$('#id_insert').val(), pageNum:pageNum},
		beforeSend:function(){
			console.log($('#id_insert').val())
		},
		success:function(data){
			console.log(data);
			$("#tblPost tr:gt(0)").remove();
			$("#pageBox").empty();
			
			
			for(let i=0; i<data.length; i++){
				
				oid = data[i].oid;
				pid = data[i].pid
				pname = data[i].pname
				pimg = data[i].pimg
				lastorder = data[i].lastorder
				
				let str='<tr>';
				str+='<td>'+i+'<input name=order_seq type=hidden value='+ oid +' readonly></td>'
				str+='<td>'+pid+'</td>';
				str+='<td><img src="'+pimg+'" style="max-width: 40px; max-height: 40px;">	</td>';
				str+='<td>'+pname+'</td>';
				str+='<td>'+lastorder+'</td></tr>';
				
				$('#tblPost').append(str);
			}
			let total = data[0]['totalPage'];
			for(i=1; i<=total; i++){
	        	let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
	            $("#pageBox").append(str);
	        }
			
		}})
}
function update_review(r_seq,o_seq,pname,r_rate,r_content){ //작성한 리뷰 목록 클릭시 리뷰 수정,삭제 다이얼로그 함수
	$('#review_seq').val(r_seq)
	$('#order_seq').val(o_seq)
	$('#pname').val(pname)
	$('#U_rate').val(r_rate)
	$('#U_content').val(r_content)
	$('#dig').dialog({
		'title':'리뷰수정',
		modal:true,
		width:350,
		height:550,
		buttons:[
			{
				text:'리뷰수정',
				click:function(){
					$.ajax({url:'/update_review',
							type:'post',
							dataType:'text',
							data:{review_content:$('#U_content').val(),
								  review_rate:$('#U_rate').val(),
								  review_seq:$('#review_seq').val()},
							beforeSend:function(){
								console.log($('#review_seq').val())
								console.log($('#U_rate').val())
								console.log($('#U_content').val())
							},
							success:function(data){
								if(data=='ok'){
									location.href ='/review'
								}else{
									alert('실패')
								}
							}})
				}
			},{
				text:'리뷰삭제',
				click:function(){
					$.ajax({url:'/delete_review',
						type:'post',
						dataType:'text',
						data:{order_id:$('#order_seq').val(),
							  review_seq:$('#review_seq').val()},
						success:function(data){
							if(data=='ok'){
								location.href ='/review'
							}else{
								alert('실패')
							}
						}})

				}	
			}
		]
	})
}
</script>
</html>