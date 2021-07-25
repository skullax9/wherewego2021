<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*,javax.swing.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<%
String nick = (String)session.getAttribute("userID");

if (nick == null) {%>
	<script>
	alert("로그인 후 이용해 주세요.");
	location.href="user_login.jsp";
	</script>
<%}

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
	 
sql = "select * from USER where userNick ='"+nick+"'";
	 
rs = st.executeQuery(sql);

if (!(rs.next())) {%>
	<script>
	location.href = "user_snsMyPage.jsp";
	</script>
<% } else { %>
	<script>
	location.href = "user_myPassword.jsp";
	</script>
<%}
	 
rs.close();
st.close();
con.close();
%>


