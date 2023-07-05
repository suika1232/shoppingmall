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

#pictures { display:inline-block;white-space:nowrap;font-size:0;}
#pictures span{ margin:0;}
#line{position:absolute;width: 400px; height: 400px;}
   
#pictures2 { display:inline-block;white-space:nowrap;font-size:0;}
#pictures span2{ margin:0;}
#line2{position:absolute; width: 400px; height: 400px;}

</style>
<body>
<%@ include file="./parts/head.jsp" %>

<section>

<div>&nbsp;</div>

<div>
	<div style="border:1px solid green;margin:0 auto;width:600px;">
		<a href="goods_list_best"><img id=p src="/img/bestSellers.png" style="width:50%"></a>
	</div>
</div>
<br>
<div>
	<div id="pictures" style="border:1px solid green;margin:0 auto;width:400px;height:400px;overflow:hidden;position:relative">
		
		<span id="line">
		</span>
		
	</div>
</div>


<div>&nbsp;</div>
<div>&nbsp;</div>

<div>
	<div style="border:1px solid green;margin:0 auto;width:600px">
		<a href="goods_list_new"><img id=p2 src="/img/New Products.png" style="width:50%"></a>
	</div>
</div>
<br>
<div>
	<div id="pictures2" style="border:1px solid green;margin:0 auto;width:400px;height:400px;overflow:hidden;position:relative">
		
		<span id="line2">
			
		</span>
		
	</div>
</div>

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
	
	loadNewProducts()
	loadBestProducts();
})

function loadBestProducts(){
	
	howmanyPhotos = 0;	
	
	$.ajax({url:'/showBestProducts', type:'post', dataType:'json',
		success:function(data){
			
			for(var i=0;i<data.length;i++){
				
				prod_id = data[i].prod_id;
				prod_address = data[i].prod_address;
				
				str = "<a href='goods_info/"+ prod_id +"'>" + 
					  "<img src='" + prod_address + "' style='width:100%;height:100%'>" +
					  "</a>"
				$('#line').append(str);
			
				howmanyPhotos++;
			}
		},
		
		complete:function(){
			
			$('#line').animate({"left":"-=200px"}, "slow");
			i=0;
		
			clock1 = setInterval(function(){
				
				if(i<howmanyPhotos-1){
					
					$('#line').animate({"left":"-=400px"}, "slow");	
					i++;
					$('#p').fadeToggle('slow')
					$('#p').fadeToggle('slow')
			
				} else {
					
					i = 0;
					$('#line').animate({"left":"+="+(400*(howmanyPhotos-1))+"px"}, "slow");
					$('#p').fadeToggle('slow')
					$('#p').fadeToggle('slow')
				}
				
			},3000)
		}
		
	})
}

/////////////////////////////////////////////////////////////////////////////////////////

function loadNewProducts(){
	
	howmanyPictures = 0;	
	
	$.ajax({url:'/showNewProducts', type:'post', dataType:'json',
		success:function(data2){
			
			for(var j=0;j<data2.length;j++){
				
				prod_id = data2[j].prod_id;
				prod_address = data2[j].prod_address;
				
				str = "<a href='goods_info/"+ prod_id +"'>" + 
					  "<img src='" + prod_address + "' style='width:100%;height:100%'>" +
					  "</a>"
				$('#line2').append(str);
			
				howmanyPictures++;
			}
		},
		
		complete:function(){
			
			$('#line2').animate({"left":"-=200px"}, "slow");
			j=0;
		
			clock2 = setInterval(function(){
				
				if(j<howmanyPictures-1){
					
					$('#line2').animate({"left":"-=400px"}, "slow");	
					j++;
					$('#p2').fadeToggle('slow')
					$('#p2').fadeToggle('slow')
			
				} else {
					
					j = 0;
					$('#line2').animate({"left":"+="+(400*(howmanyPictures-1))+"px"}, "slow");
					$('#p2').fadeToggle('slow')
					$('#p2').fadeToggle('slow')
				}
				
			},3000)
		}
		
	})
}


</script>
</html>














