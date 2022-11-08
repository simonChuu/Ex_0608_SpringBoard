<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script>
			function send_check() {
				var f = document.f; //f라는 name을 가진 form태그를 가져옴
				
				var name = f.name.value;
				//유효성 체크 했다 쳐
				
				f.submit();
			}
		</script>
	</head>
	<body>
		<form name = "f"
			  method = "post"
			  action = "insert.do">
			<table border = "1">
				<caption>::: 새 글 쓰기 :::</caption>
				
				<tr>
					<th>제목</th>
					<td><input name = "subject" style = "width : 370px;"></td>
				</tr>
				
				<tr>
					<th>작성자</th>
					<td><input name = "name" style = "width : 370px;"></td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td><textarea name = "content" rows = "10" cols = "50"
						 style = "resize:none;"></textarea></td>
				</tr>
				
				<tr>
					<th>비번</th>
					<td><input name = "pwd" type ="password" style = "width : 370px;"></td>
				</tr>
				
				<tr>
					<td colspan = "2">
						<img src = "resources/img/img/btn_reg.gif" onclick = "send_check();"
						 style = "cursor:pointer;">
						<!-- input태그를 이용할 시 에는 this.form을 이용하여 파라미터를 보낼 수 있지만, 
							 input이 아닌 다른태그에서 메서드를 호출했을때에는 불가함. -->
						<img src = "resources/img/img/btn_back.gif" onclick = "location.href = 'board_list.do'"
						 style = "cursor:pointer;">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>