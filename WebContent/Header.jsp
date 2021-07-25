<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <script>
    //���ΰ�ħ �Լ�
    function reload() {
    	if (self.name != 'reload') {
            self.name = 'reload';
            self.location.reload(true);
        }
        else self.name = ''; 
    }
    </script>
<%
//���ڵ���ȯ
request.setCharacterEncoding("euc-kr");
//īī���α��� �� �г��� �޾ƿ���
String kakaotalk = request.getParameter("kakaoname");
//���̹��α��� �� ���� �޾ƿ���
String naver = request.getParameter("navername");
//���ǿ� ����
String userID = null;
//���� �����ϱ�
if(session.getAttribute("userID")!=null){
userID = (String)session.getAttribute("userID");
} 

//īī�� ���� ���ǿ� ����
if (kakaotalk != null) {
	session.setAttribute("userID",kakaotalk);%>
	<!-- �������� �� ���ΰ�ħ -->
	<script>
	reload();
	</script> <% 
}

//���̹� ���� ���ǿ� ����
if (naver != null) {
	session.setAttribute("userID",naver); %>
	<!-- �������� �� ���ΰ�ħ -->
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
        <a href="user_logout.jsp" class="login_login">�α׾ƿ�</a>
      </div>
  	<%} else {%>
      <div class="login" style="margin-top: 8px;">
        <a href="user_login.jsp" class="login_login">�α���</a>|
        <a href="user_join.jsp" class="login_join">ȸ������</a>
      </div>
    <%}%>
    </div>
    </div>



 <div class="top-bar-menu-box">
        <div class="top-bar con">
            <nav class="menu-box-1">
                <ul class="row noma">
                    <li class="cell">
                        <a class="block">����</a>
                        <div class="relative"><!-- ����޴��� ���� ������ �� -->
                            <div><!-- overflow:hidden; ������ �����Ѵ�. -->
                                <ul>
                                    <li><a class="block" href="season_spring.jsp">��</a></li>
                                    <li><a class="block" href="season_summer.jsp">����</a></li>
                                    <li><a class="block" href="season_fall.jsp">����</a></li>
                                    <li><a class="block" href="season_winter.jsp">�ܿ�</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="cell">
                        <a class="block">����</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="area_seoul.jsp">������</a></li>
                                    <li><a class="block" href="area_gangwon.jsp">������</a></li>
                                    <li><a class="block" href="area_chungcheong.jsp">��û��</a></li>
                                    <li><a class="block" href="area_jeonra.jsp">����</a></li>
                                    <li><a class="block" href="area_gyeongsang.jsp">���</a></li>
                                    <li><a class="block" href="area_jeju.jsp">���ֵ�</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="cell">
                        <a class="block">����ġ��</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="day_festival.jsp">����</a></li>
                                    <li><a class="block" href="day_drive.jsp">����̺�</a></li>
                                    
                                </ul>
                            </div>
                        </div>
                    </li>
                    
                    <li class="cell">
                        <a class="block">Ŀ�´�Ƽ</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="board.jsp">�Խ���</a></li>
                                    
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="cell">
                        <a class="block">������</a>
                        <div class="relative">
                            <div>
                                <ul>
                                    <li><a class="block" href="notice.jsp">��������</a></li>
                                    <li><a class="block" href="ask.jsp">�����ϱ�</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    
                </ul>
            </nav>
            <!-- ������ ��, �ܼ��� ������, ���� : �׻� 0 -->
            <div class="sub-menu-bg relative">
                <!-- ����޴���� ����, �������� : overflow:hidden;, ��� ���� : 0, Ȱ��ȭ ���� : 470px -->
                <div>
                    <!-- ����޴����, ���� : �׻� 470px, ��� transform:translateY(-100%), Ȱ��ȭ transform:translateY(0) -->
                    <div></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>