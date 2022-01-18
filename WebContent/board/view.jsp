<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	String index = request.getParameter("b_index");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	String userid = null;
	String title = null;
	String content = null;
	String regdate = null;
	String date = null;
	int like = 0;
	int hit = 0;
	
	int count = 0;
	
	try {
		conn = Dbconn.getConnection();
		
		if(conn != null){
			sql = "select b_hit from tb_board where b_index=?";
	       	pstmt = conn.prepareStatement(sql);
	       	pstmt.setString(1, index);
	       	rs = pstmt.executeQuery();
	       	if(rs.next()){
	       		count = rs.getInt(1);
	       		count++;
	       	}
	       	
	       	sql = "update tb_board set b_hit=? where b_index=?";
	       	pstmt = conn.prepareStatement(sql);
	       	pstmt.setInt(1, count);
	       	pstmt.setString(2, index);
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
            <td colspan="2"><input type="button" value="수정"> 
            <input type="button" value="삭제">
            <input type="button" value="좋아요" id="like">
            <input type="button" value="리스트" onclick="location.href='./list.jsp'">
            </td>
        </tr>
    </table>
    
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
</body>
</html>