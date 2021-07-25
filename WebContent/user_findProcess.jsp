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
	 alert("입력이 안된 사항이 있습니다.");
	 history.back();
	 </script><%
} else if (name.trim().isEmpty() == true || birth.trim().isEmpty() == true ||  phone.trim().isEmpty() == true) {
	%><script>
	 alert("입력이 안된 사항이 있습니다.");
	 history.back();
	 </script><%
} else if (birth.trim().length() < 8 || phone.trim().length() < 11){
	%><script>
	 alert("올바른 정보를 입력해 주세요.");
	 history.back();
	 </script><%
} else if (isNum1 == false){
	%><script>
	 alert("정확한 생일을 입력해 주세요");
	 history.back();
	 </script><%
} else if (isNum2 == false){
	%><script>
	 alert("정확한 번호를 입력해 주세요");
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
	 alert("일치하는 회원이 없습니다!");
	 history.back();
	 </script><%
} else {
String uid = rs.getString(1);
String upw = rs.getString(2);
			 %><script>
			 var id = '<%=uid%>'
			 var pw = '<%=upw%>'
			 alert("회원님의 아이디는 "+id+", 비밀번호는 "+pw+" 입니다.");
			location.href="user_login.jsp";
			 </script><%
			 rs.close();
			 st.close();
			 con.close();
	}
}


%>