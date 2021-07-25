<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>
 <% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>어디갈까?</title>
    
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/detail.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="../js/banner.js"></script>
</head>
<body>
    <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
    <div id="warp">
        <div class="main-box-name">#겨울 <!-- 자바 스크립트? --> </div>
        <hr class="hr1">
        
        <div>
            <ul class="season_ul">
<%
Vector wtid=new Vector();
Vector wtimg=new Vector();
Vector wtlocation=new Vector();
Vector wtplace=new Vector();

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
int maxrows=6;
int totalrows=0;
int totalpages=0;


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
sql = "select id,img, location, place from SEASON where tag ='winter';";
rs = st.executeQuery(sql);

if(!(rs.next())) {%>
	<li class="season_li">  <!-- li당 하나씩 -->
		<a href="#" class="season_box">
			<img src="https://www.malaysiaforyou.com/files/attach/images/848/848/7dbcb6c10550f242552e934d49c43f12.jpg" alt="">
			<span class="season_span1">준비중입니다.</span>
			<span>준비중입니다.</span>
		</a>
    </li>
<%}else {
do{
	wtid.addElement(new Long(rs.getLong("id")));
	wtimg.addElement(rs.getString("img"));
	wtlocation.addElement(rs.getString("location"));
	wtplace.addElement(rs.getString("place"));
}

while(rs.next());

totalrows = wtplace.size();
totalpages = (totalrows-1)/maxrows +1;
startrow = (where-1) * maxrows;
endrow = startrow+maxrows-1  ;
if (endrow >= totalrows)
 endrow=totalrows-1;
totalgroup = (totalpages-1)/maxpages +1;
if (endpage > totalpages) 
 endpage=totalpages;

for(int j=startrow;j<=endrow;j++) {
    id= ( (Long)wtid.elementAt(j) ).longValue();
%>

                <li class="season_li">  <!-- li당 하나씩 -->
                    <a href="place_detail.jsp?location=<%=wtlocation.elementAt(j) %>" class="season_box">
                        <img src="<%=wtimg.elementAt(j) %>" alt="">
                        <span class="season_span1"><%=wtlocation.elementAt(j) %></span>
                        <span><%=wtplace.elementAt(j) %></span>
                    </a>
                </li>
                <%}
				}
				rs.close();%>
            </ul>
        </div>

          <!-- 부트스트랩 페이지네이션 -->
          <div class="pagination" style="justify-content:center;">
        	<nav aria-label="Page navigation example">
  				<ul class="pagination">
        			<%if (wheregroup > 1) {%>
                	  <li class="page-item">                    
      					<a class="page-link" href="season_winter.jsp?gogroup=<%=priorgroup %>">◀</a>
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
                   	    <li class="page-item"><a class="page-link" href="season_winter.jsp?go=<%=jj%>"><%=jj %></a></li>
                	   <%}
                	  } 
                	 }
                	 if (wheregroup < totalgroup) { %>
                	  <li class="page-item">
      					<a class="page-link" href="season_winter.jsp?gogroup=<%=nextgroup %>">▶</a>
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