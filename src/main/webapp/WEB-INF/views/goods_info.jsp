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
#title{font-size:30px;width:300px;height:50px;border:1px solid black;margin:0 auto;cursor:pointer}
#title:hover{color:gray;}
#goods_detail{margin:0 auto; border-collapse:collapse; border:1px solid black}
#goods_detail td{border:1px solid black}
#prod_name{background-color:black;color:white;width:600px;height:100px;font-size:50px;}
#prod_img{width:200px;height:360px;}
#prod_image{max-width:300px;max-height:460px;}
#prod_price{font-size:30px;font-weight:bold}
#order_count{font-size:30px;font-weight:bold}
#order_price{font-size:30px;font-weight:bold}
#order_qty{font-size:30px;font-weight:bold}
#intoCart{width:120px;height:40px;font-size:20px;font-weight:bold}
#purchase{width:120px;height:40px;font-size:20px;font-weight:bold}
#review_rate #stars{color:yellow;text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;}
#original{color:black;font-weight:bold}
#review_rate #nostar{color:gray;text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;}
#option{width:600px;height:500px;border-collapse:collapse;
		border:1px solid black; margin:0 auto; position:relative;
}
#option tr:first-child td{color:black;
	width:50%;height:40px;border:1px solid black; font-size:20px;
	cursor:pointer; border-bottom:0px;font-weight:bold;
}
#option tr:first-child td:hover{color:blue; font-size:23px;}
#desc{width:100%;height:100%;}
#reviews{width:100%;height:100%;}
#allreviews{border-collapse:collapse}
#allreviews th{border:1px solid rgb(229, 236, 238)}
#allreviews td{border:1px solid rgb(229, 236, 238)}
#reviewWrite{position:absolute;bottom:0px;border-collapse:collapse; 
			border:1px solid black; width:99.5%;
}
#reviewWrite th{text-align:center;}
#member_id{width:90%}
#review_content{    
	width: 100%;
	height:25px;
    resize: none;
}
#stars2 span:nth-child(1){float:left;margin-left:10px}
#stars2 span{float:left; font-size:20px}
span[name=filledstar]
{color:yellow;text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;font-weight:1;}
#stars2{}
span[name=star]{cursor:pointer;}

#pages{position:absolute;bottom:65px;width:100%;border-collapse:collapse;border:1px solid rgb(229, 236, 238)}
span[name=page]{cursor:pointer}
#member_id{text-align:center}
#leftover{color:red;font-size:13px}

</style>
<body>
<%@ include file="./parts/head.jsp" %>

<section>
<!-- 전체상품 출력 -->

<br><br><br>
<div style="text-align:center">
	<div id="title"><h3 style="margin:0 auto">Goods Info</h3></div>
</div>
<br><br>
<!-- 상품상세에 필요한것 : 

	제품아이디, 제품명, 제품이미지, 제품가격, 고를제품수량, 총합산가격, 
	리뷰출력칸, 별점선택, 리뷰작성칸, 장바구니버튼, 구매버튼


 -->
<input id="member_seq" type=hidden value="${member_seq}" readonly>
<input id="prod_id" type=hidden value="${product.prod_id}" readonly>
<input id="prod_amount" type=hidden value="${product.prod_amount}" readonly>
<div>
	<table id="goods_detail">
		<tr><td colspan=3 id="prod_name">${product.prod_name}</td></tr>
		<tr><td rowspan=6 id="prod_img"><img id="prod_image" src="${product.prod_image}"></td> <td><h3>상품평점</h3></td> <td><span id="review_rate">${review_rate}</span></td></tr>
		<tr>				<td><h3>가격</h3></td><td><span id="prod_price">${product.prod_price} won</span></td></tr>
		
		<tr> 			    
			<td>
				<h3>구매수량</h3></td><td><button id=minus>-</button>&nbsp;&nbsp;<span id="order_qty">1</span>&nbsp;개&nbsp;&nbsp;<button id=plus>+</button>
					${leftover}
			</td>
		</tr>
		<tr> 				<td><h3>총금액</h3></td><td><span id="order_price"> </span></td></tr>
		<tr> 						<td colspan=2><button id="intoCart">장바구니</button> &nbsp; <button id="purchase">구매</button></td></tr>
	</table>
	<br>
	<table id=option>
		<tr> <td id="descTable">상품설명</td> <td id=reviewTable>리뷰</td> </tr>					
		<tr>
			<td id="desc" colspan=2> 
				<span id="prod_desc">${product.prod_desc}</span> 
				<div id="reviews">
					<table id=allreviews style="width:100%">
						<tr id=reviewStart>
							<th style="width:17%">작성자</th>
							<th style="width:20%">평점</th> 
							<th>내용</th> 
							<th style="width:5%">기타</th> 
						</tr>
					</table>
					<br>
					
					<table id=pages border=1>
						<tr><th id=pageNums></th></tr>
					</table>
					<br>
					<table id=reviewWrite>
						<tr><th colspan=4>리뷰작성</th></tr>
						<tr>
							<th style="width:17%"><input id="member_id" type="text" value="${member_id}" readonly></th>
							<th style="width:23%" id="stars2">
								<span name='star'>☆</span>
								<span name='star'>☆</span>
								<span name='star'>☆</span>
								<span name='star'>☆</span>
								<span name='star'>☆</span>
							</th> 
							<th><textarea id="review_content" maxlength="40" placeholder='리뷰를 입력해주세요(최대40자)'></textarea></th> 
							<th style="width:10%"><button id=addReview>등록</button></th> 
						</tr>
					</table><br>
				</div>
			</td>
		</tr>	
	</table>
</div>

<br><br>
<table id="allGoods">

</table>

</section>

<%@ include file="./parts/foot.jsp" %>
</body><script src="https://code.jquery.com/jquery-latest.js"></script>
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
.ready(function(){
	refreshAll();
	
	// 매진시 버튼작동안하게.
	if( parseInt( $('#prod_amount').val()) <= 0 ){
		leftover_flag = 0;
		$('#order_qty').text(0);
		$('#order_qty').css('color','gray');
		$('button').prop('disabled',true);
		$('#addReview').prop('disabled',false);
	}
})
.on('click','button',function(){
	
})

.on('click','#minus',function(){
	order_qty = parseInt($('#order_qty').text())
	if(order_qty>1){
		order_qty = order_qty-1; 
		$('#order_qty').text(order_qty);
	} refreshPrice();	
})
.on('click','#plus',function(){
	
	prod_amount = parseInt( $('#prod_amount').val() );
	
	order_qty = parseInt($('#order_qty').text())
	if(order_qty<prod_amount){
		order_qty = order_qty+1; 
		$('#order_qty').text(order_qty);
	} else if(order_qty>=prod_amount){
		alert('남은 상품의 재고가 ' + prod_amount + '개 여서 더 이상 구매가 불가능합니다.')
	}
	
	refreshPrice();	
})

.on('click','#intoCart',function(){
		// 장바구니 logic
		member_seq = $('#member_seq').val();
		prod_id = $('#prod_id').val();
		order_qty = $('#order_qty').text();
		order_price = $('#order_price').text().replaceAll(",","").replace(" won", "");
	
// 		if(member_seq==''){alert('장바구니에 담으려면 로그인을 해야합니다');document.location="/login";return false;}
		if(member_seq==''){member_seq=-1}
		
		
		document.location = "/addCart/" + member_seq + "/" + prod_id + "/" + order_qty + 
						    "/" + order_price;
})
.on('click','#purchase',function(){
		// 구매 logic
		member_seq = $('#member_seq').val();
		prod_id = $('#prod_id').val();
		order_qty = $('#order_qty').text();
		order_price = $('#order_price').text().replaceAll(",","").replace(" won", "");
	
		if(member_seq==''){alert('구매하려면 로그인을 해야합니다');document.location="/login";return false;}

		document.location = "/doPurchase/" + member_seq + "/" + prod_id + "/" + order_qty + 
						    "/" + order_price;

})
.on('click','#descTable',function(){
	$(this).css('border-bottom','0px');
	$('#reviewTable').css('border-bottom','1px solid gray');
	$('#prod_desc').css('display','inline');
	$('#reviews').css('display','none');
	
})
.on('click','#reviewTable',function(){
	$(this).css('border-bottom','0px')
	$('#descTable').css('border-bottom','1px solid gray')
	$('#prod_desc').css('display','none')
	$('#reviews').css('display','block');
	// 리뷰출력/리뷰작성칸 출력하는거 나와야함. 그리고 그게 구매안했으면 쓰면안됨 
	refreshPages();
})
// stars2 라는 th 내의 span name=emptyStar 를 filledStar 로 바꾸면서 그 안의 text를 ☆ 로 바꿔야함 

.on('click','span[name=page]',function(){
	
	pageNum = parseInt( $(this).text() );

	$('span[name=page]').css('text-decoration-line','none');
	$(this).css('text-decoration-line','underline');
	refreshReviews(pageNum)
})


.on('mouseover','span[name=star]',function(){
	
	if(flag==0){
		index = $(this).index();
		for(var i=0;i<=index;i++){
			$('span[name=star]:eq('+ i +')').text('★');
			$('span[name=star]:eq('+ i +')').css({'color':'yellow', 'text-shadow':'-1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black'});
		}

	}
	// 빈별이면 name=filledStar 적용하고 아니면 name=star 적용
	
	
})
.on('mouseout','#stars2',function(){
	
	if(flag==0){
		for(var i=0;i<$('span[name=star]').length;i++){
			$('span[name=star]:eq('+ i +')').text('☆');
			$('span[name=star]:eq('+ i +')').css({'color':'black', 'text-shadow':'none'});
		}
	}
	
})
.on('click','span[name=star]',function(){
	
	if(flag==0){
		flag=1;
		index = $(this).index();
		for(var i=0;i<=index;i++){
			$('span[name=star]:eq('+ i +')').text('★');
			$('span[name=star]:eq('+ i +')').css({'color':'yellow', 'text-shadow':'-1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black'});
		}
	} else {
		flag=0;
		for(var i=0;i<$('span[name=star]').length;i++){
			$('span[name=star]:eq('+ i +')').text('☆');
			$('span[name=star]:eq('+ i +')').css({'color':'black', 'text-shadow':'none'});
		}
		index = $(this).index();
		for(var i=0;i<=index;i++){
			$('span[name=star]:eq('+ i +')').text('★');
			$('span[name=star]:eq('+ i +')').css({'color':'yellow', 'text-shadow':'-1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black'});
		}
	}	
	
})

.on('click','#addReview',function(){
	member_seq = $('#member_seq').val();
	prod_id = $('#prod_id').val();
	review_rate = 0;
	for(var i=0;i<$('span[name=star]').length;i++){
		if( $('span[name=star]:eq('+i+')').text()=='★' ){
			review_rate++;
		}
	}
	review_content = $('#review_content').val();
	
	if(member_seq==''){alert('리뷰를 작성하려면 로그인하셔야합니다.');return false;}
	if(review_rate==0){alert('평점을 선택해주세요');return false;}
	if(review_content==''){alert('리뷰내용을 입력해주세요');return false;}
	
	$.ajax({url:'/addReview', type:'post', dataType:'text', 
		
		data:{
			member_seq:member_seq, 
			prod_id:prod_id, 
			review_rate:review_rate, 
			review_content:review_content
		},
		
		success:function(data){
			if(data.length==0){
				refreshPages();
				$('#review_content').val('');
				for(var i=0;i<$('span[name=star]').length;i++){
					$('span[name=star]:eq('+i+')').text('☆');
					$('span[name=star]:eq('+ i +')').css({'color':'black', 'text-shadow':'none'});
					flag=0;
				}
			} else {
				alert(data);	// 구매기록이 존재하지않습니다. 출력. 그런데 구매기록이있어도 리뷰남긴게있으면 쓰면안됨.
			}
		}
	
	})
	
})

.on('click','.reviewDelete',function(){
	review_seq = $(this).attr('name');
	member_seq = $('#member_seq').val();
	prod_id = $('#prod_id').val();
	
	$.ajax({url:'/deleteReview', type:'post', 
		
		data:{review_seq:review_seq, member_seq:member_seq, prod_id:prod_id},
		success:function(){
			refreshPages();
		}
	})
})

let flag = 0;
let leftover_flag = 1;



function refreshAll(){
	prod_price = parseInt($('#prod_price').text().replace(" won","")).toLocaleString();
	$('#prod_price').text(prod_price + " won");
	$('#order_price').text(prod_price + " won")
	
	
	if($('#review_rate').text()!='0.00'){
		
		original_review_rate = $('#review_rate').text();
		review_rate = Math.round( parseInt( $('#review_rate').text() ) );
		stars = "<span id=stars>";
		for(var i=0;i<review_rate;i++){
			stars = stars + '★';
		} 
		$('#review_rate').empty()
		$('#review_rate').append(stars + "</span><span id=original> " + original_review_rate + "/5.00</span>");
		
	} else {
		
		$('#review_rate').empty()
		$('#review_rate').append('<span id=nostar>★</span><span id=original> 0.00/0.00 아직 작성된 리뷰 없음</span>');
		
	}
	
	$('#descTable').trigger('click');
}

function refreshPrice(){
	$('#order_price').empty();
	order_qty = parseInt( $('#order_qty').text() );
	prod_price = parseInt( $('#prod_price').text().replaceAll(",","").replace(" won") )
	
	order_price = order_qty*prod_price;
	$('#order_price').text(order_price.toLocaleString() + " won")
}

function refreshPages(){
	// 일단 pageNums 에 그 상품에 대한 리뷰 개수에 따라서 몇페이지를 출력할지 정함 
	// 그리고 서버에서 받아와서 출력함
	
	$.ajax({url:'/refreshPage', type:'post', dataType:'json',
		
		
		data:{prod_id:$('#prod_id').val()},
		success:function(data){
			
			$('#pageNums').empty();
			
			if(data=='0'){
				$('#pageNums').append('<span>작성된 리뷰가 존재하지 않습니다</span>')
				$('tr[name=review]').remove();	
			} else {
				$('#pageNums').empty();
				endPage = parseInt(data);
				str = '';
				for(var i=1;i<=endPage;i++){
					str = str + '&nbsp;<span name=page>'+i+'</span>&nbsp;';
				}
				$('#pageNums').append(str);
				
				$('span[name=page]:eq(0)').trigger('click');
			}
			
		}
	})
}

function refreshReviews(pageNum){
	
	
	$.ajax({url:'/refreshReviews2', type:'post', dataType:'json', 
		
		data:{prod_id:$('#prod_id').val(), pageNum:pageNum},
		
		success:function(data){
			
			$('tr[name=review]').remove();
			
			str = '';
			for(var i=0;i<data.length;i++){
				
				review_seq = data[i].review_seq;
				member_id = data[i].member_id;
				review_rate = data[i].review_rate;
				
				howmanyStars = parseInt(review_rate);
				stars = '';
				for(var j=0;j<5;j++){
					if(j<howmanyStars){
						stars = stars + '<span name=filledstar>★</span>';
					} else{
						stars = stars + '☆'
					}
				}
	
				review_content = data[i].review_content;
				deleteButton = data[i].buttonStr;
				
				str = '<tr name=review id=' + review_seq + '><td>' + member_id + '</td>' +
					  '<td>' + stars + '</td>' +
					  '<td>' + review_content + '</td>' +
					  '<td>' + deleteButton + '</td>' + 
					  '</tr>'
				$('#allreviews').append(str);
				
			}
		}
	})
}



</script>
</html>

