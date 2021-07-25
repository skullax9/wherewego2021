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
        <div class="main-box-name">#봄 <!-- 자바 스크립트? --> </div>
        <hr class="hr1">
        
        <div>
            <ul class="season_ul">
<%
Vector spid=new Vector(); // 출력할 여행지 번호
Vector spimg=new Vector(); // 출력할 여행지 이미지
Vector splocation=new Vector(); // 출력할 여행지명
Vector spplace=new Vector(); // 출력할 여행지 간략주소

long id=0;

int where=1;
int totalgroup=0; // 전체그룹수
int maxpages=5; // 한 그룹에 포함될 페이지 수
int startpage=1; // 그룹의 시작 페이지
int endpage=startpage+maxpages-1; // 그룹의 마지막 페이지
int wheregroup=1; // 보여줄 페이지가 속해있는 그룹
if (request.getParameter("go") != null) { // 보여줄 페이지가 있을때 where 변수를 go로 설정
 where = Integer.parseInt(request.getParameter("go")); // String을 int로 변경
 wheregroup = (where-1)/maxpages + 1; //보여줄 그룹 설정
 startpage=(wheregroup-1) * maxpages+1; // 그룹의 시작 페이지
 endpage=startpage+maxpages-1;  //그룹의 마지막 페이지
 // 다음 혹은 이전 링크를 누를때 gogroup 전달, gogroup 존재시 wheregroup을 gogroup으로 설정
} else if (request.getParameter("gogroup") != null) {
 wheregroup = Integer.parseInt(request.getParameter("gogroup")); // String을 int로 변경
 startpage=(wheregroup-1) * maxpages+1;  // 그룹의 시작페이지
 where = startpage ; // 시작페이지를 where
 endpage=startpage+maxpages-1; //그룹의 마지막 페이지
}
int nextgroup=wheregroup+1; // 다음 그룹
int priorgroup= wheregroup-1; //이전 그룹

int startrow=0; // 첫 번째 행 번호
int endrow=0; // 마지막 행 번호
int maxrows=6; // 최대 보여질 행 번호
int totalrows=0; // 총 행 수
int totalpages=0; // 총 페이지


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
sql = "select id,img, location, place from SEASON where tag = 'spring'";
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
	spid.addElement(new Long(rs.getLong("id")));
	spimg.addElement(rs.getString("img"));
	splocation.addElement(rs.getString("location"));
	spplace.addElement(rs.getString("place"));
}

while(rs.next());

totalrows = spplace.size();
totalpages = (totalrows-1)/maxrows +1;
startrow = (where-1) * maxrows;
endrow = startrow+maxrows-1  ;
if (endrow >= totalrows) // 마지막 행이 총 행보다 크거나 같다면
 endrow=totalrows-1; // 마지막 행은 총 행-1
totalgroup = (totalpages-1)/maxpages +1; // 전체그룹은
if (endpage > totalpages) //마지막 페이지가 총페이지보다 클때
 endpage=totalpages; // 같다

for(int j=startrow;j<=endrow;j++) {
    id= ( (Long)spid.elementAt(j) ).longValue();
%>

                <li class="season_li">  <!-- li당 하나씩 -->
                    <a href="place_detail.jsp?location=<%=splocation.elementAt(j) %>" class="season_box"> <!-- 클릭한 여행지의 상세페이지 이동 -->
                        <img src="<%=spimg.elementAt(j) %>" alt="">
                        <span class="season_span1"><%=splocation.elementAt(j) %></span>
                        <span><%=spplace.elementAt(j) %></span>
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
        			<%if (wheregroup > 1) {%> <!-- 페이지가 속해있는 그룹이 1보다 크다면 -->
                	  <li class="page-item">                    
      					<a class="page-link" href="season_spring.jsp?gogroup=<%=priorgroup %>">◀</a> <!-- gogroup을 이전 그룹으로 활성화 -->
    				  </li>
                	 <%} else { %>
                	  <li class="page-item">
      					<a class="page-link">◀</a> <!-- UI만 남고 기능 비활성화 -->
    				  </li>
                	 <%}
                	 
                	 if (totalrows !=0) {  // 총 행이 0이 아니라면
                	  for(int jj=startpage; jj<=endpage; jj++) { // 시작페이지를  마지막페이지까지 출력한다
                	   if (jj==where) {%> <!-- 현재 페이지에 속해있다면 -->
                	    <li class="page-item"><a class="page-link" href="#"><%=jj %></a></li> <!-- 현재 페이지네이션 비활성화 -->
                	   <%} else { %> <!-- 아니라면 -->
                   	    <li class="page-item"><a class="page-link" href="season_spring.jsp?go=<%=jj%>"><%=jj %></a></li> <!-- 다른 페이지네이션 활성화 -->
                	   <%}
                	  } 
                	 }
                	 if (wheregroup < totalgroup) { %> <!-- 현재그룹이 총 그룹보다 작다면 -->
                	  <li class="page-item">
      					<a class="page-link" href="season_spring.jsp?gogroup=<%=nextgroup %>">▶</a> <!-- gogroup을 다음 그룹으로 활성화 -->
    				  </li>
                	 <% } else {%>
                	  <li class="page-item">
      					<a class="page-link">▶</a> <!-- UI만 남고 기능 비활성화 -->
    				  </li>
                	 <% } %>
  				</ul>
               </nav>
        </div>
          
    </div>

<jsp:include page="footer.jsp" />
</body>
</html>