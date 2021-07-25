<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*,javax.swing.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");

boolean blogin = false;

String sql = null;
Connection con = null;
Statement st = null;
ResultSet rs = null;

try{
Class.forName("com.mysql.cj.jdbc.Driver");

String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();
	 
sql = "select UserID,UserPassword,userNick from USER where UserID ='"+id+"'";
	 
rs = st.executeQuery(sql);
	 
	 while (rs.next()) {
		 String uid = rs.getString(1);
		 String upw = rs.getString(2);
		 String unick = rs.getString(3);
		 
		 if ((id.equals(uid)) && pw.equals(upw)){
			 blogin = true;
			 session.setAttribute("userID",unick); // 로그인 성공시 userID란 변수에 사용자의 id 값 저장
			 
			 %><script>
			 location.href="index.jsp";
			 </script>
			 <%
			 //로그인 유지 여부 세션저장
			 if (blogin) {
				 	session.setAttribute("blogin","success");
			 }
		 } else {
			 %>
			 <script>
			 alert("ID 혹은 비밀번호가 일치하지 않습니다.");
			 location.href="user_login.jsp";
			 </script>
			 <%
		 }
	 }
} catch(NullPointerException e) { %>
<script>
alert("정상적인 경로를 이용해 주세요");
location.href="index.jsp";
</script>
<%} catch(SQLException e) { %>
<script>
alert("정상적인 경로를 이용해 주세요");
location.href="index.jsp";
</script>
<%}finally {
if (st != null) try { st.close(); } catch(SQLException ex) {}
if (con != null) try { con.close(); } catch(SQLException ex) {} 
}
%>%>


