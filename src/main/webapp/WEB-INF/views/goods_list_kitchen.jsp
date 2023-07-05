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
#allGoods{width:1250px;margin:0 auto;text-align:left;font-family:font: 15px 'Nanum Gothic', sans-serif;}
table{border-collapse:collapse;}
[name='itemBox']{width:110px;height:190px;}
[name='itemBox'] td{border:2px solid black;}
[name='item']{border:2px solid black;width:100%;height:100%;display:none;}
[name='itemBox'] img{width:100%;height:130px}
[name='prod_name']{background-color:black;color:white}
[name='prod_price']{background-color:black;color:white;}
[name='prod_reviewRate']{background-color:black;color:white;}
[name='star']{color:yellow}
[name='nostar']{color:gray}

/* td 가 itemBox 안에 table 이 item */

[name='item']:hover tr td{color:aqua;font-weight:bold;}

</style>
<body>
<%@ include file="./parts/head.jsp" %>

<section>
<!-- 전체상품 출력 -->

<br><br><br>
<div style="text-align:center">
	<div id="title"><h3 style="margin:0 auto">kitchen</h3></div>
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

    printKitchenProducts();
    $('#title').fadeToggle('slow')
    $('#title').fadeToggle('slow')
})


function printKitchenProducts(){
	
	
	// td 의 개수는 data length 만큼 필요함. 
	
	$.ajax({url:'/getKitchenProducts', type:'post', dataType:'json', 
		
		success:function(data){
			
			// 한 줄당 8개씩. 상품의 이름,가격,별점이 들어가야함.
			// allGoods 라는 table 안에 들어가야함.
			
			// 상품이 0개면 0줄,
			// 1~8개면 1줄,
			// 9~16개면 2줄
			// 17~24개면 3줄,  즉, 
			// 줄 수는 (상품개수/8 + 1) and (만약 상품개수%8==0 이면 줄 수 -1 이 줄 수 )
			
			var howmanyRows = Math.floor((data.length/8) + 1);
			if(howmanyRows%8==0){howmanyRows = howmanyRows - 1;}
			console.log(howmanyRows)
			for(i=0;i<howmanyRows;i++){
				
				str = '<tr>' +
					   '<td name=itemBox></td> <td name=itemBox></td> <td name=itemBox></td> <td name=itemBox></td>' +
					   '<td name=itemBox></td> <td name=itemBox></td> <td name=itemBox></td> <td name=itemBox></td>' +
					   '<td name=itemBox></td> <td name=itemBox></td>'+
					   '</tr>';
					   
				$('#allGoods').append(str);	
				
			}
		
// 			for(i=0;i<data.length;i++){
				
			i=0;
			
			clock = setInterval(function(){
				
				prod_id = data[i].prod_id;
				prod_address = data[i].prod_address;
				prod_name = data[i].prod_name;
				prod_price = parseInt(data[i].prod_price).toLocaleString();
				prod_reviewRate = data[i].prod_reviewRate;	// review table 뒤져서 그 prod_id 에 대한 review 들 찾아보고 합산/평균냄
				
				str = "";	// 상품사진/상품이름/상품가격/상품 총 별점을 나타내는 작은table이 들어갈 예정
				
				str = '<table name=item>' +
					  '<tr><td name=prod_name style="text-align:center">' + prod_name + '</td></tr>' +
					  '<tr><td name=prod_img><a href="/goods_info/'+prod_id+'"><img id'+prod_id+' src="' + prod_address + '"></a></td></tr>' +
					  '<tr><td name=prod_price style="text-align:right">' + prod_price + ' won</td></tr>';
					
				if(prod_reviewRate!=0){
					str = str +  '<tr><td name=prod_reviewRate style="text-align:center">' + '<span name=star>★ </span>'+ prod_reviewRate + '/5</td></tr>';
				} else {
					str = str + '<tr><td name=prod_reviewRate style="text-align:center">' + '<span name=nostar>★ </span>'+ prod_reviewRate + '/0</td></tr>';
				} 
				str = str + '</table>';
	
				$('td[name=itemBox]:eq('+i+')').append(str);

				$('td[name=itemBox]:eq('+i+') table[name=item]').fadeToggle('slow')
				
				i++;
				if(i>=data.length){clearInterval(clock)}
				
			}, 50)
			
				
// 			}

			
			
		}
	
	})
	
	
	
	
	
	
}

</script>
</html>