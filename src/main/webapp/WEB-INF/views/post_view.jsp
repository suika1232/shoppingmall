<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ page session="true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<title>POST_VIEW</title>
<%@ include file="./parts/form_css.jsp" %>
</head>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
}
table {
   border: 1px solid black;
   width: 100%;
   margin: 10px;
   padding: 20px;
}

td {
   padding: 10px;
   border: 1px solid #C7BDB1;
}

input[type="text"], textarea {
   width: 98%;
   padding: 5px;
   margin-top: 5px;
   border: none;
   border-radius: 4px;
   border: 1px solid #C7BDB1;
   font-size: 16px;
}

input[type="submit"], input[type="button"] {
   padding: 10px;
   margin-top: 10px;
   border: none;
   border-radius: 4px;
   background-color: #dbc4a9;
   color: white;
   cursor: pointer;
}

/* Additional styling for the comment textarea */
textarea[name="comment"] {
   width: 98%;
   padding: 5px;
   margin-top: 5px;
   border: none;
   border-radius: 4px;
   height: 100px;
   background-color: #F5F5F5;
   resize: none; /* Prevents resizing of the textarea */
}

/* Styling for the buttons */
#btnComment, #deleteComment, #btnUpdate, #btnDelete, #btnList {
   text-decoration: none;
	padding: 8px;
   	border: none;
   	border-radius: 5px;
   	background-color: black;
   	color: white;
   	cursor: pointer;
}
#btnComment:hover, #deleteComment:hover, #btnUpdate:hover, #btnDelete:hover, #btnList:hover {
	background-color: #DFD3C3;
	color:black;
}
</style>
<body>
<%@ include file="./parts/head.jsp" %>
<form action="/doView" method="post">
<table border=1>
<tr><td>제목</td><td><input type=text name=title value="${board.post_title}" readonly>
<input type=hidden name=post_seq id=post_seq value="${board.post_seq}">
<input type=hidden name=prod_category_code id=prod_category_code value="${board.prod_category_code}">
<input type=hidden name=post_category id=post_category value="${board.post_category}">
<input type=hidden name=member_class id=member_class value="<%=session.getAttribute("member_class")%>"></td>
<tr><td>작성자</td><td><input type=text name=writer value="${board.member_id}" readonly>
<tr><td>내용</td><td><textarea name="summernote" id=summernote>${board.post_content}</textarea></td></tr>


<c:if
	test="${board.post_category !='공지' && sessionScope.member_class == 'User'}">
	<tr><td>관리자 답변</td><td><textarea name=comment id=comment placeholder='관리자의 답변을 기다려주세요' readonly>${board.post_comment}</textarea></td></tr>
</c:if>
<c:if
	test="${board.post_category !='공지' && sessionScope.member_class == 'Manager'}">
	<tr><td>관리자 답변</td><td style="text-align:right;"><textarea name=comment id=comment required>${board.post_comment}</textarea>
	<input type=submit value=관리자답변 id=btnComment>
	<input type=submit value=답변삭제 id=deleteComment></td></tr>
</c:if>


			<tr><td colspan=2 align=center>
	<div style="text-align:center;">
<c:if test="${board.member_id == sessionScope.member_id}"> 
        <input type=submit value=수정 id=btnUpdate>
        <input type=button value=삭제 id=btnDelete>   
</c:if>
		<input type=button value=목록보기 id=btnList> 
    </div>
</td></tr>	
</table>
</form>
</body>
<%@ include file="./parts/foot.jsp" %>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
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
var post_answer1 = '답변완료';
var post_answer2 = '답변대기';
var comment ='';
const textPattern = /(<([^>]+)>)/gi;
$(document)
.on('click','#btnList',function() {
	window.location.href = "/post";	
})
.on('click','#btnDelete',function() {
	let post_seq=$('#post_seq').val();
	document.location='/delete_post/'+post_seq;
})

.ready(function() {
	$('#summernote').summernote({
		  airMode: false,    //false면 툴바 보임
		  height: 400,      
		  width: 1090, 
		  focus: true,      
		  lang: "ko-KR",					
		  placeholder: '최대 2000자까지 쓸 수 있습니다'	,
		  toolbar: [
	             ['style', ['bold', 'italic', 'underline', 'clear']],
	             ['fontname', ['fontname']],
	             ['fontsize', ['fontsize']],
	             ['color', ['color']],
	             ['para', ['ul', 'ol', 'paragraph']],
	             ['height', ['height']],
	             ['image',['picture']]
	        ],
	        fontNames: 
	        	['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		  });
	$('#summernote').summernote('disable'); //써머노트 readonly
	
	
})

.on('click','#btnComment',function(){//답변작성&답변완료로~
	$.ajax({url:'/comment_upload',type:'post',
		dataType:'text',data:{post_answer1:post_answer1,comment:$('#comment').val(),post_seq:$('#post_seq').val()},		 	
			success:function(data){
					if(data=="ok"){	
						document.location = "/post";
					} 
				}
		})
	})
	
.on('click','#deleteComment',function(){//답변삭제&답변대기로~
	$.ajax({url:'/delete_comment',type:'post',
		dataType:'text',data:{post_answer2:post_answer2,comment:comment,post_seq:$('#post_seq').val()},		 	
			success:function(data){
					if(data=="ok"){						
						document.location = "/post";
					} 
				}
		})
	})


	
</script>
</html>