<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
 String sql = null;
 Connection con = null;
 ResultSet rs = null;
 Statement st = null;
 
// �α��ε� ID ���ǰ�, �Խñ� ID�� �Ѱܹ���.
String userID = (String)session.getAttribute("userID");

try {
int num = Integer.parseInt(request.getParameter("postID"));

Class.forName("com.mysql.cj.jdbc.Driver");
String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();

sql = "select userID from ANNOUNCEMENT where postID = "+num;
	 
rs = st.executeQuery(sql);

rs.next();
String uID = rs.getString(1);

if ((uID.equals(userID)) || userID.equals("admin")) {
	String nextSQL = "delete from ANNOUNCEMENT where postID = "+num;
	st.executeUpdate(nextSQL);
	%>
	 <script>
	 	alert("������ �Ϸ�Ǿ����ϴ�!");
	 	location.href="notice.jsp";
	 </script>	 
<%}
} catch(NullPointerException e) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
location.href="index.jsp";
</script>
<%} catch(NumberFormatException e) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
location.href="index.jsp";
</script>
<%} finally {
if (st != null) try { st.close(); } catch(SQLException ex) {}
if (con != null) try { con.close(); } catch(SQLException ex) {} 
}
%>
