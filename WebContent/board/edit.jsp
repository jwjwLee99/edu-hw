<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
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
		String index = request.getParameter("index");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		String title = "";
		String content = "";
		
		try {
			conn = Dbconn.getConnection();
			
			if(conn != null){
		       	
		        sql = "select b_title, b_content from tb_board where b_index=?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1,index);
		        rs = pstmt.executeQuery();
		
		        if(rs.next()){
		            title = rs.getString("b_title");
		            content = rs.getString("b_content");
		        }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
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
		<form method="post" action="./edit_ok.jsp" name="writeform">
			<input type="hidden" name="index" value="<%=index %>">
		 	<p>
		 		작성자 : <%=name %>
		 	</p>
		 	<p>
		 		제목<input type="text" name="title" id="title" value="<%=title%>">
		 	</p>
		 	<p>
		 		내용
		 	</p>
		 	<p>
		 		<textarea rows="5" cols="40" name="content"><%=content%></textarea>
		 	</p>
		 	<p>
		 		<input type="submit" value="수정 완료">
		 		<input type="reset" value="다시 쓰기">
		 		<input type="button" value="리스트" onclick="location.href='list.jsp'">
		 	</p>
		</form>
	</body>
	</html>
<%
	}
%>