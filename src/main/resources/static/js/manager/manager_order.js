$(document)
.ready(function(){
	loadOrderList($("#displayPageCount option:selected").val(), 1, 0);
})
.on("change", "#displayPageCount", function(){
	let pageCount = $(this).children("option:selected").val();
	console.log(pageCount);
	loadOrderList(pageCount, 1);
})
.on("click", "#pageBox div", function(){
	let pageNo = $(this).text();
	console.log(pageNo);
	loadOrderList($("#displayPageCount option:selected").val(), pageNo);
	
})
.on("click", "#orderAllChk", function(){
	if($("#orderAllChk").is(":checked")){
		$("input[name=orderChk]").prop("checked", true);
	}else{
		$("input[name=orderChk]").prop("checked", false);
	}
})
.on("click", "input[name=orderChk]", function(){
	let total = $("input[name=orderChk]").length;
	let checked = $("input[name=orderChk]:checked").length;
	if(total == checked){
		$("#orderAllChk").prop("checked", true);
	}else{
		$("#orderAllChk").prop("checked", false);
	}
})
.on("click",".orderView button", function(){
	let no = $(this).attr("id").replace("btnOrderView", "");
	console.log("선택된 주문 번호: "+no);
	viewOrderInfo(no);
})
.on("click", "#btnOrderConfirm", function(){
	let checked = checkedData(".orderView");
	if(checked==""){
		alert("선택된 주문이 없습니다.");
		return false;
	}
	console.log(checked);
	if(confirm("선택된 항목:\n"+checked+"\n주문상태를 변경 하시겠습니까?")==true){
		orderStatusUpdate(checked);
	}else return false;
})
.on("click", "#btnOrderCancel", function(){
	let checked = checkedData(".orderView");
	if(checked==""){
		alert("선택된 주문이 없습니다.");
		return false;
	}
	if(confirm("주문취소 처리 하시겠습니까?")){
		orderCancel(checked);
	}else return false;
})
function loadOrderList(count, pageNo){
	$.ajax({url: "/loadOrderList", 
			type: "post", 
			dataType: "json",
			data: {amount:count, no:pageNo},
			success: function(data){
				console.log(data);
				$("#tblOrderList tr:gt(0)").remove();
				$("#pageBox").empty();
				for(i=0; i<data.length; i++){
					let list = data[i];
					let str ="<tr>";
					
					if(list["order_status"]=="결제완료"){
						str += "<td><input type=checkbox name=orderChk id=orderChk"
							  + list["order_seq"]+" value="
							  + list["order_seq"]+"></td>"
					}else str += "<tr><td></td>";
					
					str += "<td>"+list["order_seq"]+"</td>";
					str += "<td>"+list["order_date"]+"</td>";
					str += "<td>"+list["order_status"]+"</td>";
					str += "<td>"+list["prod_id"]+"</td>";
					str += "<td><button id=btnOrderView"+list["order_seq"]+">주문상세</button></td></tr>";
					$("#btnOrderView"+i).attr("type", "button");
					$("#tblOrderList").append(str);
				}
				let totalPage = data[0]["total"];
				console.log(totalPage);
				for(i=1; i<=totalPage; i++){
					let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
					$("#pageBox").append(str);
				}
				$("#page"+pageNo).addClass("bold");
				$("#tblOrderList td:contains('결제완료')").css("color", "red");
			}
	})
}
function orderStatusUpdate(checked){
	$.ajax({url: "/orderStatusUpdate",
			type: "post",
			data: {orderSeqList: checked},
			traditional: true,
			dataType: "text",
			success: function(data){
				alert("상태변경:"+data);
				loadOrderList();
			}
	})
}
function orderCancel(checked){
	$.ajax({url: "/orderCancel",
			type: "post",
			data: {orderSeqList: checked},
			traditional: true,
			dataType: "text",
			success: function(data){
				alert("주문취소:"+data);
				loadOrderList();
			}
	})
}
function viewOrderInfo(no){
	document.location="/order_info/"+no;
}
function checkedData(select){
	let dataList=[];
	$(select).find('input:checked').each(function(index, value){
		let data = $(value).val();
		if(data!="on"){
			dataList.push(data);
		}
	})
	return dataList;
}