<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chatting</title>
</head>
<style>
#chattingBoard{width:500px;height:500px; border:1px solid green; resize:none;}
#id{width:90px;margin:0 auto; text-align:center}
#content{    
	width: 380px;
	height:30px;
    resize: none;
}
#commentbox{}

table{border-collapse:collapse;border:1px solid green}
</style>
<body>

<textarea id=chattingBoard readonly>

</textarea>

<br>

<div id=commentbox>
<input id=id type=text value="${member_id}" readonly> 
<input type=text id=content>
</div>

<br>
<div style="text-align:center">
<table style="text-align:left;margin:0 auto">
	<tr> <td colspan=2> <h3>쿠키생성</h3> </td>	</tr>
	<tr> <td>쿠키이름</td> <td><input type=text id=cookiename></td> </tr>
	<tr> <td>쿠키수명</td> <td><input type=number id=cookie_lifespan>분</td> </tr>
	<tr> <td colspan=2 style='text-align:right'> <button id=makeCookie> 내 쿠키 만들기 </button> </td>	</tr>
	
	<tr> <td colspan=2> <h3>내 쿠키</h3> </td>	</tr>
	<tr> <td>내 쿠키 이름 : </td> <td><input id=mycookiename readonly></td> </tr>
	<tr> <td>내 쿠키 수명 : </td> <td><input id=mycookie_lifespan readonly>초</td> </tr>
	<tr><td></td><td></td></tr>
</table>
</div>


</body><script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	loadchat();
})
.on('keyup','#content',function(){
	
	if(event.keyCode==13){
		
		id = $('#id').val();
		if(id==''){alert('로그인 먼저 해 주세요');return false;}
		content = $('#content').val();
		
		$.ajax({url:'/addChat', type:'post', dataType:'json', 
			
			data:{id:id, content:content},
			
			success:function(data){
					
				loadchat();
				$('#content').val('');

			}
		
		})
	}
	
})
.on('click','#makeCookie',function(){
		
	cookiename = $('#cookiename').val(); if(cookiename==''){alert('이름정해주세요');return false;}
	cookie_lifespan = $('#cookie_lifespan').val();
	
	$.ajax({url:'/makeCookie',type:'post', 
		
		data:{cookiename:cookiename, cookie_lifespan:cookie_lifespan},
		
		success:function(){
			
		}
	})
	
})

setInterval(function(){
	loadchat();
},1000)

function loadchat(){
	
	$.ajax({url:'/loadChat', type:'post', dataType:'json', 

		success:function(data){
			
			str = '';
			
			$('#chattingBoard').empty();
			
			for(var i=0;i<data.length;i++){
				id = data[i].id;
				content = data[i].content;
				
				
				str = str + id + " : " + content + "\n"
			}
			
			$('#chattingBoard').val(str)
		}
	
	})
	
}
// $('#content').keyup(function(){
// 	alert('bye')
// })
</script>
</html>





