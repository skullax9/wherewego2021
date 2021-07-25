<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
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
    <link rel="stylesheet" href="./css/place.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
    (function() {
    	if (self.name != 'reload') {
            self.name = 'reload';
            self.location.reload(true);
        }
        else self.name = ''; 
    }());
    </script>
    <%
   String lo = (String)request.getParameter("location");
   
   String sql = null;
   Connection con = null;
   ResultSet rs = null;
   Statement st = null;
   
   int totalc = 0;
   try {
   Class.forName("com.mysql.cj.jdbc.Driver");

   String dbURL = "jdbc:mysql://61.83.168.88:3306/?serverTimezone=UTC";
   String dbID = "";
   String dbPassword = "";
   con=DriverManager.getConnection(dbURL, dbID, dbPassword);
   st = con.createStatement();
   sql = "select * from DRIVE where location = '"+lo+"';";
   rs = st.executeQuery(sql);

   rs.next();
   
   String img = rs.getString("img");
   String location = rs.getString("location");
   String place = rs.getString("placedetail");
   String stlatitude = rs.getString("stlatitude");
   String stlongitude = rs.getString("stlongitude");
   String enlatitude = rs.getString("enlatitude");
   String enlongitude = rs.getString("enlongitude");
   String ctlatitude = rs.getString("ctlatitude");
   String ctlongitude = rs.getString("ctlongitude");
   String description = rs.getString("description");
   
   %>
</head>
<body>
    <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
    
    <div id="warp">
    <div class="main-box-name">#드라이브</div>
    
        <hr class="hr1">
        
        <div class="productselect">

            <div class="product_top">

                <div class="product_img">
                    <img src="<%=img %>" alt="<%=location%>">
                </div>

                <div class="product_info">

                    <div class="product_info_box">

                        <div> <!-- 시작  -->
                            <p>여행지</p>   <!-- 제목 -->
                            <span class="product_info-span"> <!-- 설명 span태그 추가하면 아래로 내려감 -->
                                 <span><%=location %></span> 
                            </span>
                        </div> <!-- 끝 -->


                        <div> <!-- 시작  -->
                            <p>경로</p>   <!-- 제목 -->
                            <span class="product_info-span"> <!-- 설명 span태그 추가하면 아래로 내려감 -->
                                 <span><%=place %></span> 
                            </span>
                        </div> <!-- 끝 -->

                        <div style="height:238.8px;"> <!-- 시작  -->
                            <p>설명</p>   <!-- 제목 -->
                            <span class="product_info-span"> <!-- 설명 span태그 추가하면 아래로 내려감 -->
                                 <span><%=description %></span> 
                            </span>
                        </div> <!-- 끝 -->
                    </div>   
                    
                </div>

            </div>

            <div class="product_map">
                <div id="map" style="width:600px; height: 528.8px;">
        			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a36619881080dc1ee6cfdf790ff3c6a"></script>
        			<script>
        				var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        				var options = { //지도를 생성할 때 필요한 기본 옵션
        					center: new kakao.maps.LatLng(<%=ctlatitude%>, <%=ctlongitude%>), //지도의 중심좌표.
        					level: 8 //지도의 레벨(확대, 축소 정도)
        				};
        				
        				var map = new kakao.maps.Map(container, options);
        				
        				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
        				
        				var positions = [
        					{
        						title: '시작지점',
        						latlng: new kakao.maps.LatLng(<%=stlatitude%>, <%=stlongitude%>)
        					},
        					{
        						title: '종료지점',
        						latlng: new kakao.maps.LatLng(<%=enlatitude%>, <%=enlongitude%>)
        					},
        				];
        				
        				for (var i = 0; i < positions.length; i ++) {
        					// 마커 이미지의 이미지 크기 입니다
        				    var imageSize = new kakao.maps.Size(24, 35); 
        				    
        				    // 마커 이미지를 생성합니다    
        				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 

        					var marker = new kakao.maps.Marker({
        			        	map: map, // 마커를 표시할 지도
        			        	position: positions[i].latlng, // 마커를 표시할 위치
        			        	title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        			       	 	image : markerImage // 마커 이미지 
        			    	});
        				}
        	

        			</script>
        	</div>
     				<%
     			 	sql = "select count(*) from PLACEREPLY where place='"+lo+"';";
     				rs = st.executeQuery(sql);
      
     				if (rs.next()) {
    					totalc = rs.getInt(1);
      				} 
      				%>
                <div class="product_map_com" style="margin-top:14.5px;">
                	<div class="product_map_com-name">장소평가 <%=totalc %>개</div>
                    	<table class="product_map_com-table">
                 	
      
      				<% if (totalc < 0) {%>
                        <tr>
                            <td class="product_map_com-table-td1"></td>
                            <td class="product_map_com-table-td2"></td>
                        </tr>
                    <% } else  {
                    	String listSQL = "SELECT replytext, replyer FROM `PLACEREPLY` where place ='"+lo+"' order by regdate;";
                        rs = st.executeQuery(listSQL);
                    
                        while(rs.next()){
                        	String rtext = rs.getString(1);
                        	String rid = rs.getString(2);
                        
                    %>
                        <tr>
                            <td class="product_map_com-table-td1"><%=rid %></td>
                            <td class="product_map_com-table-td2"><%=rtext %></td>
                        </tr>
                        <%	} 
                        }
      					rs.close();
      					st.close();
                        %>

                    </table>
                </div>
            </div>

            <div class="product_end">

                <div>
                    <div class="product_end_sand-box">
                        
                    <form action="place_comment.jsp?location=<%=lo %>" class="product_end_sand" >
                        <span>장소평가</span>
                        <input type="hidden" name="pla" value="<%=lo%>">
                        <input type="text" name="commentary">
                        <button type="submit">댓글 달기</button>
                    </form>

                    </div>
                </div>

            </div>


        </div>
    </div>
<% } catch (NullPointerException k) { %>
	<script>
	alert("정상적인 경로를 이용해 주세요");
	location.href="index.jsp";
	</script>
<%} catch (SQLException o) { %>
<script>
alert("정상적인 경로를 이용해 주세요");
location.href="index.jsp";
</script>
<%}
   finally {
		if (st != null) try { st.close(); } catch(SQLException ex) {}
	    if (con != null) try { con.close(); } catch(SQLException ex) {} 
	}
%>
<jsp:include page="footer.jsp" />
</body>
</html>