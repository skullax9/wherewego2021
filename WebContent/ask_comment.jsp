<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
String userID = (String)session.getAttribute("userID");
String num = (String)request.getParameter("postID");
String com = (String)request.getParameter("commentary");

String sql = null;
Connection con = null;
ResultSet rs = null;
Statement st = null;

if(com == null|| (com.trim().isEmpty() == true) || userID == null || userID == "") {%>
	<script>alert("댓글을 입력해 주세요!"); history.back();</script>
<%} else{
try {
Class.forName("com.mysql.cj.jdbc.Driver");
String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();
	 
sql = "INSERT into ASKREPLY(bno,replytext,replyer) values ("+num+",'"+com+"','"+userID+"')";
st.executeUpdate(sql);
} catch(NullPointerException e) { %>
	<script>
	alert("정상적인 경로를 이용해 주세요");
	location.href="index.jsp";
	</script>
<%} finally {
	if (st != null) try { st.close(); } catch(SQLException ex) {}
    if (con != null) try { con.close(); } catch(SQLException ex) {} 
}
%>
	 <script>
	 location.href="ask_detail.jsp?postID="+<%=num%>;
	 </script>	 
	 <%}%>