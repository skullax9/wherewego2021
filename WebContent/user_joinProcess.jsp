<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
String id = (String)request.getParameter("registerID");
String pw = (String)request.getParameter("userPassword");
String pwc = (String)request.getParameter("userPasswordC");
String name = (String)request.getParameter("userName");
String nick = (String)request.getParameter("userNick");
String birth = (String)request.getParameter("userBirth");
String phone = (String)request.getParameter("userPhone");

boolean isNum1 = birth.trim().matches("[+-]?\\d*(\\.\\d+)?");
boolean isNum2 = phone.trim().matches("[+-]?\\d*(\\.\\d+)?");


if(id.trim() == "" || pw.trim() == "" || pwc.trim() == "" || name.trim() == "" || nick.trim() == "" || birth.trim() == "" ||  phone.trim() == ""){
	%><script>
	 alert("입력이 안된 사항이 있습니다.");
	 history.back();
	 </script><%
} else if (id.trim().isEmpty() == true || pw.trim().isEmpty() == true || pwc.trim().isEmpty() == true || name.trim().isEmpty() == true || nick.trim().isEmpty() == true || birth.trim().isEmpty() == true ||  phone.trim().isEmpty() == true) {
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
	 
sql = "select userID, userNick from USER";
	 
rs = st.executeQuery(sql);
	 
rs.next();

String uid = rs.getString(1);
String unick = rs.getString(2);

	if (id.trim().equals(uid)) {
	%><script>
	 alert("이미 사용중인 ID입니다.");
	 history.back();
	 </script><%
	} else if (!(pw.trim().equals(pwc.trim()))){
			 %><script>
			 alert("비밀번호가 일치하지 않습니다.");
			 history.back();
			 </script><%
	} else if (nick.trim().equals(unick)){
		 %><script>
		 alert("이미 사용중인 닉네임 입니다.");
		 history.back();
		 </script><%
	} else {
		try {
			 st.executeUpdate("insert into USER values('"+id.trim()+"','"+pw.trim()+"','"+name.trim()+"','"+nick.trim()+"','"+birth.trim()+"','"+phone.trim()+"')");
			 %><script>
			 alert("회원가입을 축하합니다!");
			location.href="user_login.jsp";
			 </script><%
			 
		} catch (SQLException s) {
		    System.out.println("!! SQL Syntax err");
		    s.printStackTrace();
		}
	}
	 
st.close();
con.close();
}
%>