<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	String userid = (String)session.getAttribute("userid");
	if(userid == null){
%>
	<script>
		alert("로그인 후 이용하세요");
		location.href="../login.jsp"
	</script>
<%	
	}else{
		String index = request.getParameter("b_index");
			
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
			
		int like = 0;
			
		try {
			conn = Dbconn.getConnection();
			
			if(conn != null){	       	
		       	sql = "update tb_board set b_like=b_like+1 where b_index=?";
		       	pstmt = conn.prepareStatement(sql);
			    pstmt.setString(1, index);
		       	pstmt.executeUpdate();
		       	
		       	sql = "select b_like from tb_board where b_index=?";
		       	pstmt = conn.prepareStatement(sql);
		       	pstmt.setString(1, index);
		       	rs = pstmt.executeQuery();
		       	if(rs.next()){
		       		like = rs.getInt("b_like");
		       		out.print(like);
		       	}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>