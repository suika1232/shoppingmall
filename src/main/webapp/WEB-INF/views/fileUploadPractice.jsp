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
     <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <title>Order_info</title>
</head>
<style>
</style>
<body>

<input id=prodImgFile type="file" accpet="image/*" multiple>
<button id="save">sending img data</button>
<hr>
<form>
  <input type="file" name="files" />
  <input type="submit" value="submit" />
<form>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.on('click','#save',function(){
	
	imageUpload();
	
})
function imageUpload(){
	   let formData = new FormData();
	   
	   for(var i=0;i<formData.length;i++){
		   formData.append("imgFile", $("#prodImgFile")[0].files[i]);
		   $.ajax({url: "/imgupload",
		         type: "post",
		         processData: false,
		         contentType: false,
		         data: formData,
		         success: function(data){
		            console.log("file upload:"+data);
		         },
		         error: function(error){
		            console.log(error);
		         }
		   })
	   }
	  
	   
	   
	
}

function imageUpload(id){
	   let formData = new FormData();
	   formData.append("imgFile", $("#prodImgFile")[0].files[0]);
	   formData.append("id",id);
	   $.ajax({url: "/imgupload",
	         type: "post",
	         processData: false,
	         contentType: false,
	         data: formData,
	         success: function(data){
	            console.log("file upload:"+data);
	         },
	         error: function(error){
	            console.log(error);
	         }
	   })
}
</script>
</html>
