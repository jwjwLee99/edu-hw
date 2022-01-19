<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	String r_index = request.getParameter("r_index");
	String content = request.getParameter("r_content");
	if(userid == null){
		%>
		<script>
			alert("로그인 후 이용해주세요");
			location.href="../login.jsp"
		</script>
		<%
	}else{
		Connection conn = null;
		PreparedStatement pstmt = null;
			
		String sql = "";
			
		try {
			conn = Dbconn.getConnection();
			
			if(conn != null){
				sql = "insert into tb_reply(r_userid, r_content, r_boardindex) values (?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, content);
				pstmt.setString(3, r_index);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<script>
			alert("댓글 입력 완료");
			location.href="./view.jsp?index=<%=r_index%>";
		</script>
		<%
	}
%>