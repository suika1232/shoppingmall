<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page session="true" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <title>Login</title>
</head>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
}
#login {
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
#loginid {
   background-image: url('/img/user.png');
   background-repeat:no-repeat;
   background-position:2% 50%;
   background-size: 22px 22px;
   text-indent: 25px;
}
#password {
   background-image: url('/img/locked.png');
   background-repeat:no-repeat;
   background-position:2% 50%;
   background-size: 22px 22px;
   text-indent: 25px;
}
#name {
   background-image: url('/img/user1.png');
   background-repeat:no-repeat;
   background-position:2% 50%;
   background-size: 22px 22px;
   text-indent: 25px;
}
#mobile {
   background-image: url('/img/mobile.png');
   background-repeat:no-repeat;
   background-position:2% 50%;
   background-size: 22px 22px;
   text-indent: 25px;
}
#email {
   background-image: url('/img/email.png');
   background-repeat:no-repeat;
   background-position:2% 50%;
   background-size: 21px 21px;
   text-indent: 25px;
}
label {
  margin-bottom: 5px; 
  color: #596E79;
}
input[type="text"], input[type="password"], input[type="email"] {
  padding: 12px;
  border: none;
  border-radius: 5px;
  background-color: white;
}
input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
  outline: none;
  box-shadow: 0 0 5px #C7B198;
}
button {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  background-color: black;
  color: white;
  cursor: pointer;
}
button:hover {
  background-color: #6C849F;
}
#btnLogin {
  margin-right: 10px;
}
a {
  text-decoration: none;
  color: #596E79;
}
#idFind {
  cursor: pointer;
}
#idFind:hover {
  font-weight: bold;
}
#signin:hover {
  font-weight: bold;
}
/* modal */
#findDlg {
  display: none;
  padding: 20px;
  background-color: #abc4db;
  border-radius: 10px;
}
.ui-dialog-titlebar {
  text-align: center;
  color: #596E79;
  padding: 14px;
  border: none;
}
.ui-dialog-titlebar-close {
  background-color: #abc4db;
  position: absolute;
  opacity: 0.4;
  right: 0;
  color: white;
}
.ui-dialog-content {
  font-size: 14px;
}
#result {
  font-size: 16px;
  font-weight: bold;
  color: #596E79;
}
#btnFind, #findCancel {
  margin-right: 10px;
}
.aa {
  text-align: center;
}
.bb {
  text-align: right;
}
.logo {
  text-align: center;
}
</style>

<body>
<div class="logo">
<a href="/home"><img src="/img/Digital Oasis-logo-black.png" style="width:50%;height:50%"></a>
</div>
<div id="login">
<form method="post" action="/doLogin" id=dologin>
        <div class="inputInfo"><input type="text" id="loginid" name="loginid" placeholder="Userid" autocomplete="off" required></div><br>
        <div class="inputInfo"><input type="password" id="password" name="password" placeholder="Password" autocomplete="off" required></div>
        <div class="aa"><button id="btnLogin">로그인</button>&nbsp;<button id="btnCancel">취소</button></div><br>
        <div class="bb"><label id=idFind>아이디 찾기</label>&nbsp <a href="/signin" id="signin">회원가입</a></div>
    </form>   
</div>

<div id="findDlg" style="display:none;">
   <div class="inputInfo"><input type="text" id="name" name="name" placeholder="Username" autocomplete="off" required></div>
    <div class="inputInfo"><input type="text" id="mobile" name="mobile" placeholder="Mobile" autocomplete="off" required></div>
    <div class="inputInfo"><input type="email" id="email"name="email" placeholder="Email" autocomplete="off" required></div><br>
   <span id="result"></span><br><br>
   <div class="aa"><button id="btnFind">찾기</button><button id="findCancel">취소</button></div>   
</div>    
</body>
<script src ="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
   if('${errorMessage1}'!='') alert('${errorMessage1}');
})

.on('click','#btnCancel',function(){
   document.location = "/home";
   return false;
})

.on('click','#idFind',function(){
    $('#findDlg').dialog({
        'beforeClose':function(e,u){
         $('#name').val('');               
             $('#mobile').val('');
             $('#email').val('');
    },
        title:'아이디 찾기',
        closeText: "X",
        modal:true,
        width:'500px'
    });
})

.on('click','#btnFind',function(){
    if ($('#name').val() != ''&& $('#mobile').val() != '' && $('#email').val() != '') {
      $.ajax({type:'post',url:'/idFind',dataType: 'text',
            data: {name:$('#name').val(),mobile:$('#mobile').val(),email:$('#email').val()},
               success: function(result) {
                   if (result !='') {
                      console.log(''+result+'');
                       $('#result').text('고객님의 아이디는 '+result+' 입니다.');
                   } else {
                       $('#result').text('정보와 일치하는 회원이 없습니다.');
                   }
               },      
           });
                  
       } else {
           $('#name').focus();
       }               
   })
   
.on('click','#findCancel',function(){
   document.location = "/login";
})   
</script>
</html>