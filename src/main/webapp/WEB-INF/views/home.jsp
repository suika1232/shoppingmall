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

#welcome{font-size:30px;
font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;}
#welcome2{font-size:25px;
font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;}
#welcome3{font-size:25px;
font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;}
#bannerTB{max-width:1250px; margin:0 auto;}
#left{width:75px;height:350px; background-color:rgb(236, 225, 225);cursor:pointer;z-index:1}
#right{width:75px;height:350px; background-color:rgb(236, 225, 225);cursor:pointer;z-index:1}
#left:hover{background-color:rgb(223, 198, 198)}
#right:hover{background-color:rgb(223, 198, 198)}
#left img{width:100%}
#right img{width:100%}
#banner{width:1100px;height:350px;white-space:nowrap;font-size:0px;
position:relative;overflow:hidden;}
#banners{position:absolute;width:100%;height:100%;top:0px;left:0;}
#banner img{width:100%;height:100%}
#bannerTB{border-collapse:collapse;}

#bestProducts{width:1000px;height:300px; margin:0 auto}
#bestProducts table{float:left; margin-left:100px;}
table[name=top3]{height:100%;width:200px;}
table[name=top3] img{width:100%;height:100%}
table[name=top3] td{}
td[name=prod_name]{font-size:20px;font-weight:bold; text-align:right}
td[name=prod_img]{width:200px;height:200px;}
td[name=prod_price]{text-align:right; font-weight:bold;}
td[name=review_rate]{text-align:right}

span[name=graystar]{color:gray}
span[name=yellowstar]{color:yellow;text-shadow: -1px 0px black, 0px 1px black, 1px 0px black, 0px -1px black;font-weight:1;}

#newProducts{width:1000px;height:300px; margin:0 auto}
#newProducts table{float:left; margin-left:100px;}
table[name=new3]{height:100%;width:200px;}
table[name=new3] img{width:100%;height:100%}
table[name=new3] td{}
td[name=prod_name]{font-size:20px;font-weight:bold; text-align:right}
td[name=prod_img]{width:200px;height:200px;}
td[name=prod_price]{text-align:right; font-weight:bold;}
td[name=review_rate]{text-align:right}

</style>
<body>
<%@ include file="./parts/head.jsp" %>

<section>
<br><br>
<div id=welcome>
	<h1>Welcome to DIGITAL OASIS</h1>
</div>
<br><br>

<div id=bannerDiv>
	
	<table id=bannerTB>
	
		<tr>	
			<td id=left> <img src='/img/banner_img/left.png'> </td> 
			<td id=banner>
				<span id=banners>
					<a href="/goods_info/83"><img name=banner src='/img/banner_img/banner1.jpg'></a>
					<a href="/goods_info/84"><img name=banner src='/img/banner_img/banner2.jpg'></a>
					<a href="/goods_info/85"><img name=banner src='/img/banner_img/banner3.jpg'></a>
				</span>
			</td> 
			<td id=right>  <img src='/img/banner_img/right.png'> </td> 
		</tr>
	
	</table>

</div>
<br><br>


<div id=welcome2><h1>our top3 best sellers</h1></div>
<br><br>

<div>
	<div id=bestProducts>

	</div>
</div>


<br><br><br>
<div id=welcome3><h1>our 3 latest products</h1></div>
<br><br>

<div>
	<div id=newProducts>

	</div>
</div>

<br><br>
</section>
<br>
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

let howmanyBanners = $('img[name=banner]').length;
bannerFlag = 0;
let clock;

$(document)
.ready(function(){
	startBanner();
	loadTop3();
	loadNew3();
})
.on('click','#right',function(){
	if(bannerFlag<howmanyBanners-1){
		$('#banners').animate({"left":"-=1100px"}, "slow");
		bannerFlag = bannerFlag + 1;
		console.log(bannerFlag)
	}
})
.on('click','#left',function(){
	if(bannerFlag>0){
		$('#banners').animate({"left":"+=1100px"}, "slow");
		bannerFlag = bannerFlag - 1;
	}
	console.log(bannerFlag)
})
.on('mouseover','#left',function(){
	clearInterval(clock);
})
.on('mouseover','#right',function(){
	clearInterval(clock);
})
.on('mouseout','#left',function(){
	startBanner();
})
.on('mouseout','#right',function(){
	startBanner();
})

function startBanner(){
		clock = setInterval(function(){
		if(bannerFlag<howmanyBanners-1){
			$('#right').trigger('click');
		} else if(bannerFlag==howmanyBanners-1){
			
			for(var i=0;i<howmanyBanners;i++){
				anotherLeft();
			}
		}
	},2000)
}
function anotherLeft(){
	if(bannerFlag>0){
		$('#banners').animate({"left":"+=1100px"},100);
		bannerFlag = bannerFlag - 1;
	}
}

function loadTop3(){
	
	$.ajax({url:'/loadtop3', type:'post', dataType:'json',
			
		success:function(data){
			
			for(var i=0;i<data.length;i++){
				prod_id = data[i].prod_id;
				prod_image = data[i].prod_image;
				prod_name = data[i].prod_name;
				prod_price = parseInt(data[i].prod_price).toLocaleString();
				review_rate = data[i].review_rate;
				if(review_rate==0){
					review = "<span name=graystar>★</span>&nbsp;"  + review_rate +"/0"; 
				} else {
					review = "<span name=yellowstar>★</span>&nbsp;"  + review_rate +"/5"; 
				}
				
				str = '<table name="top3">';
				str += '<tr><td name=prod_img><a href=goods_info/'+prod_id+'><img src=' + prod_image + ' ></a></td></tr>';
				str += '<tr><td name=prod_name>' + prod_name + '</td></tr>';
				str += '<tr><td name=prod_price>' + prod_price + ' ₩</td></tr>';
				str += '<tr><td name=review_rate>' + review + '</td></tr></table>';
				
				$('#bestProducts').append(str);
			}
			
		}
		
	})
	
	
}


function loadNew3(){
	
	$.ajax({url:'/loadnew3', type:'post', dataType:'json',
			
		success:function(data){
			
			for(var i=0;i<data.length;i++){
				prod_id = data[i].prod_id;
				prod_image = data[i].prod_image;
				prod_name = data[i].prod_name;
				prod_price = parseInt(data[i].prod_price).toLocaleString();
				review_rate = data[i].review_rate;
				if(review_rate==0){
					review = "<span name=graystar>★</span>&nbsp;"  + review_rate +"/0"; 
				} else {
					review = "<span name=yellowstar>★</span>&nbsp;"  + review_rate +"/5"; 
				}
				
				str = '<table name="top3">';
				str += '<tr><td name=prod_img><a href=goods_info/'+prod_id+'><img src=' + prod_image + ' ></a></td></tr>';
				str += '<tr><td name=prod_name>' + prod_name + '</td></tr>';
				str += '<tr><td name=prod_price>' + prod_price + ' ₩</td></tr>';
				str += '<tr><td name=review_rate>' + review + '</td></tr></table>';
				
				$('#newProducts').append(str);
			}
			
		}
		
	})
	
	
}

</script>
</html>














