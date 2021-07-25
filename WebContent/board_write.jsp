<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder" %>
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
	<%
	String userID = (String)session.getAttribute("userID");
	if(userID == null){%>
		<script>alert("로그인 후 이용해 주시기 바랍니다!");</script>
		<jsp:forward page='user_login.jsp'/>
	<%}%>
</head>
<body>
	<jsp:include page="Header.jsp" /> <!-- 메뉴 -->
      
	<div id="warp" style="margin-top:30px"> 
     	<div>
        	<center>
        	<h3 class="board3text">게시판</h3>
        	</center>
    	</div>
    	<div class="container" style="margin-top:30px;">
		<form class = "ss" method="post" action="board_process.jsp">
			<table class="table" style="text-align: center;">
				<input type="hidden" id="type" name="select1" value="">
				<tr>
					<td style="border: none; display: flex;">
						<input type="text" class="form-control" placeholder="글 제목" name="postT" maxlength="100"/>
						<select name="selectBox" id="selectBox" class="select_button2" onchange="selected2();">
           					<option value="선택">선택</option>
           					<option value="자유">자유</option>
            				<option value="공유">공유</option>
            				<option value="기타">기타</option>
        				</select>
					</td>
				</tr>
				<script type="text/javascript">
				var element = document.getElementsByClassName("ss");
				var type = document.getElementById("type");
				
				function selected2() {
					var sel = document.getElementById("selectBox");
					var val = sel.options[sel.selectedIndex].value;		
					
					type.value = val;
				}
				
				</script>
				<tr>
					<td>
						<textarea class="form-control" placeholder="글 내용" name="postC" maxlength="2048" style="height: 400px;"></textarea>
					</td>
				</tr>
			</table>
			<a class="btn btn-primary pull-right" href="board.jsp" style="margin-left: 5px";>뒤로가기</a>
			<input type="submit" class="btn btn-info pull-right" value="등록하기">
		</form>
		
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>