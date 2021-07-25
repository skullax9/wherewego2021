<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>어디갈까?</title>
    
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="./js/banner.js"></script>
    <%request.setCharacterEncoding("utf-8");
    String userID = null;
	if(session.getAttribute("userID")!=null){
	userID = (String) session.getAttribute("userID");
	} else if (userID == null){%>
		<script>alert("로그인 후 이용해 주시기 바랍니다."); location.href="user_login.jsp";</script>
	<% }%>
</head>
<body>
<%
Vector poid=new Vector();
Vector type=new Vector();
Vector title=new Vector();
Vector user=new Vector();
Vector date=new Vector();

long id=0;

int where=1;
int totalgroup=0;
int maxpages=5;
int startpage=1;
int endpage=startpage+maxpages-1;
int wheregroup=1;
if (request.getParameter("go") != null) {
 where = Integer.parseInt(request.getParameter("go"));
 wheregroup = (where-1)/maxpages + 1;
 startpage=(wheregroup-1) * maxpages+1;  
 endpage=startpage+maxpages-1; 
} else if (request.getParameter("gogroup") != null) {
 wheregroup = Integer.parseInt(request.getParameter("gogroup"));
 startpage=(wheregroup-1) * maxpages+1;  
 where = startpage ; 
 endpage=startpage+maxpages-1; 
}
int nextgroup=wheregroup+1;
int priorgroup= wheregroup-1;

int startrow=0;
int endrow=0;
int maxrows=10;
int totalrows=0;
int totalpages=0;


String sql = null;
Connection con = null;
ResultSet rs = null;
Statement st = null;
int total = 0;


Class.forName("com.mysql.cj.jdbc.Driver");


String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
String dbID = "";
String dbPassword = "";
con=DriverManager.getConnection(dbURL, dbID, dbPassword);
st = con.createStatement();
sql = "select count(*) from BOARD";
rs = st.executeQuery(sql);

if (rs.next()) {
	total = rs.getInt(1);
}

String listSQL = "select postID,category, postTITLE, userID, date_format(postDATE,'%Y-%m-%d') from BOARD order by postID DESC;";
rs = st.executeQuery(listSQL);

%>

   <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
   
 <div id="warp" style="margin-top:30px">
    <div>
        <center>
        <h3 class="board3text">게시판</h3>
        </center>
        
    </div>
    <!--
    <div class="select_comm">
        <select name="selectBox" id="selectBox" class="select_button1" onchange="change()">
            <option value="0">전체</option>
            <option value="1">자유</option>
            <option value="2">공유</option>
            <option value="3">기타</option>
        </select>
    </div>
    -->
        <div class="container" style="margin-top:30px">
        <div class = "row">
        <table class="table table-hover" style="text-align:center; border-top:2px solid #808080; width: 1140px;"> 
            <thead>
                <tr>
                    <th style="background-color: #FFFFFF; text-align: center; margin:0; padding: 0;">카테고리</th>
                    <th style="background-color: #FFFFFF; text-align: center; margin:0; padding: 0; width:395px;">제목</th>
                    <th style="background-color: #FFFFFF; text-align: center; margin:0; padding: 0;">작성자</th>
                    <th style="background-color: #FFFFFF; text-align: center; margin:0; padding: 0;">작성시간</th>
                </tr>
            </thead>
    <% 
        if(!(rs.next())) {%>
            <tr>
                <td>NO DATA</td>
                <td>NO DATA</td>
                <td>NO DATA</td>
                <td>NO DATA</td>
            </tr>
    <%} else {
    	do{
    		poid.addElement(new Long(rs.getLong("postID")));
    		type.addElement(rs.getString("category"));
	    	title.addElement(rs.getString("postTITLE"));
	   		user.addElement(rs.getString("userID"));
	    	date.addElement(rs.getString("date_format(postDATE,'%Y-%m-%d')"));
	    }
            	while(rs.next());
    
                totalrows = title.size();
                totalpages = (totalrows-1)/maxrows +1;
                startrow = (where-1) * maxrows;
                endrow = startrow+maxrows-1  ;
                if (endrow >= totalrows)
                 endrow=totalrows-1;
                totalgroup = (totalpages-1)/maxpages +1;
                if (endpage > totalpages) 
                 endpage=totalpages;
                for(int j=startrow;j<=endrow;j++) {
                    id= ( (Long)poid.elementAt(j) ).longValue();
                    
                    out.println("<TR>");
                    out.println("<TD class='board_table_td' style='margin:0; padding: 0;'>["+type.elementAt(j)+"]</TD>");
                    out.println("<TD style='margin:0; padding: 0;'><a class='board_table_a' href='board_detail.jsp?postID="+id+"'>"+title.elementAt(j)+"</a></TD>");
                    out.println("<TD class='board_table_td' style='margin:0; padding: 0;'>"+user.elementAt(j)+"</TD>");
                    out.println("<TD class='board_table_td' style='margin:0; padding: 0;'>"+date.elementAt(j)+"</TD>");
                    out.println("</TR>"); 
                    }
            	}
            	rs.close();
    	
    %>
                </table>
            </div>
                <a href = "board_write.jsp" class="btn btn-info pull-right" style="background-color: #004c66; border: none;">글쓰기</a>
        </div>
        <div class="pagination" style="justify-content:center; margin-left:130px;">
       		<nav aria-label="Page navigation example">
  				<ul class="pagination">
        			<%if (wheregroup > 1) {%>
                	  <li class="page-item">
      					<a class="page-link" href="board.jsp?gogroup=<%=priorgroup %>">◀</a>
    				  </li>
                	 <%} else { %>
                	  <li class="page-item">
      					<a class="page-link">◀</a>
    				  </li>
                	 <%}
                	 
                	 if (totalrows !=0) {  
                	  for(int jj=startpage; jj<=endpage; jj++) {
                	   if (jj==where) {%>
                	    <li class="page-item"><a class="page-link" href="#"><%=jj %></a></li>
                	   <%} else { %>
                   	    <li class="page-item"><a class="page-link" href="board.jsp?go=<%=jj%>"><%=jj %></a></li>
                	   <%}
                	  } 
                	 }
                	 if (wheregroup < totalgroup) { %>
                	  <li class="page-item">
      					<a class="page-link" href="board.jsp?gogroup=<%=nextgroup %>">▶</a>
    				  </li>
                	 <% } else {%>
                	  <li class="page-item">
      					<a class="page-link">▶</a>
    				  </li>
                	 <% } %>
  				</ul>
               </nav>
          	</div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>