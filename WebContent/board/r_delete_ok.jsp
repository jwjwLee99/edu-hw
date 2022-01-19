<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	if(userid == null){
%>
	<script>
		alert("로그인 후 이용하세요");
		location.href="../login.jsp";
	</script>
<%
	} else{
		String index = request.getParameter("index");
		String r_index = request.getParameter("r_index");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			conn = Dbconn.getConnection();
			
			if(conn != null){
				sql = "delete from tb_reply where r_index=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, r_index);
				
				int result = pstmt.executeUpdate();
				
				if(result >= 1){
					%>
					<script>
						alert("삭제 완료");
						location.href="./view.jsp?index=<%=index%>";
					</script>
					<%
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>