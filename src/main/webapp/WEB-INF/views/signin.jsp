<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <title>Signin</title>
</head>
 <style>
 body {
	font-family: 'Noto Sans KR', sans-serif;
}
/* wrapper */
#signin {
  margin: 0 auto;
  width: 400px;
  padding: 20px;
  background-color: #abc4db;
  border-radius: 10px;
}

/* input fields */
.inputInfo {
  display: flex;
  flex-direction: column;
  margin-bottom: 15px;
}
label {
  margin-bottom: 5px; 
  color: #596E79;
}
input[type="text"], input[type="password"], input[type="email"] {
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: white;
}
input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
  outline: none;
  box-shadow: 0 0 5px #C7B198;
}
input[type="button"], input[type="submit"], a.btn {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  background-color: black;
  color: white;
  cursor: pointer;
}
input[type="button"]:hover, input[type="submit"]:hover ,a.btn:hover{
  background-color: #6C849F;
}

/* address fields */
#postcode, #address, #detailAddress {
  margin-top: 10px;
  margin-bottom: 5px;
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: white;
}
#postcode:focus, #address:focus, #detailAddress:focus {
  outline: none;
  box-shadow: 0 0 5px #C7B198;
}

/* error message */
#errorMsg {
  color: red;
  margin-top: 10px;
}
a.btn {
  text-decoration: none;
  font-size: 13px;
}
.aa {
  text-align: center;
}
.logo {
  text-align: center;
}
 </style>
<body>
<div class="logo">
<a href="/home"><img src="/img/Digital Oasis-logo-black.png" style="width:50%;height:50%"></a>
</div>
<div id=signin> <!--required는 폼태그 안에서 사용 가능,ajax에선 사용 불가 -->
	<div class="inputInfo"><label>아이디</label>
		<input type="text" id="loginid" name="loginid" autocomplete="off">
		<input type="button" id="idChek" name="idChek" value="중복확인"><br>
		<span id="result"></span></div>		
    <div class="inputInfo"><label>비밀번호</label><input type="password" id="password" name="password" placeholder="숫자,특수문자포함 10자 이상 문자를 입력해주세요"></div>
    <div class="inputInfo"><label>비밀번호 확인</label><input type="password" id="confirm" name="confirm"></div>
    <div class="inputInfo"><label>이름</label><input type="text" id="name" name="name" autocomplete="off"></div>
    <div class="inputInfo"><label>모바일</label><input type="text" id="mobile" name="mobile" maxlength="11" autocomplete="off"></div>
    <div class="inputInfo"><label>이메일</label><input type="email" id="email"name="email" autocomplete="off"></div>
    <div class="inputInfo"><label>주소</label> 
    	<input type="text" name="postcode" id="postcode" placeholder="우편번호" autocomplete="off">
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" name="address" id="address" placeholder="주소" autocomplete="off"><br>
		<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" autocomplete="off">
	</div>
   
    <input type="hidden" id="class" name="class" value="User">
    
    <div class="aa"><input type=submit id=submit value='가입'>&nbsp
    <a href='/home' class="btn">가입취소</a>
    </div> 
</div>    
</body>

<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

$(document)
.on('click','#submit',function(){
	$.ajax({url:'/member_signin',type:'post',
		dataType:'text',data:{loginid:$('#loginid').val(),password:$('#password').val(),name:$('#name').val(),
							  mobile:$('#mobile').val(),email:$('#email').val(),class:$('#class').val(),
							  postcode:$('#postcode').val(),address:$('#address').val(),detailAddress:$('#detailAddress').val()},
	  
			beforeSend:function(){
				for(i=0; i<$("#signin input").length; i++){
					let iValue = $("#signin input:eq("+i+")").val();
					if(iValue.trim()=="") {
						console.log(iValue.trim());
						alert("모든 항목을 작성해주세요.");
						return false;
					}
				}
		
				},
			success:function(data){
					if(data=="ok"){
						document.location = "/login";
					} 
				}
		})
	})
.on('click','#idChek',function(){
	 if ($('#loginid').val() != '') {
		
		 $.ajax({type:'post',url:'/idChek',data: {loginid:$('#loginid').val()},dataType: 'text',
	            success: function(result) {
	                if (result == '0') {
	                    $('#result').text('사용 가능한 아이디입니다.');
	                    $("#result").css("color", "green");
	                } else {
	                    $('#result').text('이미 사용중인 아이디입니다.');
	                    $("#result").css("color", "red");
	                }
	            },		
	        });

	   				
	    } else {
	        $('#loginid').focus();
	    }
	   			
})
.on("focusout", "#email", function(){
	var emailVal = $(this).val();
	var regExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
	if (emailVal.match(regExp) != null) {
	 return;
	}else{
	 alert('올바른 이메일 형식이 아닙니다.');
	 $("#email").val("") 
	 return false;
	}
})
.on("focusout","#password",function(){
   chekPassword();
   $("#password").val("");
   return false;
})
.on("focusout", "#confirm", function(){
	if($('input[name=password]').val()!=$('input[name=confirm]').val()) {
        alert('비밀번호와 비밀번호 확인이 서로 다릅니다.');
        $("#confirm").val("");
        return false;
	}
})
function sample6_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var addr = ''; // 주소 변수

      // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
        addr = data.roadAddress;
      } else { // 사용자가 지번 주소를 선택했을 경우(J)
        addr = data.jibunAddress;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('postcode').value = data.zonecode;
      document.getElementById('address').value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.getElementById('detailAddress').focus();
    }
  }).open();
}
function chekPassword(){

	   var mbrPwd = $("#password").val();  // pw 입력

	   var check1 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{10,12}$/.test(mbrPwd);  //영문,특수문자

	   var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{10,12}$/.test(mbrPwd);  //특수문자, 숫자

	   if(!(check1||check3)){

	      alert("사용할 수 없는 조합입니다.\n패스워드 설정안내를 확인해 주세요.");

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