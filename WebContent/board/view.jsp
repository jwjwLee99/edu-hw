<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	String index = request.getParameter("index");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	String r_index = "";
	String r_boardindex = "";
	String userid = "";
	String r_userid = "";
	String title = "";
	String content = "";
	String r_content = "";
	String regdate = "";
	String r_regdate = "";
	String date = "";
	int like = 0;
	int hit = 0;
	
	try {
		conn = Dbconn.getConnection();
		
		if(conn != null){
	       	
	       	sql = "update tb_board set b_hit= b_hit + 1 where b_index=?";
	       	pstmt = conn.prepareStatement(sql);
	       	pstmt.setString(1, index);
	       	pstmt.executeUpdate();
	       	
	       	
	        sql = "select * from tb_board where b_index=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1,index);
	        rs = pstmt.executeQuery();
	
	        if(rs.next()){
	        	userid = rs.getString("b_userid");
	            title = rs.getString("b_title");
	            content = rs.getString("b_content");
	            regdate = rs.getString("b_regdate");
	            date = regdate.split(" ")[0];
	            like = rs.getInt("b_like");
	            hit = rs.getInt("b_hit");
	        }
	        
	        sql = "select * from tb_reply where r_boardindex=? order by r_index desc";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1,index);
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
	<title>커뮤니티 - 글보기</title>
	<script
	  src="https://code.jquery.com/jquery-3.6.0.min.js"
	  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	  crossorigin="anonymous"></script>
	 <script>
	   	$(() => {
	   		$('#like').on('click', () => {
	   			const xhr = new XMLHttpRequest();
	   			xhr.open('GET', "likeClick.jsp?b_index=<%=index%>", true);
	   			xhr.send();
	  			
	   			xhr.onreadystatechange = () => {
	    			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
	    				$('#likecount').html(xhr.responseText);
	    			}
	   			}
	    	})
	   	})
	 </script>
</head>
<body>
    <h2>커뮤니티 - 글보기</h2>
    <table width="800" border="1">
        <tr>
            <td>제목</td>
            <td><%=title %></td>
        </tr>
        <tr>
            <td>날짜</td>
            <td><%=date %></td>
        </tr>
        <tr>
            <td>작성자</td>
            <td><%=userid %></td>
        </tr>
        <tr>
            <td>조회수</td>
            <td><%=hit %></td>
        </tr>
        <tr>
            <td>좋아요</td>
            <td><span id="likecount"><%=like %></span></td>
        </tr>
        <tr>
            <td>내용</td>
            <td><%=content %></td>
        </tr>
        <tr>
            <td colspan="2">
            <%
            	if(userid.equals((String)session.getAttribute("userid"))){
            %>
            <input type="button" value="수정" onclick="location.href='./edit.jsp?index=<%=index%>'"> 
            <input type="button" value="삭제" onclick="location.href='./delete_ok.jsp?index=<%=index%>'">
            <%
            	}
            %>
            <input type="button" value="좋아요" id="like">
            <input type="button" value="리스트" onclick="location.href='./list.jsp'">
            </td>
        </tr>
    </table>
    <hr/>
    <form method="post" action="reply_ok.jsp">
    	<input type="hidden" name="r_index" value="<%=index %>">
    	<p>
    		<%=session.getAttribute("userid") %> : 
    		<input type="text" size="40" name="r_content">
    		<input type="submit" value="확인">
    	</p>
    </form>
    <hr/>
    <%
    while(rs.next()){
    	r_index = rs.getString("r_index");
    	r_boardindex = rs.getString("r_boardindex");
		r_userid = rs.getString("r_userid");
		r_content = rs.getString("r_content");
		r_regdate = rs.getString("r_regdate");
		
    %>
    	<p>
    		<%=r_userid %> : <%=r_content %> (<%=r_regdate %>) 
    		<%
            	if(r_userid.equals((String)session.getAttribute("userid"))){
            %>
		            <button onclick="location.href='./r_delete_ok.jsp?index=<%=index %>&r_index=<%=r_index%>'">삭제</button>
            <%
            	}
            %>
    	</p>
    <%
   	}
    %>
</body>
</html>