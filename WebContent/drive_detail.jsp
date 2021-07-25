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
    <title>��𰥱�?</title>
    
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
    <jsp:include page="Header.jsp" /> <!-- �޴� -->
    
    <div id="warp">
    <div class="main-box-name">#����̺�</div>
    
        <hr class="hr1">
        
        <div class="productselect">

            <div class="product_top">

                <div class="product_img">
                    <img src="<%=img %>" alt="<%=location%>">
                </div>

                <div class="product_info">

                    <div class="product_info_box">

                        <div> <!-- ����  -->
                            <p>������</p>   <!-- ���� -->
                            <span class="product_info-span"> <!-- ���� span�±� �߰��ϸ� �Ʒ��� ������ -->
                                 <span><%=location %></span> 
                            </span>
                        </div> <!-- �� -->


                        <div> <!-- ����  -->
                            <p>���</p>   <!-- ���� -->
                            <span class="product_info-span"> <!-- ���� span�±� �߰��ϸ� �Ʒ��� ������ -->
                                 <span><%=place %></span> 
                            </span>
                        </div> <!-- �� -->

                        <div style="height:238.8px;"> <!-- ����  -->
                            <p>����</p>   <!-- ���� -->
                            <span class="product_info-span"> <!-- ���� span�±� �߰��ϸ� �Ʒ��� ������ -->
                                 <span><%=description %></span> 
                            </span>
                        </div> <!-- �� -->
                    </div>   
                    
                </div>

            </div>

            <div class="product_map">
                <div id="map" style="width:600px; height: 528.8px;">
        			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey="></script>
        			<script>
        				var container = document.getElementById('map'); //������ ���� ������ DOM ���۷���
        				var options = { //������ ������ �� �ʿ��� �⺻ �ɼ�
        					center: new kakao.maps.LatLng(<%=ctlatitude%>, <%=ctlongitude%>), //������ �߽���ǥ.
        					level: 8 //������ ����(Ȯ��, ��� ����)
        				};
        				
        				var map = new kakao.maps.Map(container, options);
        				
        				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
        				
        				var positions = [
        					{
        						title: '��������',
        						latlng: new kakao.maps.LatLng(<%=stlatitude%>, <%=stlongitude%>)
        					},
        					{
        						title: '��������',
        						latlng: new kakao.maps.LatLng(<%=enlatitude%>, <%=enlongitude%>)
        					},
        				];
        				
        				for (var i = 0; i < positions.length; i ++) {
        					// ��Ŀ �̹����� �̹��� ũ�� �Դϴ�
        				    var imageSize = new kakao.maps.Size(24, 35); 
        				    
        				    // ��Ŀ �̹����� �����մϴ�    
        				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 

        					var marker = new kakao.maps.Marker({
        			        	map: map, // ��Ŀ�� ǥ���� ����
        			        	position: positions[i].latlng, // ��Ŀ�� ǥ���� ��ġ
        			        	title : positions[i].title, // ��Ŀ�� Ÿ��Ʋ, ��Ŀ�� ���콺�� �ø��� Ÿ��Ʋ�� ǥ�õ˴ϴ�
        			       	 	image : markerImage // ��Ŀ �̹��� 
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
                	<div class="product_map_com-name">����� <%=totalc %>��</div>
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
                        <span>�����</span>
                        <input type="hidden" name="pla" value="<%=lo%>">
                        <input type="text" name="commentary">
                        <button type="submit">��� �ޱ�</button>
                    </form>

                    </div>
                </div>

            </div>


        </div>
    </div>
<% } catch (NullPointerException k) { %>
	<script>
	alert("�������� ��θ� �̿��� �ּ���");
	location.href="index.jsp";
	</script>
<%} catch (SQLException o) { %>
<script>
alert("�������� ��θ� �̿��� �ּ���");
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