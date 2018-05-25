<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/24
  Time: 01:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
    <%
        User user;
      String username = request.getParameter("username");
      if(username!= null&&!"".equals(username)) {
          user = model.User.getUserByName(username);
      }else{
          user = null;
      }
        if (user != null) {
          %>
    <img src="<%=user.getHeader()%>" />
        <h2>用户名是：<%=user.getUsername()%></h2>
    <h2 >性别为：<label id="sex-label"><%=user.getSex()%></label></h2>
    <h2>电话是：<%=user.getTele()%></h2>
    <h2>邮箱是：<%=user.getEmail()%>></h2>

    <%
        }
    %>
    <form method="get" action="index.jsp">
        <input type="text" name="username" />
        <button type="submit">查询</button>
    </form>
  <script>
      var sex = document.getElementById("sex-label");
      if(sex.innerText.toUpperCase() == 'F'){
          sex.innerText = '女';
      }else if(sex.innerText.toUpperCase() == 'M'){
          sex.innerText = '男';
      }else{
          sex.innerText = '未知';
      }
  </script>
  </body>
</html>
