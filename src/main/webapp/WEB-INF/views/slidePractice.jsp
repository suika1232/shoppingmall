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
    <title>Order_info</title>
</head>
<style>
/*RESET*/
* {
    margin: 0;
    padding: 0;
}

a { text-decoration: none; color: #404040; }  /* a 의 처음색깔  */

li { list-style: none; }	/* list 옆에 점찍히는거 안나옴 */

#nav { width: 100%; font: 17px 'Nanum Gothic', sans-serif; } /* 그냥 글씨체, 글씨크기, nav길이 */
#nav:after { content: ""; display: block; clear: both; }

.main { margin: 30px; }

.main > li {
    position: relative;
    float: left;
    width: 210px;
    height: 30px;
    box-sizing: border-box;
    line-height: 30px;
    text-align: center;
    background: #ccc;
}

.main > li:hover .sub {
    /*display: block;*/
}

.main > li a {
    display: block;
    transition: all 0.3s;
}

.main > li a:hover { background: #009688; color: #fff; } /* 마우스오버시 색깔바뀜 */

.sub {
    display: none;
    position: absolute;
    top: 30px;
    left: 0;
    z-index: 1;
    width: 100%;
    background: #eee;
    opacity: 0.8;
}
</style>
<body>
<nav>

    <div id="nav">
        <ul class="main">
        
            <li><a href="#">MAIN 01</a></li>

            <li>
            	<a href="#">MAIN 02</a>
            	
                <ul class="sub">
                
                    <li><a href="#">SUB 01</a></li>

                    <li><a href="#">SUB 02</a></li>

                    <li><a href="#">SUB 03</a></li>

                    <li><a href="#">SUB 04</a></li>
                    
                </ul>
            </li>

            <li><a href="#">MAIN 03</a>

                <ul class="sub">

                    <li><a href="#">SUB 05</a></li>

                    <li><a href="#">SUB 06</a></li>

                    <li><a href="#">SUB 07</a></li>

                </ul>

            </li>

        </ul>

    </div>

</nav>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document).ready(function() {
    $(".main>li").mouseover(function() {
        $(this).children(".sub").stop().slideDown();
    });
    $(".main>li").mouseleave(function() {
        $(this).children(".sub").stop().slideUp();
    });
});
</script>
</html>


