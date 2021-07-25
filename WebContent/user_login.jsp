<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>어디갈까?</title>
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
 	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
 	<script>
 	function submit() {
 		var frm = document.kakaoform;
 		
 		frm.submit();
 	}
 	</script>
 	<% // 세션이 유효할 시 index.jsp로 이동.
 	if(session.getAttribute("userID")!=null){%>
 		<jsp:forward page='index.jsp'/>
 	<%}%>
 		
</head>
<body>
      <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
      
    <div id="warp">
    <div>
       <form method="post" action="user_loginProcess.jsp">
    <center>
     <input type="text" class="form-control" placeholder="ID" name="id" style="width:300px; margin-top:50px;">
     <input type="password" class="form-control" placeholder="PW" name="pw" style="width:300px;">
    
    <input type="submit" class="btn btn-primary form-control" value="로그인" style="width:300px; margin-top:20px; background-color: #00394d; border: 0">
   </form>
   <br/>
   
   <!-- 사이트 자체 로그인 -->
   <div class="findform form-a-color" style="margin-top:30px;">
    <a href="user_join.jsp">회원가입</a> |
    <a href="user_findAccount.jsp">내 정보 찾기</a>
    <hr style="width:300px;">
	</div>
	
	<!-- 카카오 로그인 -->
	<div class="snsform" style="margin-top:10px;">
    <a id="kakao-login-btn"></a>
    <a href="http://developers.kakao.com/logout"></a>
    <script type='text/javascript'>
        // 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('2a36619881080dc1ee6cfdf790ff3c6a');
        // 카카오 로그인 버튼을 생성합니다.
        Kakao.Auth.createLoginButton({
            container: '#kakao-login-btn',
            success: function (authObj) {
            	Kakao.API.request({
            		url: '/v2/user/me',
            	    success: function(res) {
            	    	var knickname = res.properties.nickname;
            	    	document.write("<form action='index.jsp' method='post' name='kakaoform'>");
            	    	document.write("<input type='hidden' name='kakaoname' value="+knickname+">");
            	    	document.write("</form>");
            	    	submit();
            		}
            	})
            },
            fail: function (err) {
                alert(JSON.stringify(err));
            }
        });
        </script>
    
    <br/>
  
    <!-- 네이버 로그인 -->
    <div id="naver_id_login" style="margin-top:1px; margin-bottom:500px;"></div>
	<script type="text/javascript">
  	var naver_id_login = new naver_id_login("pn7jtq3FKhhdxR_DK9ap", "http://localhost:8080//user_naverCallback.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 3,48);
  	naver_id_login.setDomain("https://localhost:8080//index.jsp");
  	naver_id_login.setState(state);
  	//naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
  	
  	
  	
  </script>
	</center>
	</div>
	</div>
	</div>
	
<jsp:include page="footer.jsp" />
</body>
</html>