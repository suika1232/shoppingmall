const textPattern = /(<([^>]+)>)/gi;
$(document)
.ready(function(){
	loadCsList($("#displayPageCount option:selected").val(), 1);
})
.on("change", "#displayPageCount", function(){
	let pageCount = $(this).children("option:selected").val();
	console.log(pageCount);
	loadCsList(pageCount, 1);
})
.on("click", "#pageBox div", function(){
	let pageNo = $(this).text();
	console.log(pageNo);
	loadCsList($("#displayPageCount option:selected").val(), pageNo);
})
.on("click", "#tblCs tr:gt(0) td:nth-child(5)", function(){
	console.log($(this).text());
	let postId = $(this).parent("tr").find("td:eq(0)").text();
	console.log(postId);
	window.open("/post_view/"+postId);
})
.on("click",".csView button", function(){
	let postId = $(this).attr("id").substr(9);
	console.log(postId+" 버튼을 눌렀습니다.");
	$("#postSeq").val(postId);
	loadCsPost(postId);
	displayModal();
})
.on("click", "#btnModalSubmit", function(){
	insertComment("#btnAnswer"+$("#postSeq").val(), $("#postSeq").val(), $("#csComment").val());
})
.on("click", "#btnModalClose", function(){
	$("#csModal").dialog("close");
})
function loadCsList(count, pageNo){
	$.ajax({url: "/loadCsList",
			type: "post",
			dataType:"json",
			data: {amount:count, no:pageNo},
			success: function(data){
				$("#tblCs tr:gt(0)").remove();
				$("#pageBox").empty();
				for(i=0; i<data.length; i++){
					let list = data[i];
					let str = "<tr><td>"+list["post_seq"]+"</td>";
					str += "<td>"+list["category_name"]+"</td>";
					str += "<td>"+list["member_id"]+"</td>";
					str += "<td>"+list["post_created"]+"</td>";
					str += "<td>"+list["post_title"]+"</td>";
					str += "<td>"+list["post_answer"]+"</td>";
					if(list["post_answer"]=="답변대기"){
						str += "<td><button type=button id=btnAnswer"+list["post_seq"]+">답변</button></td>";
					}else str += "<td></td>";
					$("#tblCs").append(str);
				}
				let totalPage = data[0]["total"];
				console.log(totalPage);
				for(i=1; i<=totalPage; i++){
					let str = "<div id=page"+i+" class=pageDiv>"+i+"</div>&nbsp";
					$("#pageBox").append(str);
				}
				$("#page"+pageNo).addClass("bold");
				$("#tblCs td:contains('답변대기')").css("color", "red");
			}
	})
}
function displayModal(){
	$("#csModal").dialog({
		title: "Comment",
		resizable: false,
		width: 365,
		height: 375,
		position: { my: "left top", at: "right bottom", of: $("#tblCs td:eq(0)") }
	})
}
function loadCsPost(postId){
	$.ajax({url: "/loadCsPost",
			type: "post",
			dataType: "json",
			data: {postSeq:postId},
			success: function(data){
				let content = data["post_content"];
				console.log("post content:["+content+"]");
				if(content==""||content==null) {
					content = "내용없음";
					$("#tblCsComment tr:eq(2) td:eq(1)").text(content);
				}else if(content.includes("<img src")) {
					$("#tblCsComment tr:eq(2) td:eq(1)").empty();
					$("#tblCsComment tr:eq(2) td:eq(1)").append(
							$(document.createElement("a")).prop({
								target: "_blank",
								href: "/post_view/"+postId,
								innerText: "이미지파일 포함, 게시판에서 확인해주세요"
							})
					)
				}else{
					content = content.replace(textPattern, "");
					content = content.replaceAll("&nbsp;", "");
					$("#tblCsComment tr:eq(2) td:eq(1)").text(content);
				}
				$("#tblCsComment tr:eq(0) td:eq(1)").text(data["category_name"]);
				$("#tblCsComment tr:eq(1) td:eq(1)").text(data["post_title"]);
			}
	})
}
function insertComment(btnId, seq, comment){
	$.ajax({url: "/insertComment",
			type: "post",
			dataType: "text",
			data: {postSeq:seq, postComment:comment},
			success: function(data){
				console.log("답변작성:"+data);
			},
			complete: function(){
				$(btnId).remove();
				$("#postSeq").val("");
				$("#csComment").val("");
				$("#btnModalClose").trigger("click");
				loadCsList($("#displayPageCount option:selected").val(), 1);
			}
	})
}