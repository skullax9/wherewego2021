<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*,javax.swing.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>어디갈까?</title>
    
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
 	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
 	<%
	String nick = (String)session.getAttribute("userID");

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
	
	if (nick == null) {%>
		<script>
		alert("로그인 후 이용해 주세요.");
		location.href="user_login.jsp";
		</script>
 	<%} else if (!(rs.next())) {%>
	<script>
	location.href = "user_snsMyPage.jsp";
	</script>
	<% } else { %>

	<%}
	 
	rs.close();
	st.close();
	con.close();
	%>
</head>
<body>
<jsp:include page="Header.jsp" /> <!-- 메뉴 -->
<div id="warp">
    <div>
       <form method="post" action="user_pwCheck.jsp">
    <center>
     <input type="password" class="form-control" placeholder="PW" name="pw" style="width:300px; margin-top:50px;">
    
    <input type="submit" class="btn btn-primary form-control" value="확인" style="width:300px; margin-top:20px; background-color: #00394d; border: 0">
   </form>
   </center>
   </div>
   </div>
</body>
</html>