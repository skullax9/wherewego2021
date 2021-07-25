<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*,javax.swing.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<%
String nick = (String)session.getAttribute("userID");
String pw = request.getParameter("pw");

String sql = null;
Connection con = null;
Statement st = null;
ResultSet rs = null;

Class.forName("com.mysql.cj.jdbc.Driver");

String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();
	 
sql = "select userPassword from USER where userNick ='"+nick+"' and userPassword = '"+pw+"';";
	 
rs = st.executeQuery(sql);

if (!(rs.next())) {%>
	<script>
	alert("비밀번호가 틀렸습니다.");
	history.back();
	</script>
<% } else { 
	String userpw = rs.getString(1);
	
	if (userpw.equals(pw) || pw.equals(userpw)){
%>
	<script>
	location.href = "user_myPage.jsp";
	</script>
<%}
}
	 
rs.close();
st.close();
con.close();
%>


