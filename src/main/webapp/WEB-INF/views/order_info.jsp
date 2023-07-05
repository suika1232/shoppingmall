<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<title>Title</title>
</head>
<style>
table{border:1px solid green;border-collapse:collapse;}
td{border:1px solid rgb(235, 219, 219)}
th{border:1px solid rgb(235, 219, 219)}
#orderForm{}
#customerTable{width:100%;height:100%}
#orderAddress{width:100%;height:100%}
#paymentInfo{width:100%;height:100%}
#receipt{width:100%;height:100%;}
textarea[name=order_request]{height:80px}
 textarea {
    width: 90%;
    height: 90%
    border: 1px solid gray;
    resize: none;
}
#goback{width:120px;height:45px;background-color:black;color:white;
border-radius:10% 10% 10% 10%; font-size:15px}
#decision{width:120px;height:80px;font-size:20px;font-weight:bold}
</style>
<body>

<section>
<div id="section">	

<form action="/addOrder" method="post" id="fmt"><br><br>
<table id=orderForm>
<tr> <th colspan=5 style="background-color:black;color:white"><h1>주문서</h1></th> </tr>
	<tr>	
			<th><h2>상품코드</h2></th> 
			<th><h2>상품이름</h2></th> 
			<th><h2>상품사진</h2></th> 
			<th><h2>상품수량</h2></th > 
			<th><h2>상품금액</h2></th>	
	</tr>
	<tr style="text-align:center">
			<td><h3>${product.prod_id}</h3></td>
			<td><h3>${product.prod_name}</h3></td>
			<td><img src="${product.prod_image}" style="width:80px;height:80px"></td>
			<td><h3>${order.order_qty}</h3></td>
			<td><h3>${order.order_price}</h3></td>
	</tr>
	
	
	
	<tr>
		<td colspan=5>
			<table id="customerTable">
				<tr><td colspan=2 style="text-align:left"><h1>주문자 정보</h1></td></tr>
				<tr><td>보내는분</td>	<td> ${member.member_name} </td></tr>
				<tr><td>휴대폰</td>	<td> ${member.member_mobile} </td></tr>
				<tr><td>이메일</td>	<td> ${member.member_email} </td></tr>
			</table>
		</td>
	</tr>
	
	
	
	<tr>
		<td colspan=5>	
			<table id="orderAddress">
				<tr><td colspan=3 style="text-align:left"><h1>배송정보</h1></td></tr>
				<tr> 
					 <td rowspan=2>배송주소</td> <td><input name=part1 type="text" id="sample6_postcode" placeholder="우편번호" readonly value="${part1}"></td> 
					 <td></td> 
				</tr>
				<tr> 						  
					<td><input type="text" name=part2 id="sample6_address" placeholder="주소" readonly value="${part2}"></td> 
					<td>
						<input type="text" name=part3 id="sample6_detailAddress" placeholder="상세주소" readonly value="${part3}">
						<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
					</td> 
				</tr>
				
				<tr> <td  colspan=2>수령인 이름</td> <td><input name=order_recipient type=text readonly value="${order.order_recipient}"></td>  </tr>
				<tr> <td  colspan=2>휴대폰 </td> <td><input name=order_mobile type=text readonly  value="${order.order_recipient_mobile}"></td>  </tr>
				<tr> <td  colspan=2>배송요청사항</td> <td><textarea name=order_request readonly>${order.order_request}</textarea></td>  </tr>
				<tr> <td colspan=3>결제방식 : ${order.order_payment}</td>	</tr>
				<tr> <td colspan=3 style="text-align:center;height:50px"><button id=goback>주문관리로<br>돌아가기</button></td>	</tr>
			</table>
		</td>
	</tr>
	

	
	
</table>	

</form>		

</div><br><br>

</section>


</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document)
.on('click','#goback',function(){
	document.location = "/manager_order";
	return false;
})
</script>
</html>
