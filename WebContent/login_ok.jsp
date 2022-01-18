<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	String url = "jdbc:mysql://localhost:3306/aiclass";
	String uid = "root";
	String upw = "1234";
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		
		if(conn != null){
			sql = "select mem_index, mem_name from tb_member where mem_userid=? and mem_userpw=?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpw);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ //로그인 성공
				// 세션에 저장
				session.setAttribute("userid", userid);
				session.setAttribute("index", rs.getString("mem_index"));
				session.setAttribute("name", rs.getString("mem_name"));
				
				%>
				<script type="text/javascript">
					alert("로그인 되었습니다.");
					location.href="login.jsp"; // 캐시를 지우고 페이지 이동
				</script>
				<%
			}else{ // 로그인 실패
				%>
				<script type="text/javascript">
					alert("아이디 또는 비밀번호를 확인하세요.")
					history.back(); // 캐시가 있는 상태로 페이지 이동
				</script>
				<%	
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
	
