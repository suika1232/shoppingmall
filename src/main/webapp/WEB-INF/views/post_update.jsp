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
<title>POST_UPDATE</title>
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

select, input[type="text"], textarea {
   width: 98%;
   padding: 5px;
   margin-top: 5px;
   border: none;
   border-radius: 4px;
   border: 1px solid #C7BDB1;
}

input[type="submit"], input[type="button"] {
   text-decoration: none;
	padding: 8px;
   	border: none;
   	border-radius: 5px;
   	background-color: black;
   	color: white;
   	cursor: pointer;
}
input[type="submit"]:hover, input[type="button"]:hover {
	background-color: #DFD3C3;
	color:black;
}
</style>
<body>
<%@ include file="./parts/head.jsp" %>
	<table border=1>
		<tr>
			<td>카테고리</td>
			<td><select name=prod_category_code id=prod_category_code>
					<c:if
						test="${sessionScope.member_id != null && sessionScope.member_class == 'Manager'}">
						<option value=4>공지</option>
					</c:if>
					<c:if
						test="${sessionScope.member_id != null && sessionScope.member_class == 'User'}">
						<option value=1>주방가전</option>
						<option value=2>생활가전</option>
						<option value=3>계절가전</option>
					</c:if>
			</select></td>
		<tr>
		<tr>
			<td>제목</td>
			<td><input type=text name=title id=title value="${title}" required> 
				<c:if
					test="${sessionScope.member_id != null && sessionScope.member_class == 'Manager'}">
					<input type=hidden name=post_category id=post_category value="공지">
				</c:if> 
				<c:if
					test="${sessionScope.member_id != null && sessionScope.member_class == 'User'}">
					<input type=hidden name=post_category id=post_category value="문의">
				</c:if> 
				
				<input type=hidden name=post_seq id=post_seq value="${post_seq}"> 
				</td>
		<tr>
			<td>내용</td>
			<td><textarea name="summernote" id=summernote required>${summernote}</textarea></td>
		</tr>
		<tr>
			<td colspan=2 align=center><input type=submit value=수정 id=btnUpdate>&nbsp&nbsp&nbsp 
			<input type=button value=취소 id=btnCancel></td>
		</tr>
	</table>
</body>
<%@ include file="./parts/foot.jsp" %>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
<script>
//const textPattern = /(<([^>]+)>)/gi;
// str = str.replace(textPattern, "");
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
.on('click', '#btnCancel', function() {
		window.location.href = "/post";
		return false;
})

.on('click','#btnUpdate',function(){
	$.ajax({url:'/update_post',type:'post',
		dataType:'text',data:{prod_category_code:$('#prod_category_code').val(),title:$('#title').val(),
								summernote:$('#summernote').val(),post_seq:$('#post_seq').val()},
	  
		 	beforeSend:function(){
				if($('input[name=title]').val()=='' || $('input[name=content]').val()=='') {
			        alert('모든 항목을 작성해주세요.');
			        return false; 
					}
				}, 
			success:function(data){
					if(data=="ok"){
						document.location = "/post";
					} 
				}
		})
	})
				
		
.ready(function() {
	$('#summernote').summernote({
		  height: 400,                 
		  width: 1090,         
		  focus: true,                  
		  lang: "ko-KR",					
		  placeholder: '최대 2000자까지 쓸 수 있습니다', 
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
		  callbacks: {
	          onImageUpload: function(files, editor) {
					sendImg(files[0], this);
	            }
	      }
	 })			 
 });

function sendImg(file, el) {
    var form_data = new FormData();
    form_data.append('file', file); //폼데이터 형태로 바꾸기
    
    $.ajax({
      data: form_data,
      type: "POST",
      url: '/post_summernote_image',
      cache: false,
      contentType: false, //반드시 false, ajax에서 제공하는 거 죽이고 순수하게 폼 데이터만 넘어가게
      processData: false, // ''
      success: function(data) {
        $(el).summernote('editor.insertImage', data);
// 			let img = $("<img>");
// 			img.attr("src", data);
// 			$(".note-editable").append(img);
      }
    });
  }
	
	
</script>
</html>