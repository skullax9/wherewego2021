<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
	//닉네임 변수 JSP로 넘기는 함수
 	function submit() {
 		var frm = document.naverform;
 		frm.submit();
 	}
	//연동해제 페이지로 이동하는 함수
 	function openNaverTab() {
 		var win = window.open("https://nid.naver.com/user2/help/externalAuth?lang=ko_KR",'_blank');
 		win.focus();
 	}
 	</script>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("pn7jtq3FKhhdxR_DK9ap", "https://localhost:8080/wherewego/index.jsp");
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	  // 사용자 별명
	  var navername = naver_id_login.getProfileData('nickname');
	  if (navername == undefined) {
		  alert("별명은 필수 제공 항목입니다! 네이버에서 연동해제 후 다시 로그인 해 주시기 바랍니다.");
		  close();
		  openNaverTab();
		  location.href = 'login.jsp';
	  } else {
		  <%session.setAttribute("blogin","success");%>
		  document.write("<form action='index.jsp' method='post' name='naverform'>");
		  document.write("<input type='hidden' name='navername' value="+navername+">");
		  document.write("</form>");
		  submit();
		}
  }
  
  
</script>
</body>
</html>

  