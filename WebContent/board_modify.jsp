<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>��𰥱�?</title>
    
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="./js/banner.js"></script>
</head>
<body>
<jsp:include page="Header.jsp" /> <!-- �޴� -->
<% request.setCharacterEncoding("utf-8");
// Ŭ���� �Խñ� ID�� �޾ƿ�.
try{
int num = Integer.parseInt(request.getParameter("postID"));
session.setAttribute("pid",num);
String userID = null;
	if(session.getAttribute("userID")!=null){
	userID = (String) session.getAttribute("userID");
	} else if (userID == null){%>
		<script>alert("�α��� �� �̿��� �ֽñ� �ٶ��ϴ�."); location.href="user_login.jsp";</script>
	<% }
   String sql = null;
   Connection con = null;
   ResultSet rs = null;
   Statement st = null;
   int total = 0;
   int totalc = 0;
try{
   Class.forName("com.mysql.cj.jdbc.Driver");

   String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
   String dbID = "";
   String dbPassword = "";
   con=DriverManager.getConnection(dbURL, dbID, dbPassword);
   st = con.createStatement();
   sql = "select postTITLE, postCONTENT from BOARD where postID = "+num+"  and userID= '"+userID+"';";
   rs = st.executeQuery(sql);

   rs.next();
      
   String pTITLE = rs.getString(1);   
   String pCONTENT = rs.getString(2);
   %>
   
	<div id="warp" style="margin-top:30px"> 
     	<div>
        	<center>
        	<h3 class="board3text">�Խ���</h3>
        	</center>
    	</div>
    	<div class="container" style="margin-top:30px;">
		<form class = "ss" method="post" action="board_update.jsp?postID=<%=num%>">
			<table class="table" style="text-align: center;">
				<input type="hidden" id="type" name="select1" value="">
				<tr>
					<td style="border: none; display: flex;">
						<input type="text" class="form-control" placeholder="�� ����" name="postT" maxlength="100" value="<%=pTITLE%>"/>
						<select name="selectBox" id="selectBox" class="select_button2" onchange="selected2();">
           					<option value="����">����</option>
           					<option value="����">����</option>
            				<option value="����">����</option>
            				<option value="��Ÿ">��Ÿ</option>
        				</select>
					</td>
				</tr>
				<script type="text/javascript">
				var element = document.getElementsByClassName("ss");
				var type = document.getElementById("type");
				
				function selected2() {
					var sel = document.getElementById("selectBox");
					var val = sel.options[sel.selectedIndex].value;		
					
					type.value = val;
				}
				
				</script>
				<tr>
					<td>
						<textarea class="form-control" placeholder="�� ����" name="postC" maxlength="2048" style="height: 400px; resize: none; overflow-x:hidden; overflow-y:auto;"><%=pCONTENT %></textarea>
					</td>
				</tr>
			</table>
			<a class="btn btn-primary pull-right" href="board.jsp">�ڷΰ���</a>

			<input type="submit" class="btn btn-info pull-right" value="����ϱ�">
		</form>
		</div>
	</div>
<% if (st != null) try { st.close(); } catch(SQLException ex) {}
   if (con != null) try { con.close(); } catch(SQLException ex) {} 
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
<%} 
	   } catch (NumberFormatException e) { %>
	   <script>
	   alert("�������� ��θ� �̿��� �ּ���");
	   location.href="index.jsp";
	   </script>
	   <%}
	   
%> 
	<jsp:include page="footer.jsp" />
</body>
</html>