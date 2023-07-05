<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>summernote</title>
</head>
<body>
<textarea id="summernote"></textarea>
<button id="showcontent">내용보기</button>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
$(document)
.ready(function(){
// 	$("#summernote").("code",str) >> 문자열 삽입. 중요한건 초기화 전에 해야함
// 	$("#summernote").summernote(); // 초기화 
	setSummernote();
})
.on('click','#showcontent',function(){
	content = $('#summernote').val();
	alert(content);
})
function setSummernote(){
   $("#summernote").summernote({
        height: 350,
        width: 610,                 
        lang: "ko-KR",
        disableResizeEditor: true,
        placeholder: "제품의 상세정보를 입력하세요.",
        toolbar: [
             ['style', ['bold', 'italic', 'underline', 'clear']],
             ['font', ['strikethrough', 'superscript', 'subscript']],
             ['fontsize', ['fontsize']],
             ['color', ['color']],
             ['para', ['ul', 'ol', 'paragraph']],
             ['height', ['height']],
             ['image',['picture']]
        ]
   })
}

</script>
</html>