<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	if(userid == null){
%>
	<script>
		alert("로그인 후 이용하세요");
		location.href="../login.jsp"
	</script>
<%
	}else{
	%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>커뮤니티 - 글쓰기</title>
	<style>
	input[type="textarea"] {
		resize : none; 
		height : 200px;
	}
	</style>
	</head>
	<body>
		<h2>커뮤니티 - 글쓰기</h2>
		<!-- 
			form action : write_ok.jsp
			작성자 : session.getAttribute("userid")
			제목 : b_title
			내용 : b_content
			
			write_ok.jsp -> list.jsp 이동
			db insert
		 -->
		 
		 <form action="./write_ok.jsp" method="post" name="writeform">
		 	<p>
		 		작성자 : <%=name %>
		 	</p>
		 	<p>
		 	제목<input type="text" name="title" id="title">
		 	</p>
		 	<p>
		 		내용<input type="textarea" name="content" id="content">
		 	</p>
		 	<p>
		 		<input type="submit" value="작성 완료">
		 		<input type="reset" value="다시 쓰기">
		 		<input type="button" value="리스트" onclick="location.href='list.jsp'">
		 	</p>
		 </form>
	</body>
	</html>
<%
	}
%>