<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
String userID = (String)session.getAttribute("userID");
 
String postT = (String)request.getParameter("postT");
String postC = (String)request.getParameter("postC");
String postP = (String)request.getParameter("postP");

String sql = null;
Connection con = null;
ResultSet rs = null;
Statement st = null;

if((postT == null) || (postC == null) || (postP == null) || (postT.trim().isEmpty() == true) || (postC.trim().isEmpty() == true) || (postP.trim().isEmpty() == true)) {%>
	<script>alert("빈 칸은 허용되지 않습니다!"); history.back();</script>
<%} else{
 
try {
Class.forName("com.mysql.cj.jdbc.Driver");
String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();
	 
sql = "INSERT into ASK(postTITLE,userID,postCONTENT,postPW) values ('"+postT.trim()+"','"+userID+"','"+postC.trim()+"','"+postP.trim()+"')";
	 
st.executeUpdate(sql);
%>
	 <script>
	 	alert("글 작성이 완료되었습니다!");
	 	location.href="ask.jsp";
	 </script>	 
	 
<%} catch(NullPointerException e) { %>
<script>
alert("정상적인 경로를 이용해 주세요");
location.href="index.jsp";
</script>
<%} finally {
if (st != null) try { st.close(); } catch(SQLException ex) {}
if (con != null) try { con.close(); } catch(SQLException ex) {} 
} 
}
%> 
