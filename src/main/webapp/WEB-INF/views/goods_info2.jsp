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
    <title>home</title>
</head>
<style>
#header{
     width: 100%; text-align: center; margin: 0 auto;
     margin-bottom: 20px; margin-top:10px;min-width:1000px;
}
#nav label{margin:50px}
#nav{
     width: 100%; outline: dashed 1px blue; text-align: center; margin: 0 auto;
     line-height:50px; font-size:20px; font-weight:bold;
     min-width:1000px;
}
 
#aside{
     height: 600px; width: 19%; outline: dashed 1px green; text-align: center;
     float: left ; margin-top: 110px; position:fixed;
} 
#section{
     height: 100% width: 100%; outline: dashed 1px purple; text-align: center; margin-bottom: 15px;
     min-height:900px;position:relative; min-width:1000px; margin-top:23px
}
#footer{
     height: 150px; width: 800px; outline: dashed 1px red; text-align: center; 
     margin: 0 auto; position:relative
}
.footerdiv{display:inline-block;position:absolute}
.homeMenu{text-decoration-line:none}
#allItems{display:inline-block;position:relative;}
.category{display:none;position:absolute;z-index:1;}
.category a{display:block}
#allItems:hover .category{
	display:block;
}

#bestItems{position:relative;top:50px; width:100%; min-width:1000px;text-align:center }
#newItems{position:relative;top:50px; width:100%; min-width:1000px;text-align:center;margin-top:100px }
.item{border:1px solid green; width:200px; height:230px; display:inline-block;}
.item img{width:170px;height:170px}

a{text-decoration-line:none; font-weight:bold;color:black}

#prod_image{display:inline-block; border:1px solid black; 
	
}
#prod_details{display:inline-block; border:1px solid blue;

}
#prod_details span{}
.a{display:inline}

#goods_info{text-align:left;width:100%;height:400;border:1px solid green}
table{border-collapse:collapse;}

</style>
<body>

<!--  //////////////////////////////////////// header /////////////////////////////////////////////// -->
<div id="header"><label id="logo"><a href="/home"><img src="/img/logo.png"></a></label></div>

<div id="nav">
	
	<label>
	<div id=allItems>
		<a href="/goods_list" class="homeMenu">전체상품</a>
		<div class="category">
			<a href="/goods_list_kitchen" class="homeMenu">주방가전</a>
			<a href="/goods_list_home" class="homeMenu">생활가전</a>
			<a href="/goods_list_season" class="homeMenu">계절가전</a>
		</div>
	</div>
	</label>
	
	<label><a href="/goods_list_best" class="homeMenu">베스트상품</a></label>
	<label><a href="/goods_list_new" class="homeMenu">신상품</a></label>
	<label><a href="/customer_service" class="homeMenu">고객문의</a></label>
	<!--  이거 나중에 글자말고 img 로 바꾸면 밀려도 안짤림 -->
	<label>
		<a href="/cart"><img src="/img/cart.png"  style='width:25x;height:20px'></a> &nbsp;
		<a href="/login"><img src="/img/login.png"  style='width:25px;height:20px'></a>	&nbsp;
		<a href="/signin"><img src="/img/signup.png"  style='width:25px;height:20px'></a>
	</label>
</div>


<!-- ////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<!--  ////////////////////////////////////////// body //////////////////////////////////////////////////// -->
<div id="section">	


		<form action="/toOrder" method="post">
		<table border=1 style="position:absolute; left:200px; top:100px;">
			<tr>
				<td><img src="${product.prod_image}" style="width:350px;height:350px"></td> 
				<td>
					<table id="goods_info">
						<tr><td>제품번호</td><td><input name=prod_id type=number value="${product.prod_id}" readonly></td></tr>
						<tr><td>이름</td><td><input name=prod_name type=text value="${product.prod_name}" readonly></td></tr>
						<tr><td>가격</td><td><input id=prod_price name=prod_price type="number" value="${product.prod_price}" readonly></td></tr>
						<tr><td>구매수량</td> <td><input id=qty name=qty type=number>개</td></tr>		
						<tr><td>총상품금액</td> <td><input id=sum name=sum type=number readonly>원</td></tr>	
						<tr>
							<td colspan=2>
								<button id="putIntoCart">장바구니에 추가</button>
								<input type="submit" value="구매하기">
							</td>
						</tr>			
					</table>
				</td>			
			</tr>
		</table>
		</form>
		
		
		
		<div>
			<div>제품상세</div>
			<div>${product.prod_desc}</div>
		</div>
		
		
		<div>
			<table id="reviewBox" style="margin:0 auto;border-collapse:collapse;border:1px solid blue">
				<tr><td colspan=3>리뷰</td></tr>
				<tr>
					<td>글쓴이</td> <td>평점</td> <td>내용</td>
					<c:forEach var="review" items="${reviews}">
						<tr><td>${review.mid}</td>  <td><label name=star>${review.review_rate}</label></td> <td>${review.review_content}</td> </tr>
					</c:forEach>
				</tr>
			</table>
		</div>
		
</div>

				
<!-- ////////////////////////////////////////// body ///////////////////////////////////////////////////// -->

<!--////////////////////////////////////////// footer ////////////////////////////////////////////////////-->
<div id="footer">
	<div class=footerdiv style="text-align:left;left:0;top:20px">
	대표 : xxx<br>
	사업자등록번호:111-11-11111<br>
	주소 : 부산 광역시 동래구 온천동 10000-1<br>
	전화번호 : 02-1111-1111<br>
	고객센터 번호 : 1588-1111<br>
	</div> 
	
	<div class=footerdiv style="text-align:left;right:0;bottom:40px">
	본 사이트의 컨텐츠는 저작권법의 보호를 받는 바 <br>
	무단 전재, 복사, 배포 등을 금합니다.
	</div>
</div>


</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	for(var i=0;i<$('label[name=star]').length;i++){
		
		number = $('label[name=star]').eq(i).text();
		str = '';
		for(var j=0;j<number;j++){
			str = str + '★';
		}
		$('label[name=star]').eq(i).text(str)
	}
})
.on('input','#qty',function(){
	price = parseInt( $('#prod_price').val() );
	qty = parseInt( $('#qty').val() );
	
	sum = price*qty
	$('#sum').val(sum);
})
.on('click','#putIntoCart',function(){
	return false;
})



</script>
</html>

