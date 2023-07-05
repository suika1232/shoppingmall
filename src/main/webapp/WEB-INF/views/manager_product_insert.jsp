<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/selectric/flat/selectric.css">
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	  rel="stylesheet">
<link rel="stylesheet" href="/css/manager/manager_product_insert.css">
<title>Manager - Product Insert/Update</title>
</head>
<body>
<% String member_class = (String)request.getAttribute("member_class"); %>
<% if(member_class.equals("Manager")){ %>
<div id="menuTitle">제품 등록</div>
<div id="prodInsertDiv">
<input type="hidden" id="prodId" value="${prod_id}">
<input type="hidden" id="flag" value="${updateFlag}">

<label for="prodCategory">카테고리</label>
<select id="prodCategory" class="prodInfobox"><option hidden="hidden" value="0">카테고리선택</option></select>

<label for="prodName">제품명</label>
<input type="text" id="prodName" autocomplete="off" class="prodInfobox">

<label for="prodCode">제품코드</label>
<input type="text" id="prodCode" autocomplete="off" class="prodInfobox">

<label for="prodPrice">판매가</label>
<input type="text" id="prodPrice" onkeyup="inputNumberFormat(this)" autocomplete="off" class="prodInfobox">

<label for="prodAmount">재고수량</label>
<input type="text" id="prodAmount" onkeyup="inputNumberFormat(this)" autocomplete="off" class="prodInfobox">

<label for="prodImgFile">제품이미지</label>
<div id="fileBorder" class="prodInfobox"><input type="file" accept="image/*" id="prodImgFile"></div>

<label for="prodDesc">제품상세</label>
</div>
<textarea id="prodDesc"></textarea>
<br>
<button type="button" id="btnProdInsert">등록</button>
<button type="button" id="btnProdInsertCancel">취소</button>
<% }else{ %>
	<%@include file="manager_error.jsp" %>
<% } %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/js/selectric/jquery.selectric.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/summernote-ko-KR.js"></script>
<script>
$(document)
.ready(function(){
	$("#prodCategory").selectric({
		inheritOriginalWidth: true
	})
	loadProdCategory();
	setSummernote();
})
.on("click", "#btnProdInsertCancel", function(){
	document.location="/manager_product";
})
.on("change", "#prodCategory", function(){
	console.log($("#prodCategory option:selected").val())
})
.on("click", "#btnProdInsert", function(){
	let category = $("#prodCategory option:selected").val();
	console.log("카테고리:"+category);
	let prodName = $("#prodName").val().trim();
	console.log("제품명:"+prodName);
	let prodCode = $("#prodCode").val().trim();
	console.log("제품코드:"+prodCode);
	let prodPrice = uncomma($("#prodPrice").val());
	console.log("판매가격:"+prodPrice);
	let prodQty = uncomma($("#prodAmount").val());
	console.log("재고수량:"+prodQty);
	let prodDesc = $("#prodDesc").summernote("code");
	console.log("제품상세:"+prodDesc);
	
	if(category==0||category==null){
		alert("카테고리를 선택하세요.");
		return false;
	}else if(prodName==""){
		alert("제품명을 입력하세요.");
		return false;
	}else if(prodCode==""){
		alert("제품코드를 입력하세요.");
		return false;
	}else if(prodPrice==""){
		alert("제품가격을 입력하세요.");
		return false;
	}else if(prodQty==""){
		alert("재고수량을 입력하세요.");
		return false;
	}else if(prodDesc==""||prodDesc==null){
		alert("상세설명을 입력하세요.");
		return false;
	}
	let fileCheck = $("#prodImgFile").val();
	if(!fileCheck){
		alert("제품 이미지를 등록해주세요.");
		return false;
	}
	if($("#prodId").val()==""){
		insertProduct(prodCode, category, prodName, prodPrice, prodDesc, prodQty);
		document.location="/manager_product";
		
	}else if($("#prodId").val()=="${prod_info.prod_id}"){
		updateProduct($("#prodId").val(), prodCode, category, prodName, prodPrice, prodDesc, prodQty);
		document.location="/manager_product";
	}
})
function inputNumberFormat(obj) {
     obj.value = comma(uncomma(obj.value));
}
function comma(str) {
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
function uncomma(str) {
     str = String(str);
     return str.replace(/[^\d]+/g, '');
}
function loadProdCategory(){
	$.ajax({url: "/loadProdCategory",
			type: "post",
			dataType: "json",
			success: function(data){
				$("#prodCategory option:gt(0)").remove();
				for(i=0; i<data.length; i++){
					let list = data[i];
					let str = "";
					if(list["category_code"]!="4"){
						str = "<option value="+list["category_code"]+">"+list["category_name"]+"</option>";
					}
					$("#prodCategory").append(str);
					$("#prodCategory").selectric("refresh");
				}
			},
			complete: function(){
				if($("#flag").val()=="y") loadProdInfo();
			}
	})
}
function insertProduct(code, category, name, price, desc, qty){
	let formData = new FormData();
	formData.append("imgFile", $("#prodImgFile")[0].files[0]);
	formData.append("code", code);
	formData.append("category", category);
	formData.append("name", name);
	formData.append("price", price);
	desc = desc.replace("tempPath", "imagePath");
	formData.append("desc", desc);
	formData.append("qty", qty);
	$.ajax({url: "/insertProduct",
			type: "post",
			dataType: "text",
			processData: false,
			contentType: false,
			data: formData,
			success: function(data){
				alert("제품등록:"+data);
			}
	})
}
function updateProduct(id, code, category, name, price, desc, qty){
	let formData = new FormData();
	formData.append("imgFile", $("#prodImgFile")[0].files[0]);
	formData.append("id", id);
	formData.append("code", code);
	formData.append("category", category);
	formData.append("name", name);
	formData.append("price", price);
	desc = desc.replace("tempPath", "imagePath");
	formData.append("desc", desc);
	formData.append("qty", qty);
	$.ajax({url: "/updateProduct",
			type: "post",
			dataType: "text",
			processData: false,
			contentType: false,
			data: formData,
			success: function(data){
				alert("제품수정:"+data);
			}
	})
}
function loadProdInfo(){
// 	$("#prodCategory").val("${prod_info.prod_category_code}").prop("selected", true);
	let category = "${prod_info.prod_category_code}";
	$("#prodCategory").prop('selectedIndex', category).selectric('refresh');
	$("#prodName").val("${prod_info.prod_name}");
	$("#prodCode").val("${prod_info.prod_code}");
	$("#prodPrice").val(comma("${prod_info.prod_price}"));
	$("#prodAmount").val(comma("${prod_info.prod_amount}"));
	$("#prodDesc").summernote("code", "${prod_info.prod_desc}");
}
function setSummernote(){
	$("#prodDesc").summernote({
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
		  ],
		  callbacks: {
			    onImageUpload: function(files, editor) {
			    	sendFile(files[0], this);
			    }
			  }
	})
}
function sendFile(file, editor){
	let formData = new FormData();
	formData.append("summerImg", file);
	$.ajax({url: "/summernote_img",
			type: "post",
			contentType: false,
			processData: false,
			enctype: "multipart/form-data",	
			data: formData,
			success: function(data){
				console.log(data);
// 				$(editor).summernote('editor.insertImage', resp);
				let imgNode = $("<img>");
				imgNode.attr("src", data);
				$(".note-editable").append(imgNode);
				
			}
	})
}
</script>
</html>