<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html lang="en">
<head>
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
</head>
<body>
	<% request.setCharacterEncoding("utf-8");
	// 클릭한 게시글 ID를 받아옴.
	try{
	int num = Integer.parseInt(request.getParameter("postID"));
    String userID = null;
	if(session.getAttribute("userID")!=null){
	userID = (String) session.getAttribute("userID");
	}
	%>	
	<script>
		function button_check() {
			if (confirm("정말 삭제하시겠습니까??") == true){
				location.href="notice_delete.jsp?postID="+<%=num%>;
			} else {
				return;
			}
		};
	</script>
	<%String sql = null;
	Connection con = null;
	ResultSet rs = null;
	Statement st = null;
	int total = 0;
	
	try{
	Class.forName("com.mysql.cj.jdbc.Driver");

	String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
	String dbID = "";
	String dbPassword = "";
	con=DriverManager.getConnection(dbURL, dbID, dbPassword);
	st = con.createStatement();
	sql = "select postTITLE, postCONTENT from ANNOUNCEMENT where postID = "+num;
	rs = st.executeQuery(sql);

	rs.next();
		
	String pTITLE = rs.getString(1);	
	String pCONTENT = rs.getString(2);
	
	%>
      <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
      
     <div id="warp" style="margin-top:30px"> 
     	<div>
        	<center>
        	<h3 class="board3text">공지사항</h3>
        	</center>
    	</div>
    	<div class="container" style="margin-top:30px;">
			<table class="table" style="text-align: center;">
				<tr>
					<td style="border: none;">
						<input type="text" class="form-control" name="postT" maxlength="100" value="<%=pTITLE%>" disabled/>
					</td>
				</tr>
				<tr>
					<td>
						<textarea class="form-control" name="postC" maxlength="2048" placeholder="<%=pCONTENT%>" style="height: 400px;" disabled></textarea>
					</td>
				</tr>
			</table>
			<div class="dropdown">
  					<button class="btn btn-secondary dropdown-toggle pull-right" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    					더보기
  					</button>
  					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    				<a class="dropdown-item" href="notice.jsp">뒤로가기</a>
    				<% 
                		if ((userID != null) && (userID.equals("admin"))){%>
                		<a class="dropdown-item" onclick="button_check();">삭제하기</a>
                	<%} %>
  					</div>
			</div>
		</div>
	</div>
	
	<%
   if (st != null) try { st.close(); } catch(SQLException ex) {}
   if (con != null) try { con.close(); } catch(SQLException ex) {} 
} catch (NullPointerException e) { %>
	<script>
	alert("정상적인 경로를 이용해 주세요");
	location.href="index.jsp";
	</script>
<%} catch (SQLException e) { %>
<script>
alert("정상적인 경로를 이용해 주세요");
location.href="index.jsp";
</script>
<%} 
	   } catch (NumberFormatException e) { %>
	   <script>
	   alert("정상적인 경로를 이용해 주세요");
	   location.href="index.jsp";
	   </script>
	   <%}
	   
%> 
<jsp:include page="footer.jsp" />
</body>
</html>
