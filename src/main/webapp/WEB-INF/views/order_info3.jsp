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
<%@ include file="./parts/form_css.jsp" %>
</head>
<style>
table{border:1px solid green;border-collapse:collapse;margin:0 auto;}
td{border:1px solid rgb(235, 219, 219)}
th{border:1px solid rgb(235, 219, 219)}
#orderForm{left:30%;top:5%;}
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
#decision{width:120px;height:80px;font-size:20px;font-weight:bold}
</style>
<body>
<%@ include file="./parts/head.jsp" %>

<section>
<div id="section">	

<form action="/addOrder" method="post" id="fmt"><br><br>
<table id=orderForm>
<tr> <th colspan=5><h1>주문서</h1></th> </tr>
	<tr>	
			<th><h2>상품코드</h2></th> 
			<th><h2>상품이름</h2></th> 
			<th><h2>상품사진</h2></th> 
			<th><h2>상품수량</h2></th > 
			<th><h2>상품금액</h2></th>	
	</tr>
	<tr>
			<td><h3>${prod_id}</h3></td>
			<td><h3>${prod_name}</h3></td>
			<td><img src="${prod_image}" style="width:80px;height:80px"></td>
			<td><h3>${order_qty}</h3></td>
			<td><h3>${order_price}</h3></td>
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
					 <td rowspan=2>배송주소</td> <td><input name=part1 type="text" id="sample6_postcode" placeholder="우편번호" value="${part1}" readonly></td> 
					 <td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td> 
				</tr>
				<tr> 						  
					<td><input type="text" name=part2 id="sample6_address" placeholder="주소" value="${part2}" readonly></td> 
					<td>
						<input type="text" name=part3 id="sample6_detailAddress" value="${part3}" placeholder="상세주소">
						<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
					</td> 
				</tr>
				
				<tr> <td  colspan=2>수령인 이름</td> <td><input name=order_recipient type=text></td>  </tr>
				<tr> <td  colspan=2>휴대폰 </td> <td><input name=order_mobile type=text></td>  </tr>
				<tr> <td  colspan=2>배송요청사항</td> <td><textarea name=order_request></textarea></td>  </tr>
			
			</table>
		</td>
	</tr>
	
	
	<tr>
		<td colspan=5>
			<table id="paymentInfo">	
			
				<tr>  <td style="text-align:left" colspan=3><h1>결제수단</h1></td>  </tr>
				<tr>  
					<td rowspan=2>일반결제</td> 
					<td>신용카드<input type=radio value='카드결제' name=payment></td> 
					<td>휴대폰<input type=radio value='모바일결제' name=payment></td>  
				</tr>
				<tr> <td colspan=2><div id=paymentSelect></div></td>  </tr>
				
				<tr>
					<td>간편결제</td> 
					<td colspan=2>네이버페이<input type=radio value='네이버페이' name=payment></td> 
				 </tr>
				 
			</table>	
		</td>
	</tr>

	
	<tr>
		<td colspan=5>
			<table id="receipt">
				<tr><th colspan=2><h1>결제금액</h1></th></tr>
				<tr>	<td>상품금액</td> <td>${order_price}원</td>	</tr>
				<tr>	<td>배송비</td> <td>0원</td>	</tr>
				<tr>	<td colspan=2>&nbsp;</td>	</tr>
				<tr>	<td>최종결제금액</td> <td>${order_price}원</td>	</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td colspan=5>
			&nbsp;
		</td>
	</tr>
	
	
	<tr>
		<td colspan=5>
			<input type="submit" value="결제하기" id="decision">
		</td>
	</tr>
	
	
</table>	
<input name=member_seq type="hidden" value="${member.member_seq}" >
<input name=prod_id type="hidden" value="${prod_id}">
<input name=order_qty type="hidden" value="${order_qty}">
<input name=order_price type="hidden" value="${order_price}">
</form>		

</div><br><br>

</section>

<%@ include file="./parts/foot.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function() {
    $(".main>li").mouseover(function() {
        $(this).children(".sub").stop().slideDown();
    });
    $(".main>li").mouseleave(function() {
        $(this).children(".sub").stop().slideUp();
    });
})
$(document)
.on('click','input[name=payment]',function(){
	way = $(this).val();
	$('#paymentSelect').empty();
	if(way =='카드결제'){
		str = '<select>'  +
					'<option>카드를 선택해주세요</option>' +
					'<option>농협</option>' +
					'<option>카카오뱅크</option>' +
					'<option>국민은행</option>' +
			  '</select>'; 
		$('#paymentSelect').append(str);
		
		str2 = '&nbsp;<select>'  +
					'<option>일시불</option>' +
					'<option>3개월할부</option>' +
					'<option>6개월할부</option>' +
					'<option>12개월할부</option>' +
			    '</select>'; 
		$('#paymentSelect').append(str2);
			
	} else if(way == '모바일결제'){
		
		str = '핸드폰 번호를 입력해주세요 : <input type=text>';
		$('#paymentSelect').append(str);	
	} 
})

.on('submit','#fmt',function(){
	if( $('[name=part1]').val()=='' ||
		$('[name=part2]').val()==''||
		$('[name=part3]').val()==''	){
		alert('주소를 모두 기입해주세요');
		return false;
	}
	
	if( $('[name=order_recipient]').val()==''||  
		$('[name=order_mobile]').val()==''	
		){
		alert('배송정보를 모두 기입해주세요');
		return false;
	}
		
	if( $('[name=payment]:checked').length==0  ){
		alert('결제수단을 선택해주세요');
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
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
    return false;
}
</script>
</html>