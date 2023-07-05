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
<title>Insert title here</title>
<%@ include file="./parts/form_css.jsp" %>
</head>
<style>
.section{
	 padding-bottom:15%;
	 background-color:white;
	 display:flex;	
 	 outline-style:solid;
 	 outline-width:thin;
 	 outline-color:gray;
 	 text-align:center;
}
table {
  top:100px;
  border-collapse: collapse;
  max-width: 400px;
  margin: 0 auto;
  font-family: Arial, sans-serif;
  font-weight:bold;
  font-size: 14px;
  line-height: 1.5;
  position:relative;
 
}
table td {
  padding: 10px;
  border: 1px solid #ccc;
}
table td input{
  font-size: 17px;
  font-weight:bold;
}
input[type=text], input[type=password] {
  width: 100%;
  padding: 8px;
  border-radius: 4px;
  border: 1px solid #ccc;
  box-sizing: border-box;
  margin-bottom: 10px;
}

input[type=text]:focus, input[type=password]:focus {
  border: 2px solid #008CBA;
}

button{
  background-color: #4CAF50;
  border: none;
  color: #fff;
  padding: 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 4px;
}

button#btnselect {
  background-color: #413543;
}

button#btn_update {
  background-color: black;
}

button#btn_cancel {
  background-color: black;
}

input[type=text]:invalid {
  	border: 2px solid #413543;
}

input[type=text]:valid {
 	 border: 2px solid #635985;
}
.jh{
	float:left;
	background-color:white;
	font-size:20px;
	position: sticky;
	width: 180px;
	top: 150px;
	left: 20px;
	margin-right:30px
}
.myPageTitle{
	font-size:20px;
	font-weight:bold;
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
section a{
	text-decoration-line:none;
 	font-weight:bold;color:black
 }
</style>
<body>
<%@ include file="./parts/head.jsp" %>
	<%String id=(String)session.getAttribute("member_id"); %>
	<input type=hidden id=memberIDs value=<%=id%>>
<section>
	<div class=jh>
		<span class="myPageTitle">My Page</span><br><br>
				
		<span class=myMenu><img src="/img/myinfo.png"><a href="/member_update">MyInfo</a></span><br><br>
		<span class=myMenu><img src="/img/order_icon.png"><a href="/order_list">OrderList</a></span><br><br>
		<span class=myMenu><img src="/img/review.png"><a href="/review">Reviews</a></span>
	</div>
	<br>
	<div class=section>
			
		<table style="text-align:left">
			<tr><td style="text-align:center"><h2>내 정보 수정하기</h2></td></tr>
			<tr><td>회원 아이디<input type= text id=memberID readonly></td></tr>
			<tr><td>비밀번호 <input type= text id=memberPW></td></tr>
			<tr><td>이름<input type= text id=memberNM></td></tr>
			<tr><td>모바일 <input type= text id=memberMB pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required></td></tr>
			<tr><td>이메일 <input type= text id=memberEM></td></tr>
			<tr><td>주소<br> <input type="text" id="postcode" placeholder="우편번호">
						<input type="text" id="address" placeholder="주소"><br><br>
						<input type="text" id="detailAddress" placeholder="상세주소"><br>
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td></tr>
			<tr><td style="text-align:center;"><button id=btn_update>수정완료</button></td></tr>
		</table>
	</div>
</section>
<%@ include file="./parts/foot.jsp" %>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
	select_member()
})
.on("focusout","#memberPW",function(){
   chekPassword()
   
   console.log('asd')
})
.on("focusout", "#memberEM", function(){
	var emailVal = $(this).val();
	var regExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
	if (emailVal.match(regExp) != null) {
	 return;
	}else{
	 alert('올바른 이메일 형식이 아닙니다.');
	 $("#memberEM").val("") 
	 return false;
	}
})
.on('click','#btn_update',function(){
	alert('asd')
	if($('#memberID').val() && $('#memberPW').val() && $('#memberNM').val() && $('#memberMB').val() && $('#memberEM').val()){
		alert('asd')
		$.ajax({url:'/update_member',
			type:'post',
			dataType:'text',
			data:{uid:$('#memberID').val(),
				  upw:$('#memberPW').val(),
				  unm:$('#memberNM').val(),
				  umb:$('#memberMB').val(),
				  uem:$('#memberEM').val(),
				  upc:$('#postcode').val(),
				  uad:$('#address').val(),
				  udad:$('#detailAddress').val()},
			beforeSend:function(){
				console.log($('#memberID').val())
			},
			success:function(data){
					if(data=='ok'){
						alert('성공')
					}else{
 						alert('update 실패')
 					}	
			}})
	}else{
		alert('빈 값이 존재합니다')
	}
	
})
function select_member(){
	$.ajax({url:'/select_member',
		type:'post',
		dataType:'json',
		data:{memberID:$('#memberIDs').val()},
		success:function(data){
			for(let i=0; i<data.length; i++){
					let info=data[i]
					$('#memberID').val(info['member_id'])
					$('#memberPW').val(info['member_pw'])
					$('#memberNM').val(info['member_name'])
					$('#memberMB').val(info['member_mobile'])
					$('#memberEM').val(info['member_email'])
					let ad=info['member_address']
					ad=ad.split(',')
					$('#postcode').val(ad[0])
					$('#address').val(ad[1])
					$('#detailAddress').val(ad[2])
			}	
		}})
}
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
               
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
function chekPassword(){

	   var mbrPwd = $("#memberPW").val();  // pw 입력

	   var check1 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{10,12}$/.test(mbrPwd);  //영문,특수문자

	   var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{10,12}$/.test(mbrPwd);  //특수문자, 숫자

	   if(!(check1||check3)){

	      alert("사용할 수 없은 조합입니다.\n패스워드 설정안내를 확인해 주세요.");

	      return false;

	   }

	   if(/(\w)\1\1/.test(mbrPwd)){

	      alert('같은 문자를 3번 이상 사용하실 수 없습니다.\n패스워드 설정안내를 확인해 주세요.');

	      return false;

	   }

	   if(mbrPwd.search(mbrId)>-1){

	      alert("비밀번호에 아이디가 포함되었습니다.\n패스워드 설정안내를 확인해 주세요.");

	      return false;

	   }

	   return true;

	}
</script>
</html>