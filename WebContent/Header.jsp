<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <script>
    //새로고침 함수
    function reload() {
    	if (self.name != 'reload') {
            self.name = 'reload';
            self.location.reload(true);
        }
        else self.name = ''; 
    }
    </script>
<%
//인코딩변환
request.setCharacterEncoding("euc-kr");
//카카오로그인 후 닉네임 받아오기
String kakaotalk = request.getParameter("kakaoname");
//네이버로그인 후 별명 받아오기
String naver = request.getParameter("navername");
//세션용 변수
String userID = null;
//세션 저장하기
if(session.getAttribute("userID")!=null){
userID = (String)session.getAttribute("userID");
} 

//카카오 별명 세션에 저장
if (kakaotalk != null) {
	session.setAttribute("userID",kakaotalk);%>
	<!-- 세션저장 후 새로고침 -->
	<script>
	reload();
	</script> <% 
}

//네이버 별명 세션에 저장
if (naver != null) {
	session.setAttribute("userID",naver); %>
	<!-- 세션저장 후 새로고침 -->
	<script>
	reload();
	</script> <% 
}
%>
</head>
<body>
<div id="warp">
    <div class="header" style="overflow: outo;">
        <div class="logo" ><a href="index.jsp"><img src="./images/logo.png" href="index.jsp"></a></div>
      <% if(userID != null){%>
  		<div class="login" style="margin-top: 8px;">
  		<a href="user_typeCheck.jsp" class="login_login"><%=userID %></a>|
        <a href="user_logout.jsp" class="login_login">로그아웃</a>
      </div>
  	<%} else {%>
      <div class="login" style="margin-top: 8px;">
        <a href="user_login.jsp" class="login_login">로그인</a>|
        <a href="user_join.jsp" class="login_join">회원가입</a>
      </div>
    <%}%>
    </div>
    </div>



 <div class="top-bar-menu-box">
        <div class="top-bar con">
            <nav class="menu-box-1">
                <ul class="row noma">
                    <li class="cell">
                        <a class="block">계절</a>
                        <div class="relative"><!-- 서브메뉴를 위한 유령의 집 -->
                            <div><!-- overflow:hidden; 때문에 존재한다. -->
                                <ul>
                                    <li><a class="block" href="season_spring.jsp">봄</a></li>
                                    <li><a class="block" href="season_summer.jsp">여름</a></li>
                                    <li><a class="block" href="season_fall.jsp">가을</a></li>
                                    <li><a class="block" href="season_winter.jsp">겨울</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="cell">
                        <a class="block">지역</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="area_seoul.jsp">수도권</a></li>
                                    <li><a class="block" href="area_gangwon.jsp">강원도</a></li>
                                    <li><a class="block" href="area_chungcheong.jsp">충청도</a></li>
                                    <li><a class="block" href="area_jeonra.jsp">전라도</a></li>
                                    <li><a class="block" href="area_gyeongsang.jsp">경상도</a></li>
                                    <li><a class="block" href="area_jeju.jsp">제주도</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="cell">
                        <a class="block">당일치기</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="day_festival.jsp">축제</a></li>
                                    <li><a class="block" href="day_drive.jsp">드라이브</a></li>
                                    
                                </ul>
                            </div>
                        </div>
                    </li>
                    
                    <li class="cell">
                        <a class="block">커뮤니티</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="board.jsp">게시판</a></li>
                                    
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="cell">
                        <a class="block">고객센터</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="notice.jsp">공지사항</a></li>
                                    <li><a class="block" href="ask.jsp">문의하기</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    
                </ul>
            </nav>
            <!-- 유령의 집, 단순한 기준점, 높이 : 항상 0 -->
            <div class="sub-menu-bg relative">
                <!-- 서브메뉴배경 래퍼, 존재이유 : overflow:hidden;, 평소 높이 : 0, 활성화 높이 : 470px -->
                <div>
                    <!-- 서브메뉴배경, 높이 : 항상 470px, 평소 transform:translateY(-100%), 활성화 transform:translateY(0) -->
                    <div></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>