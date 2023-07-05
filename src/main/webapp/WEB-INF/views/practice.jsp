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
<title>Home</title>
</head>
<body>
HOME


<hr>
주소
<br>
<input type="text" id="sample4_postcode" placeholder="우편번호" readonly>
<input type="button" value="우편번호 찾기" id="search_address" readonly><br>
<input type="text" id="sample4_roadAddress" placeholder="도로명주소" readonly>
<input type="text" id="sample4_jibunAddress" placeholder="지번주소" readonly>
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="sample4_detailAddress" placeholder="상세주소">
<input type="text" id="sample4_extraAddress" placeholder="참고항목">

<hr>
이미지 client->server 로 전송(이건 나중에, 관리자가 admin 일수도 있으니깐)

<form action="/imageTaker" method="post" enctype="multipart/form-data">	<%-- 파일업로드기능이 하나라도 있으면 써줘야함 enctype~ --%>
	<input type="file" name="file"><br>
	<!--  accept 하면 이미지파일만 받음 -->
	<input type="submit">
</form>

<hr>

server 에서 DB에 저장된 image address로 image 불러오기<br><br>

// 일단 그냥 이미지 출력하기
<div>
<img src="/img/airfrier1.jpg" style="width:200px;height:200px" id="airfrier1">	
</div>		
<br><br>
<!-- - 꼭 기억해두기!!!!!

	이미지 경로가 중요함.
	main-resources 의 static 에 img 라는 파일 만들고 거기에 이미지 넣어돔.
	그리고 이미지 경로는 /img/파일명.확장자 형태

 -->

// 이번엔 DB에 저장된 경로를 통해서 이미지 출력하기 

<div id="img">

</div>





</body>
<button id="one">1번이미지</button>
<button id="two">2번이미지</button>
<button id="three">3번이미지</button>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

  
$(document)
.on('click','#search_address',function(){

	sample4_execDaumPostcode();
	
})
.on('click','#one',function(){
	$.ajax({url:'/getImage',type:'post',data:{seq:'2'},dataType:'text',
		
		success:function(data){
			str = "<img src="+data+" style='width:200px;height:200px' id=af>"
			$('#img').append(str)
		}
	})
})
.on('click','#af',function(){
	alert('장바구니로이동(document.location)')
})


 function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
    
  
 
</script>
</html>