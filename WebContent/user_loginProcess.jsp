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
			 session.setAttribute("userID",unick); // �α��� ������ userID�� ������ ������� id �� ����
			 
			 %><script>
			 location.href="index.jsp";
			 </script>
			 <%
			 //�α��� ���� ���� ��������
			 if (blogin) {
				 	session.setAttribute("blogin","success");
			 }
		 } else {
			 %>
			 <script>
			 alert("ID Ȥ�� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			 location.href="user_login.jsp";
			 </script>
			 <%
		 }
	 }
} catch(NullPointerException e) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
location.href="index.jsp";
</script>
<%} catch(SQLException e) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
location.href="index.jsp";
</script>
<%}finally {
if (st != null) try { st.close(); } catch(SQLException ex) {}
if (con != null) try { con.close(); } catch(SQLException ex) {} 
}
%>%>


