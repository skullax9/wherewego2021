<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%

String name = (String)request.getParameter("rname");
String birth = (String)request.getParameter("rbirth");
String phone = (String)request.getParameter("rphone");

boolean isNum1 = birth.trim().matches("[+-]?\\d*(\\.\\d+)?");
boolean isNum2 = phone.trim().matches("[+-]?\\d*(\\.\\d+)?");

if(name.trim() == "" || birth.trim() == "" ||  phone.trim() == ""){
	%><script>
	 alert("�Է��� �ȵ� ������ �ֽ��ϴ�.");
	 history.back();
	 </script><%
} else if (name.trim().isEmpty() == true || birth.trim().isEmpty() == true ||  phone.trim().isEmpty() == true) {
	%><script>
	 alert("�Է��� �ȵ� ������ �ֽ��ϴ�.");
	 history.back();
	 </script><%
} else if (birth.trim().length() < 8 || phone.trim().length() < 11){
	%><script>
	 alert("�ùٸ� ������ �Է��� �ּ���.");
	 history.back();
	 </script><%
} else if (isNum1 == false){
	%><script>
	 alert("��Ȯ�� ������ �Է��� �ּ���");
	 history.back();
	 </script><%
} else if (isNum2 == false){
	%><script>
	 alert("��Ȯ�� ��ȣ�� �Է��� �ּ���");
	 history.back();
	 </script><%
} else {
 
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
	 
sql = "select userID, userPassword from USER where userName = '"+name.trim()+"' and userBirth = "+birth.trim()+" and userPhone = "+phone.trim();
rs = st.executeQuery(sql);
	 
if(!(rs.next())) {
	%><script>
	 alert("��ġ�ϴ� ȸ���� �����ϴ�!");
	 history.back();
	 </script><%
} else {
String uid = rs.getString(1);
String upw = rs.getString(2);
			 %><script>
			 var id = '<%=uid%>'
			 var pw = '<%=upw%>'
			 alert("ȸ������ ���̵�� "+id+", ��й�ȣ�� "+pw+" �Դϴ�.");
			location.href="user_login.jsp";
			 </script><%
			 rs.close();
			 st.close();
			 con.close();
	}
}


%>