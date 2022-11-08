<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BOARD VIEW</title>
		
		<!-- Ajax사용을 위한 js참조 -->
		<script src = "resources/js/httpRequest.js"></script>
		
		<script>
			function reply() {
				location.href = "replyForm.do?idx=${vo.idx}&page=${param.page}";
			}
			
			function del() {
				
				//삭제할거임? 말거임?
				if ( !confirm("삭제?")) {
					return;
				}
				
				var pwd = ${vo.pwd}; //원본 비번
				
				var c_pwd = document.getElementById("c_pwd").value;
				
				//유효성 췤
				if ( pwd != c_pwd ) {
					alert("pwd달라용 ㅋㅋ");
					return;
				} 
				
				var url = "del.do";
				var param = "idx=${vo.idx}";
				
				sendRequest( url, param, delCheck, "POST" );
			}
			
			//삭제 여부를 판단하는 콜백 메서드
			function delCheck() {
				if ( xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					
					//"[{'result' : 'yes'}]"
					var json = eval(data);
					
					if(json[0].result == 'yes') {
						alert("삭제성공");
						location.href = "board_list.do?page=${param.page}";
					} else {
						alert("실패");
					}
					
				}
			}
		</script>
	</head>
	<body>
		<table border = "1">
			<caption>:::게시글 상세보기:::</caption>
		
			<tr>
				<th>제목</th>
				<td>${ vo.subject }</td>
			</tr>
			
			<tr>
				<th>작성자</th>
				<td>${ vo.name }</td>
			</tr>
			
			<tr>
				<th>작성일</th>
				<td>${ vo.regdate }</td>
			</tr>
			
			<tr>
				<th>ip</th>
				<td>${ vo.ip }</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td width = "500" height = "200"><pre>${ vo.content }</pre></td>
			</tr>
			
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" id = "c_pwd"></td>
			</tr>
			
			<tr>
				<!-- 목록보기 -->
				<td colspan = "2">
					<img src = "resources/img/img/btn_list.gif" onclick = "location.href = 'board_list.do?page=${param.page}'"
					 style = "cursor:pointer;">
					 
					<c:if test = "${ vo.depth lt 1 }"> <!-- 댓글 못 달게 하기 -->
					<!-- 답변달기 -->
					<img src = "resources/img/img/btn_reply.gif" onclick = "reply();"
					 style = "cursor:pointer;">
					</c:if>
					<!-- 완전히 삭제할수 없어서 update이용할거임 -->
					<!-- 글 삭제 -->
					<img src = "resources/img/img/btn_delete.gif" onclick = "del();"
					 style = "cursor:pointer;">
					 
				</td>
			</tr>
			
		</table>
	</body>
</html>