<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<style>
header{
     min-width:1250px; min-height:200px;
     width: 100%; text-align: center; margin: 0 auto;
     margin-top:10px; 
     background-color:white; border-bottom:2px solid gray;
}
nav{
     width: 100%; text-align: center; margin: 0 auto;
     line-height:50px; font-size:20px;
     min-width:1250px; 
}
nav a{color:white;}
aside{
     height: 600px; width: 19%; outline: dashed 1px green; text-align: center;
     float: left ; margin-top: 110px; position:fixed; z-index:1;
} 
section{
     height: 100%;width:100%; text-align: center; margin-bottom: 15px;
     position:relative; min-width:1250px;
     background-color:white;
     border-top:2px solid gray;}
footer{
     height:100%; width: 100%; text-align: center; margin-bottom: 50px;
     margin: 0 auto; position:relative;min-width:1250px;
     border-top:2px solid gray;border-bottom:2px solid gray;
	}
footer a{color:black}
/*RESET*/
#nav *{ margin: 0; padding: 0;}
#nav a{text-decoration:none;}
a{color:white}
li{list-style:none;}	
#nav{width:100%; background-color:white;font-family:font: 20px 'Nanum Gothic', sans-serif;}
#nav:after{content:"";display:block;clear:both;}
.main {margin:30px;}
.main > li {
    position: relative;
    float: left;
    width: 20%;		
    height: 30px;
    box-sizing: border-box;
    line-height: 30px;
    text-align: center;
    background: black;
}
.main > li:hover .sub { /*display: block;*/ }
.main > li a { display: block;transition: all 0.3s;}
.main > li a:hover {background: black; color: yellow;}
.sub {
    display: none;
    position: absolute;
    top: 30px;
    left: 0;
    z-index: 1;
    width: 100%;
    background: black;
    opacity: 0.8;
}
#logo{display:block;
	width:100%;
	height:auto;}
</style>





