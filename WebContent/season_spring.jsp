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
    <title>��𰥱�?</title>
    
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
    <jsp:include page="Header.jsp" /> <!-- �޴� -->
    <div id="warp">
        <div class="main-box-name">#�� <!-- �ڹ� ��ũ��Ʈ? --> </div>
        <hr class="hr1">
        
        <div>
            <ul class="season_ul">
<%
Vector spid=new Vector(); // ����� ������ ��ȣ
Vector spimg=new Vector(); // ����� ������ �̹���
Vector splocation=new Vector(); // ����� ��������
Vector spplace=new Vector(); // ����� ������ �����ּ�

long id=0;

int where=1;
int totalgroup=0; // ��ü�׷��
int maxpages=5; // �� �׷쿡 ���Ե� ������ ��
int startpage=1; // �׷��� ���� ������
int endpage=startpage+maxpages-1; // �׷��� ������ ������
int wheregroup=1; // ������ �������� �����ִ� �׷�
if (request.getParameter("go") != null) { // ������ �������� ������ where ������ go�� ����
 where = Integer.parseInt(request.getParameter("go")); // String�� int�� ����
 wheregroup = (where-1)/maxpages + 1; //������ �׷� ����
 startpage=(wheregroup-1) * maxpages+1; // �׷��� ���� ������
 endpage=startpage+maxpages-1;  //�׷��� ������ ������
 // ���� Ȥ�� ���� ��ũ�� ������ gogroup ����, gogroup ����� wheregroup�� gogroup���� ����
} else if (request.getParameter("gogroup") != null) {
 wheregroup = Integer.parseInt(request.getParameter("gogroup")); // String�� int�� ����
 startpage=(wheregroup-1) * maxpages+1;  // �׷��� ����������
 where = startpage ; // ������������ where
 endpage=startpage+maxpages-1; //�׷��� ������ ������
}
int nextgroup=wheregroup+1; // ���� �׷�
int priorgroup= wheregroup-1; //���� �׷�

int startrow=0; // ù ��° �� ��ȣ
int endrow=0; // ������ �� ��ȣ
int maxrows=6; // �ִ� ������ �� ��ȣ
int totalrows=0; // �� �� ��
int totalpages=0; // �� ������


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
	<li class="season_li">  <!-- li�� �ϳ��� -->
		<a href="#" class="season_box">
			<img src="https://www.malaysiaforyou.com/files/attach/images/848/848/7dbcb6c10550f242552e934d49c43f12.jpg" alt="">
			<span class="season_span1">�غ����Դϴ�.</span>
			<span>�غ����Դϴ�.</span>
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
if (endrow >= totalrows) // ������ ���� �� �ຸ�� ũ�ų� ���ٸ�
 endrow=totalrows-1; // ������ ���� �� ��-1
totalgroup = (totalpages-1)/maxpages +1; // ��ü�׷���
if (endpage > totalpages) //������ �������� ������������ Ŭ��
 endpage=totalpages; // ����

for(int j=startrow;j<=endrow;j++) {
    id= ( (Long)spid.elementAt(j) ).longValue();
%>

                <li class="season_li">  <!-- li�� �ϳ��� -->
                    <a href="place_detail.jsp?location=<%=splocation.elementAt(j) %>" class="season_box"> <!-- Ŭ���� �������� �������� �̵� -->
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

          <!-- ��Ʈ��Ʈ�� ���������̼� -->
          <div class="pagination" style="justify-content:center;">
        	<nav aria-label="Page navigation example">
  				<ul class="pagination">
        			<%if (wheregroup > 1) {%> <!-- �������� �����ִ� �׷��� 1���� ũ�ٸ� -->
                	  <li class="page-item">                    
      					<a class="page-link" href="season_spring.jsp?gogroup=<%=priorgroup %>">��</a> <!-- gogroup�� ���� �׷����� Ȱ��ȭ -->
    				  </li>
                	 <%} else { %>
                	  <li class="page-item">
      					<a class="page-link">��</a> <!-- UI�� ���� ��� ��Ȱ��ȭ -->
    				  </li>
                	 <%}
                	 
                	 if (totalrows !=0) {  // �� ���� 0�� �ƴ϶��
                	  for(int jj=startpage; jj<=endpage; jj++) { // ������������  ���������������� ����Ѵ�
                	   if (jj==where) {%> <!-- ���� �������� �����ִٸ� -->
                	    <li class="page-item"><a class="page-link" href="#"><%=jj %></a></li> <!-- ���� ���������̼� ��Ȱ��ȭ -->
                	   <%} else { %> <!-- �ƴ϶�� -->
                   	    <li class="page-item"><a class="page-link" href="season_spring.jsp?go=<%=jj%>"><%=jj %></a></li> <!-- �ٸ� ���������̼� Ȱ��ȭ -->
                	   <%}
                	  } 
                	 }
                	 if (wheregroup < totalgroup) { %> <!-- ����׷��� �� �׷캸�� �۴ٸ� -->
                	  <li class="page-item">
      					<a class="page-link" href="season_spring.jsp?gogroup=<%=nextgroup %>">��</a> <!-- gogroup�� ���� �׷����� Ȱ��ȭ -->
    				  </li>
                	 <% } else {%>
                	  <li class="page-item">
      					<a class="page-link">��</a> <!-- UI�� ���� ��� ��Ȱ��ȭ -->
    				  </li>
                	 <% } %>
  				</ul>
               </nav>
        </div>
          
    </div>

<jsp:include page="footer.jsp" />
</body>
</html>