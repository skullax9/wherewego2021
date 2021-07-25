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
	//�г��� ���� JSP�� �ѱ�� �Լ�
 	function submit() {
 		var frm = document.naverform;
 		frm.submit();
 	}
	//�������� �������� �̵��ϴ� �Լ�
 	function openNaverTab() {
 		var win = window.open("https://nid.naver.com/user2/help/externalAuth?lang=ko_KR",'_blank');
 		win.focus();
 	}
 	</script>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("pn7jtq3FKhhdxR_DK9ap", "https://localhost:8080/wherewego/index.jsp");
  // ���̹� ����� ������ ��ȸ
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // ���̹� ����� ������ ��ȸ ���� ������ ������ ó���� callback function
  function naverSignInCallback() {
	  // ����� ����
	  var navername = naver_id_login.getProfileData('nickname');
	  if (navername == undefined) {
		  alert("������ �ʼ� ���� �׸��Դϴ�! ���̹����� �������� �� �ٽ� �α��� �� �ֽñ� �ٶ��ϴ�.");
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

  