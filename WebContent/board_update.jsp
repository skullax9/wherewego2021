<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
try{
int num = Integer.parseInt(request.getParameter("postID"));
String userID = (String)session.getAttribute("userID");
 
String postT = (String)request.getParameter("postT");
String postC = (String)request.getParameter("postC");
String text = request.getParameter("select1");

if((postT == null) || (postC == null) || (text == null) || (postT.trim().isEmpty() == true) || (postC.trim().isEmpty() == true)) {%>
<script>alert("�� ĭ�� ������ �ʽ��ϴ�!"); history.back();</script>
<%} else if ((text.equals("����")) || (text == null) || (text.equals(""))){%>
<script>alert("ī�װ��� ������ �ּ���!"); history.back();</script>
<%} else{

String sql = null;
Connection con = null;
ResultSet rs = null;
Statement st = null;

Class.forName("com.mysql.cj.jdbc.Driver");
String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	 
st = con.createStatement();
	 
sql = "update BOARD set category = '"+text+"', postTITLE ='"+postT.trim()+"', postCONTENT = '"+postC.trim()+"' where postID ="+num;
	 
st.executeUpdate(sql);
%>
	 <script>
	 	alert("������ �Ϸ�Ǿ����ϴ�!");
	 	location.href="board.jsp";
	 </script>	 
	 
<%	
if (st != null) try { st.close(); } catch(SQLException ex) {}
if (con != null) try { con.close(); } catch(SQLException ex) {} 
}
} catch (NullPointerException e) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
location.href="index.jsp";
</script>
<%} catch (SQLException e) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
location.href="index.jsp";
</script>
<%} catch (NumberFormatException e) { %>
   <script>
   alert("�������� ��θ� �̿��� �ּ���");
   location.href="index.jsp";
   </script>
   <%}
%> 