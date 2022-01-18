<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	if(userid == null){
		%>
		<script>
			alert("로그인 후 이용해주세요");
			location.href="./login.jsp"
		</script>
		<%
	}else{
		if(title == null && content == null){
			%>
			<script>
				alert("제목 과 본문을 입력해주세요");
				location.href="./write.jsp";
			</script>
			<%
		}else{
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			String sql = "";
			
			try {
				conn = Dbconn.getConnection();
				
				if(conn != null){
					sql = "insert into tb_board(b_userid, b_title, b_content) value (?, ?, ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userid);
					pstmt.setString(2, title);
					pstmt.setString(3, content);
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			%>
			<script>
				alert("등록완료");
				location.href="./list.jsp";
			</script>
			<%
		}
	}
%>