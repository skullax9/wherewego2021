<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
    <title>어디갈까?</title>
    
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="./css/weather.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="./js/banner.js"></script>
    <% 
 	response.setHeader("Cache-Control","no-cache"); 
 	response.setHeader("Pragma","no-cache"); 
 	response.setDateHeader("Expires",0); 
	%>
</head>
<body>
 <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
    
 <div id="warp">
    <div class="banner">
        <ul><!-- 1번 -->
            <li><img src="https://post-phinf.pstatic.net/MjAxOTA5MTdfMTI0/MDAxNTY4NzA2MjgwMjEz.kKhswDsfDNpPe97pNDRkg6Dy8CZGgez6cnF667ZbyUwg.7z-VjQJFoCLqlFHK6ZGzOK6WsyuJPb2QccRbh9MJvLQg.JPEG/Busan_Haeundae.jpg?type=w1200" width="1200px" height="500px"></li>
            <!-- 2번 -->
            <li><img src="https://gtdc.or.kr/dzSmart/upfiles/Tours/2018June/25/29e592fa4b3e3494df7b7cb05394fe85_1529384816.jpg" width="1200px" height="500px"></li>
            <!-- 3번 -->
            <li><img src="https://proov.io/wp-content/uploads/2018/09/South-Korea-1200x500.jpeg" width="1200px" height="500px"></li>
            <!-- 4번 -->
            <li><img src="https://www.gtdc.or.kr/v2.1/img/travel/sightseeing/beach/01.jpg" width="1200px" height="500px"></li>
            <!-- 5번 -->
            <li><img src="http://www.gjn.kr/news/photo/201902/38229_64994_159.jpg" width="1200px" height="500px"></li>
        </ul>
    </div>
    <span class="recommendation">추천여행지</span>
    
    <div class="section">
    <%
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
	
	sql = "select img,location from SEASON where tag = 'summer' limit 6";
	rs = st.executeQuery(sql);
	
	while(rs.next()) {
		String img = rs.getString(1);
		String location = rs.getString(2);
	
	%>
        <div class="section-1" style="margin-right: 10px; margin-left: 10px;">     <div class="section-1-img"><a href="season_summer.jsp"><img src="<%=img %>" alt="<%=location%>"></a></div><div class="section-1-p"><%=location %></div></div>
    <%}
	rs.close();
	
	%>
    </div>

    <div class="section-2"><a href="ask.jsp"><img src="./images/askbanner.png" alt="제보하기"></a></div>
    <div class="section-3">
        <div>
   <% 

	sql = "select postID, postTITLE from BOARD order by postID DESC limit 5;";
	rs = st.executeQuery(sql);
	%>
            <div class="section-3-p"><div class="section-name-name">최신 게시글</div><a href="board.jsp"><div>더보기</div></a></div>
                   <table class="section-3-table" style="text-align:center; border:1px solid #000000"> 
    <% 
            	while(rs.next()){ 
            	int pID = rs.getInt(1);
                String pTITLE = rs.getString(2);
    %>
            <tr>
                <td><a class="section-3-p-p" href="board_detail.jsp?postID=<%=pID%>"><%=pTITLE %></a></td>
            </tr>
    <% 		
    			}
				rs.close();
    %>
                </table>
          </div>

        <div>
	<%
	sql = "select postID, postTITLE from ANNOUNCEMENT order by postID DESC limit 5;";
	rs = st.executeQuery(sql);
	%>
            <div class="section-3-p"><div class="section-name-name">공지사항</div><a href="notice.jsp"><div>더보기</div></a></div>
                   <table class="section-3-table" style="text-align:center; border:1px solid #000000"> 
    <% 
            	while(rs.next()){ 
            	int pID = rs.getInt(1);
                String pTITLE = rs.getString(2);
    %>
            <tr>
                <td><a class="section-3-p-p" href="notice_detail.jsp?postID=<%=pID%>"><%=pTITLE %></a></td>
            </tr>
            
    <% 		
    			}
    			rs.close();
    			st.close();
    		 	con.close();
    %>
                </table>
        </div>
    </div>

    <div class="section-4">
        <div>
        	<span class="section-4-p">실시간 교통상황</span>
        	<div id="map">
        	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a36619881080dc1ee6cfdf790ff3c6a"></script>
        	<script>
        	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        	var options = { //지도를 생성할 때 필요한 기본 옵션
        		center: new kakao.maps.LatLng(36.40214, 127.48314), //지도의 중심좌표
        		level: 13 //지도의 레벨(확대, 축소 정도) 지도가 한 눈에 보이는 레벨로 설정
        	};

        	var map = new kakao.maps.Map(container, options); 
        	
        	map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); // 지도의 옵션인 교통상황 추가
        	</script>
        	</div>
        </div>
        
        <div>
        	<span class="section-4-p">오늘의 날씨</span>
        	<div class="weather">
        <div>
           <div class="weather-font">서울</div>
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12514&lang=en&um">
        </div>
        <div>
          <div class="weather-font">인천</div>  
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12517&lang=en&um">
        </div>
        <div>
           <div class="weather-font">춘천</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12509&lang=en&um">
        </div>
        <div>
           <div class="weather-font">강릉</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12512&lang=en&um">
        </div>
        <div>
           <div class="weather-font">청주</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12534&lang=en&um">
        </div>  
        <div>   
           <div class="weather-font">대전</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12536&lang=en&um">
        </div>
        <div>
          <div class="weather-font">전주</div>  
             <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12547&lang=en&um">
        </div>
        <div>
           <div class="weather-font">광주</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12552&lang=en&um">
        </div>
        <div>
           <div class="weather-font">대구</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12545&lang=en&um">
        </div>
        <div> 
           <div class="weather-font">울산</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12549&lang=en&um">
        </div>
        <div>
           <div class="weather-font">부산</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12554&lang=en&um">
        </div>
        <div>
           <div class="weather-font">제주</div> 
            <img border=0 width=120 height=60 src="https://rp5.ru/informer/120x60x2.php?f=17&id=12565&lang=en&um">
        </div>
      </div>
    </div>

  </div>
  </div>
<jsp:include page="footer.jsp" />
</body>
</html>

