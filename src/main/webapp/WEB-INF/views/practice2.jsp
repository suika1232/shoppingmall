<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="/css/summernote-0.8.18-dist/summernote-liste.css">
 <script src="/css/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
 <script src="/css/summernote-0.8.18-dist/summernote-lite.js"></script>
<title>파일업로드</title>
</head>
<body>

   <form action="/uploadImage" method="post" enctype="multipart/form-data">
     	  
           <h4>단일 파일 업로드</h4>
           <input type="file" name="file">
                   	
           <h4>다중 파일 업로드</h4>
           <input type="file" multiple="multiple" name="files">
			
	   <input type="submit"/>
	</form>




</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>


  
 
</script>
