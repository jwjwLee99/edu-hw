<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String name = (String)session.getAttribute("name");
	
	String sql = "";
	int totalCount = 0;
	String title = "";
	int hit = 0;
	int like = 0;
	String regdate = "";
	
	try {
		conn = Dbconn.getConnection();
		
		if(conn != null){
			sql = "select count(b_index) as total from tb_board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
			sql = "select b_index, b_userid, b_title, b_regdate, b_hit, b_like from tb_board order by b_index desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 리스트</title>
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
</head>
<body>
	<h2>커뮤티니 - 리스트</h2>
	<p>게시글 <%=totalCount %>개</p>
	<table border='1' width='800'>
		<tr>
			<th width="50">번호</th>
			<th width="300">제목</th>
			<th width="100">글쓴이</th>
			<th width="75">조회수</th>
			<th width="200">날짜</th>
			<th width="75">좋아요</th>
		</tr>
<%
	while(rs.next()){
		String b_index = rs.getString("b_index");
		String b_userid = rs.getString("b_userid");
		String b_title = rs.getString("b_title");
		String b_regdate = rs.getString("b_regdate");
		String b_hit = rs.getString("b_hit");
		String b_like = rs.getString("b_like");
%>
		<tr>
			<td><%=b_index %></td>
			<td><a href="./view.jsp?b_index=<%=b_index%>"><%=b_title %></a></td>
			<td><%=b_userid %></td>
			<td><%=b_hit %></td>
			<td><%=b_regdate %></td>
			<td><%=b_like %></td>
		</tr>
<%
	}
%>
	</table>
	<p>
		<button onclick="location.href='write.jsp'">글쓰기</button>
		<button onclick="location.href='login.jsp'">메인</button>
	</p>
	
</body>
</html>