<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
 <% request.setCharacterEncoding("euc-kr"); %>
 <%
 session=request.getSession(false);
 session.invalidate();
 %>
  <script>
 location.href = "index.jsp";
 </script>