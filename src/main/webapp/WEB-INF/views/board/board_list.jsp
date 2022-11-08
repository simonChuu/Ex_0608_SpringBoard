<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>@@@@@@@@게시판@@@@@@@@</title>
		
		<style>
			a{ text-decoration : none;}
			table{ border-collapse : collapse;}
		</style>
	</head>
	<body>
		<table border = "1" width = "700">
			<tr>
				<td colspan = "5"><img src = "resources/img/img/title_04.gif"></td>
			</tr>
			
			<tr>
				<th>번호</th>
				<th width = "350" align = "center">제목</th>
				<th width = "120">작성자</th>
				<th width = "100">작성날짜</th>
				<th width = "50">조회수</th>
			</tr>
			
			<!-- 게시물들을 보여줄 forEach -->
		<c:forEach var="vo" items="${ list }">
		<tr>
			<td align="center">${vo.idx}</td>

			<td>
				<!-- 댓글일 경우 들여쓰기 -->
				<c:forEach begin="1" end="${ vo.depth }">&nbsp;</c:forEach>
				
				<!-- 댓글기호 -->
				<c:if test="${ vo.depth ne 0 }">ㄴ</c:if>
				
				<!-- 삭제되지 않은 글일 경우 클릭이 가능 -->
				<c:if test="${ vo.del_info ne -1 }">
					<a href="view.do?idx=${vo.idx}&page=${param.page}"> <!-- 질문 -->
					<font color="black">${ vo.subject }</font>
					</a>
				</c:if>
				
				<!-- 삭제된 게시글을 클릭할 수 없도록 처리 -->
				<c:if test="${ vo.del_info eq -1 }">
					<font color="gray">${ vo.subject }</font>
				</c:if>
				
			</td>
			
			<td align="center">${ vo.name }</td>
			
			<!-- 삭제가 되지 않은 게시물은 등록일자를 정상적으로 표기 -->
			<c:if test="${ vo.del_info ne -1 }">
			<td align="center">${ fn:split(vo.regdate, ' ')[0] }</td>
			</c:if>
			
			<!-- 삭제된 게시글은 날짜도 숨김 -->
			<c:if test="${ vo.del_info eq -1 }">
			<td align="center">unknown</td>
			</c:if>
			
			<td align="center">${ vo.readhit }</td>
		</tr>
		</c:forEach>
			
			<tr>
				<td colspan = "5" align = "center">
					${ pageMenu }
				</td>
			</tr>
			
			<tr>
				<td colspan = "5" align = "right">
					<img src = "resources/img/img/btn_reg.gif"
					 onclick = "location.href = 'insert_form.do'"
					 style = "cursor:pointer;">
					 <!-- style = "cursor:pointer"; 이미지에 마우스를 올렷을 때 손가락 모양으로 바뀌는거 -->
				</td>
			</tr>
		</table>
	</body>
</html>