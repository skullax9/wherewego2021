<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*,javax.swing.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<%
String nick = (String)session.getAttribute("userID");
String pw = request.getParameter("pw");
String pwc = request.getParameter("pwc");
String birth = request.getParameter("birth");
String phone = request.getParameter("phone");

boolean isNum1 = birth.trim().matches("[+-]?\\d*(\\.\\d+)?");
boolean isNum2 = phone.trim().matches("[+-]?\\d*(\\.\\d+)?");

if(pw.trim() == "" || pwc.trim() == "" || birth.trim() == "" ||  phone.trim() == ""){
	%><script>
	 alert("�Է��� �ȵ� ������ �ֽ��ϴ�.");
	 history.back();
	 </script><%
} else if (pw.trim().isEmpty() == true || pwc.trim().isEmpty() == true || birth.trim().isEmpty() == true ||  phone.trim().isEmpty() == true) {
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
}
if (pw.equals(pwc) || pwc.equals(pw)){

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
	 
sql = "UPDATE USER SET userPassword = '"+pw.trim()+"', userBirth = "+birth.trim()+", userPhone = "+phone.trim()+" WHERE userNick = '"+nick+"';";
	 
st.executeUpdate(sql);

%>
	<script>
	alert("������ �Ϸ�Ǿ����ϴ�.");
	location.href="index.jsp";
	</script>
<% 

st.close();
con.close();
}
	

%>


