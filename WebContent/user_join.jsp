<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
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
    <% // 세션이 유효할 시 index.jsp로 이동.
 	if(session.getAttribute("userID")!=null){%>
 		<jsp:forward page='index.jsp'/>
 	<%}%>
</head>
      <jsp:include page="Header.jsp" /> <!-- 메뉴 -->
    
    <div id="warp">
    <center>
     <div class="section-box">
        
        <div class="section-div">
            
             <form method="POST" action="user_joinProcess.jsp" class="form-main">
               <span>아이디</span> 
             <div class="form-main__inputbox q13"> 
                <input type="text" class="input80"  placeholder="아이디" name="registerID" maxlength="20">          
            </div>
        <div class="password1" >
            <div class="passbox">
                <span>비밀번호</span>
                <input type="password" class="passtext" placeholder="비밀번호" name="userPassword" maxlength="20">
            </div>
            <div class="passbox">
                <span>비밀번호 확인</span>
                <input type="password" class="passtext" placeholder="비밀번호 확인" name="userPasswordC" maxlength="20">
            </div>
        </div>

        <div class="password1">
            <div class="passbox">
                <span>이름</span>
                <input type="text" class="passtext" placeholder="이름" name="userName" maxlength="20">
            </div>
            <div class="passbox">
                <span>닉네임</span>
                <input type="text" class="passtext" placeholder="닉네임" name="userNick" >
            </div>
        </div>
        
            
            
            <div class="password1">
                <div class="passbox">
                    <span>생년월일</span>
                    <input type="text" class="passtext" placeholder="ex)19700101" name="userBirth" maxlength="8">
                </div>
                <div class="passbox">
                    <span>휴대전화</span>
                    <input type="text" class="passtext" placeholder="ex)01012345678" name="userPhone" maxlength="11">
                </div>
            </div>
             <button type="submit" class="form-main__join">회원가입</button>
             </form>
        </div>
    </div>
	</center>
	</div>
<jsp:include page="footer.jsp" />
</body>
</html>