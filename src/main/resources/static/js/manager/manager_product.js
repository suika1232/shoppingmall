$(document)
.ready(function(){
	loadProdList($("#displayPageCount option:selected").val(), 1);
	$("#currPage").val(1);
})
.on("change", "#displayPageCount", function(){
	let pageCount = $(this).children("option:selected").val();
	console.log(pageCount);
	loadProdList(pageCount, 1);
})
.on("click", "#pageBox div", function(){
	let pageNo = $(this).text();
	console.log(pageNo);
	loadProdList($("#displayPageCount option:selected").val(), pageNo);
	$("#currPage").val(pageNo);
	$("#prodAmountModal").dialog("close");
})
.on("click", "#btnProdInsert", function(){
	document.location="/manager_product_insert";
})
.on("click", "#prodAllChk", function(){
	if($("#prodAllChk").is(":checked")){
		$("input[name=prodChk]").prop("checked", true);
	}else{
		$("input[name=prodChk]").prop("checked", false);
	}
})
.on("click", "input[name=prodChk]", function(){
	let total = $("input[name=prodChk]").length;
	let checked = $("input[name=prodChk]:checked").length;
	if(total == checked){
		$("#prodAllChk").prop("checked", true);
	}else{
		$("#prodAllChk").prop("checked", false);
	}
})
.on("click", "#btnProdDel", function(){
	let checked = checkedData(".prodView");
	console.log(checked);
	if(!$("input[name=prodChk]").is(":checked")){
		alert("삭제할 제품을 선택하세요.");
		return false;
	}
	if(confirm("선택한 제품을 삭제하시겠습니까?")) {
		deleteProd(checked);
	}else{
		if($("#prodAllChk").is(":checked")){
			$("#prodAllChk").prop("checked", false);
			$("input[name=prodChk]").prop("checked", false);
		}else{
			$("input[name=prodChk]").prop("checked", false);
		}
		return false;
	}
})
.on("click", "#btnProdUpdate", function(){
	if(!$("input[name=prodChk]").is(":checked")){
		alert("수정할 제품을 선택하세요.");
		return false;
	}else if($("input[name=prodChk]:checked").length > 1){
		alert("한번에 하나의 제품만 수정 가능합니다.");
		$("#prodAllChk").prop("checked", false);
		$("input[name=prodChk]").prop("checked", false);
		return false;
	}
	goToUpdateMenu($("input[name=prodChk]:checked").val());
})
.on("click", "#tblProdList tr:gt(0) td:last-child", function(){
	let prodId = $(this).parent("tr").find("td:eq(1)").text();
	console.log(prodId);
	getProdAmount(prodId);
	$("#prodAmountModal").dialog({
		title: "Update Product Amount",
		resizable: false,
		width: 250,
		height: 190,
		position: { my: "center", at: "center", of: $("#tblProdList") }
	})
})
.on("click", "#btnAddProdAmount", function(){
	let prodId = $("#tblProdAmount tr:eq(0) td:eq(1)").text();
	let addAmount = $("#inputAddProdAmount").val();
	if(addAmount==""){
		alert("추가할 수량을 입력하세요");
		return false;
	}
	updateProdAmount(prodId, addAmount);
	$("#btnCloseModal").trigger("click");
})
.on("click", "#btnCloseModal", function(){
	$("#inputAddProdAmount").val("");
	$("#prodAmountModal").dialog("close");
})
.on("click", "#btnEmptyProdAmount", function(){
	let prodId = $("#tblProdAmount tr:eq(0) td:eq(1)").text();
	emptyProdAmount(prodId);
})
function loadProdList(count, pageNo){
	$.ajax({url: "/loadProdList",
			type: "post",
			dataType: "json",
			data: {amount:count, no:pageNo},
			success: function(data){
				console.log(data);
				$("#tblProdList tr:gt(0)").remove();
				$("#pageBox").empty();
				for(i=0; i<data.length; i++){
					let list = data[i];
					let str = "<tr><td><input type=checkbox name=prodChk id=prodChk"
							  +list["prod_id"]+" value="
							  +list["prod_id"]+"></td>"
					str += "<td>"+list["prod_id"]+"</td>";
					str += "<td>"+list["prod_category"]+"</td>";
					str += "<td>"+list["prod_code"]+"</td>";
					str += "<td>"+list["prod_name"]+"</td>";
					str += "<td>"+list["prod_price"]+"</td>";
					str += "<td>"+list["prod_amount"]+"</td></tr>";
					$("#tblProdList").append(str);
				}
				let totalPage = data[0]["total"];
				console.log(totalPage);
				for(i=1; i<=totalPage; i++){
					let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
					$("#pageBox").append(str);
				}
				$("#page"+pageNo).addClass("bold");
				$("#tblProdList tr:gt(0) td:nth-child(7)").filter(function(){
					return $(this).text()=="0";
				}).css("color", "red")
			}
	})
}
function checkedData(select){
	let dataList=[];
	$(select).find('input:checked').each(function(index, value){
		let data = $(value).val();
		dataList.push(data);
	})
	return dataList;
}
function deleteProd(prodIdList){
	$.ajax({url: "/deleteProd",
			type: "post",
			dataType: "text",
			traditional: true,
			data: {prodIdList:prodIdList},
			success: function(data){
				alert("제품삭제:"+data);
				loadProdList();
			}
	})
}
function goToUpdateMenu(prodId){
	document.location="/manager_product_update/"+prodId;
}
function getProdAmount(prodId){
	$.ajax({url: "/getProdAmount",
			type: "post",
			dataType: "json",
			data: {prodId:prodId},
			success: function(data){
				console.log(data);
				$("#tblProdAmount tr:eq(0) td:eq(1)").text(data["prod_id"]);
				$("#tblProdAmount tr:eq(1) td:eq(1)").text(data["prod_name"]);
				$("#tblProdAmount tr:eq(2) td:eq(1)").text(data["prod_amount"]);
			}
	})
}
function updateProdAmount(prodId, amount){
	$.ajax({url: "/updateProdAmount",
			type: "post",
			data: {prodId:prodId, addAmount:amount},
			error: function(error){
				console.log(error);
			},
			complete: function(){
				loadProdList($("#displayPageCount option:selected").val(), $("#currPage").val());
			}
	})
}
function emptyProdAmount(prodId){
	$.ajax({url: "/emptyProdAmount",
		type: "post",
		data: {prodId:prodId},
		success: function(){
			$("#btnCloseModal").trigger("click");
			loadProdList($("#displayPageCount option:selected").val(), $("#currPage").val());
			
		}
	})
}
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}