$(document)
.ready(function(){
	$(".main>li").mouseover(function() {
        $(this).children(".sub").stop().slideDown();
    })
    $(".main>li").mouseleave(function() {
        $(this).children(".sub").stop().slideUp();
    })
})
.on("click", "#memberManage", function(){
	$("#sectionView").attr("src", "/manager_user");
	$(".managerMenu").removeClass("selectedMenu");
	$(this).addClass("selectedMenu");
})
.on("click", "#orderManage", function(){
	$("#sectionView").attr("src", "/manager_order");
	$(".managerMenu").removeClass("selectedMenu");
	$(this).addClass("selectedMenu");
})
.on("click", "#prodManage", function(){
	$("#sectionView").attr("src", "/manager_product");
	$(".managerMenu").removeClass("selectedMenu");
	$(this).addClass("selectedMenu");
})
.on("click", "#csManage", function(){
	$("#sectionView").attr("src", "/manager_cs");
	$(".managerMenu").removeClass("selectedMenu");
	$(this).addClass("selectedMenu");
})