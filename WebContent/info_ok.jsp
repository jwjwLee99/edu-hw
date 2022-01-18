<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
request.setCharacterEncoding("UTF-8");
if(session.getAttribute("userid") == null){
%>
<script>
	alert("로그인 후 이용하세요");
	location.href="./login.jsp"
</script>
<%
}else{
	String userpw = request.getParameter("userpw");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	String hobby[] = request.getParameterValues("hobby");
	String hobbyStr = "";
	for(int i = 0; i < hobby.length; i++){
		hobbyStr = hobbyStr + hobby[i] + " ";
	}
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	
	String userid = (String)session.getAttribute("userid");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "";
	
	try {
		conn = Dbconn.getConnection();
		
		if(conn != null){
			sql = "update tb_member set mem_userpw=?, mem_name=?, mem_hp=?, mem_email=?, mem_hobby=?, mem_zipcode=?, mem_address1=?, mem_address2=?, mem_address3=? where mem_userid=?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1, userpw);
			pstmt.setString(2, name);
			pstmt.setString(3, hp);
			pstmt.setString(4, email);
			pstmt.setString(5, hobbyStr);
			pstmt.setString(6, zipcode);
			pstmt.setString(7, address1);
			pstmt.setString(8, address2);
			pstmt.setString(9, address3);
			pstmt.setString(10, userid);
			
			int result = pstmt.executeUpdate();
			
			if(result >= 1){
				%>
				<script>
					alert("수정 완료");
					location.href="./info.jsp";
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