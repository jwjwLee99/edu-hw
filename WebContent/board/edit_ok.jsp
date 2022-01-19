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
		location.href="../login.jsp"
	</script>
<%
	} else{
		String index = request.getParameter("index");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			conn = Dbconn.getConnection();
			
			if(conn != null){
				sql = "update tb_board set b_title=?, b_content=? where b_index=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setString(3, index);
				
				int result = pstmt.executeUpdate();
				
				if(result >= 1){
					%>
					<script>
						alert("수정 완료");
						location.href="./view.jsp?index=<%=index%>";
					</script>
					<%
				}else{
					%>
					<script>
						alert("수정 실패\n 입력을 확인해주세요");
						history.back();
					</script>
					<%
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>