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
    <title>��𰥱�?</title>
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
      <jsp:include page="Header.jsp" /> <!-- �޴� -->
      <%
    request.setCharacterEncoding("utf-8");
   // Ŭ���� �Խñ� ID�� �޾ƿ�.
	try{
   int num = Integer.parseInt(request.getParameter("postID"));
   session.setAttribute("pid",num);
   String userID = null;
	if(session.getAttribute("userID")!=null){
	userID = (String) session.getAttribute("userID");
	} else if (userID == null){%>
		<script>alert("�α��� �� �̿��� �ֽñ� �ٶ��ϴ�."); location.href="user_login.jsp";</script>
	<% } %>

	       <script>
		function button_check() {
			if (confirm("���� �����Ͻðڽ��ϱ�??") == true){
				location.href="ask_delete.jsp?postID="+<%=num%>;
			} else {
				return;
			}
		};
	</script>
	<% String sql = null;
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
	   sql = "select postTITLE, userID ,postCONTENT,postPW from ASK where postID = "+num;
	   rs = st.executeQuery(sql);

	   rs.next();
	      
	   String pTITLE = rs.getString(1);   
	   String uID = rs.getString(2);
	   String pCONTENT = rs.getString(3);
	   String pPW = rs.getString(4);
	   %>
	   
		<script type="text/javascript">
			var uid = '<%=userID%>';
			var pw = '<%=pPW%>'
	   		$(document).ready(function() {
	   			if (!(uid == 'admin')){
					var pass1 = prompt('��ȣ�� �Է��Ͻʽÿ�',''); // �ʱ�� ��ȣ ����� ��Ʈ
					if (!pass1) 
					history.go(-1);
					if (pass1 == pw) { // ��ȣ����
			
					} else{
						alert('��ȣ�� �ùٸ��� �ʽ��ϴ�!'); // �ʱ�� ��ȣ ����� ��Ʈ
						history.back();
					}
	   			}
	   		}
	    	);
		</script>
      
     <div id="warp" style="margin-top:30px"> 
        <div>
           <center>
           <h3 class="board3text">�Խ���</h3>
           </center>
       </div>
       <div class="container" style="margin-top:30px;">
         <table class="table" style="text-align: center;">
            <tr>
               <td style="border: none;">
                  <input type="text" class="form-control" name="postT" maxlength="100" value="<%=pTITLE%>" readonly="readonly"/>
               </td>
            </tr>
            <tr>
               <td>
                  <textarea class="form-control" name="postC" maxlength="2048" style="height: 400px; resize: none; overflow-x:hidden; overflow-y:auto;" readonly="readonly"><%=pCONTENT%></textarea>
               </td>
            </tr>
         </table>
            <div class="dropdown" style="margin-bottom: 60px">
                 <button class="btn btn-secondary dropdown-toggle pull-right" style="margin-left: 5px;" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   ������
                 </button>
                 
                 <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item" href="ask.jsp">�ڷΰ���</a>
                <% 
                   rs.close();
                   if ((userID.equals(uID)) || (userID.equals("admin"))){%>
                   <a class="dropdown-item" href="#">�����ϱ�</a>
                <a class="dropdown-item" onclick="button_check();">�����ϱ�</a>
                <%}%>
                 </div>
            </div>
      </div>
 
      <%
      sql = "select count(*) from ASKREPLY where bno="+num;
      rs = st.executeQuery(sql);
      
      if (rs.next()) {
    		totalc = rs.getInt(1);
      }
      
      if (totalc < 1) {%>
        <div class="comment-function" style="margin-left: 95px;">
        <table class="comment-box_table-st">
    	  <caption>��ϵ� ����� �����ϴ�. </caption>
    	</table>
    	</div>
      <%
      } else {
    	  String listSQL = "SELECT replytext, replyer, regdate FROM `ASKREPLY` where bno ="+num+" order by replyid;";
          rs = st.executeQuery(listSQL);
          
          while(rs.next()){
          
          String rtext = rs.getString(1);
          String rid = rs.getString(2);
          String rdate = rs.getString(3);
          
      %>
      <div class="comment-function" style="margin-left: 95px;">
      
        <table class="comment-box_table-st">
    	  <caption></caption>
    	  <tr class="comment-box4">
            <td class="comment-box2"><%=rid%></td> 
            <td class="comment-box3"><%=rdate %></td>
            <td>    </td> <!-- ���� -->
        </tr>
        <tr>
            <td class="comment-box1" colspan="3"><%=rtext %></td> 
        </tr>
        
    </table>
    </div>
      <%}
          }
      %>
        
     <div class="write-comment" style="margin-left: 95px;">
            <form action="ask_comment.jsp?postID=<%=num %>" class="write-comment1-1" method="post">
                <div class="write-comment1">��۳���</div>
                <input type="text" name="commentary">
                <button type="submit">��۵��</button>
            </form>
        </div>
      </div>
   <%
   if (st != null) try { st.close(); } catch(SQLException ex) {}
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
