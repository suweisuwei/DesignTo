<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/6/2
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    //handle the cookie uid
    int uid = 0;
    Cookie[] cs = request.getCookies();
    if(cs == null){
        MessageDispatcher.message(response,"error","没有访问权限，请登录！","/login.jsp");
        return;
    }
    for(Cookie c:cs){
        if("uid".equals(c.getName())){
            try{
                uid = Integer.parseInt(c.getValue());
            }catch (Exception e){
                uid = 0;
            }
        }
    }
    if(uid == 0){
        MessageDispatcher.message(response,"error","没有访问权限，请登录！","/login.jsp");
        return;
    }
    //handle the user authorization
    User visitor = User.getUserById(uid);
    if(!visitor.getIsadmin()){
        MessageDispatcher.message(response,"error","您不是管理员，请重新登录！","/login.jsp");
    }
    //get all users
    List<User> users = User.listAllUser();
%>
<html>
<head>
    <title>用户管理</title>
</head>
<body>
    <!--左侧分页栏-->
    <div>

        <ul>
            <li><a href="manage_user.jsp">用户管理</a></li>
            <li><a href="manage_theme.jsp">主题管理</a> </li>
        </ul>
    </div>
    <!--页面主体-->
    <table border="2">
        <tr>
            <th>用户 ID</th>
            <th>用户名</th>
            <th>管理员</th>
            <th>性别</th>
            <th>头像</th>
            <th>邮箱</th>
            <th>电话</th>
            <th colspan="2">操作</th>
        </tr>
        <!--用户添加行-->

        <!--用户信息表格主体-->
        <%for(User user:users){%>
        <tr data-uid="<%=user.getUid()%>">
            <td><%=user.getUid()%></td>
            <td><%=user.getUsername()%></td>
            <td><%=user.getIsadmin()%></td>
            <td><%=user.getSex()%></td>
            <td><%=user.getHeader()%></td>
            <td><%=user.getEmail()%></td>
            <td><%=user.getTele()%></td>
            <td><button onclick="modifyUser(<%=user.getUid()%>);" class="btn btn-primary">修改</button></td>
            <td><button onclick="deleteUser(<%=user.getUid()%>);" class="btn btn-danger">删除</button></td>
        </tr>
        <%}%>
    </table>
    <script src="js/jquery.min.js"></script>
<script>
    function modifyUser(uid){
        window.location="/modify_user.jsp?uid="+uid;
    }
    function deleteUser(uid){
        var sure = confirm("是否确认删除？");
        if(sure){
            window.location = "deleteuser?uid="+uid;
        }
    }
</script>
</body>
</html>
