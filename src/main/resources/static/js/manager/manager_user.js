$(document)
.ready(function(){
	loadMemberList($("#displayPageCount option:selected").val(), 1);
})
.on("change", "#displayPageCount", function(){
	let pageCount = $(this).children("option:selected").val();
	console.log(pageCount);
	loadMemberList(pageCount, 1);
})
.on("click", "#pageBox div", function(){
	let pageNo = $(this).text();
	console.log(pageNo);
	loadMemberList($("#displayPageCount option:selected").val(), pageNo);
})
function loadMemberList(count, pageNo){
	$.ajax({url: "/loadMemberList", 
			type: "post", 
			dataType: "json",
			data: {amount:count, no:pageNo},
			success: function(data){
				console.log(data);
				$("#tblMemberList tr:gt(0)").remove();
				$("#pageBox").empty();
				for(i=0; i<data.length; i++){
					let list = data[i];
					let str = "<tr><td>"+list["member_id"]+"</td>";
					str += "<td>"+list["member_name"]+"</td>";
					str += "<td>"+list["member_email"]+"</td>";
					str += "<td>"+list["member_mobile"]+"</td>";
					str += "<td>"+list["member_created"]+"</td></tr>";
					$("#tblMemberList").append(str);
				}
				let totalPage = data[0]["total"];
				console.log(totalPage);
				for(i=1; i<=totalPage; i++){
					let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
					$("#pageBox").append(str);
				}
				$("#page"+pageNo).addClass("bold");
			}
	})
}