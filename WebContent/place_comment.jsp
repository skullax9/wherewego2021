<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
 String userID = (String)session.getAttribute("userID");
 if(session.getAttribute("userID")!=null){
	userID = (String) session.getAttribute("userID");
	} else if (userID == null){%>
		<script>alert("�α��� �� �̿��� �ֽñ� �ٶ��ϴ�."); location.href="user_login.jsp";</script>
	<%}

String location = (String)request.getParameter("pla");
String com = (String)request.getParameter("commentary");

if (location == null) {%>
	<script>alert("�˼����� ������ �߻��߽��ϴ�.")</script>
<%} else {


if(com == null || (com.trim().isEmpty() == true) || userID == null || userID == "") {%>
	<script>alert("����� �Է��� �ּ���!"); history.back();</script>
<%} else{

String sql = null;
Connection con = null;
ResultSet rs = null;
Statement st = null;
try{
Class.forName("com.mysql.cj.jdbc.Driver");
String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();
	 
sql = "INSERT into PLACEREPLY(place,replytext,replyer) values ('"+location+"','"+com.trim()+"','"+userID+"')";

st.executeUpdate(sql);
%>
<script>
history.back();
</script>	
<%
} catch(NullPointerException e) { %>
	<script>
	alert("�������� ��θ� �̿��� �ּ���");
	location.href="index.jsp";
	</script>
<%}finally {
	if (st != null) try { st.close(); } catch(SQLException ex) {}
    if (con != null) try { con.close(); } catch(SQLException ex) {} 
}}} 
%>
	  