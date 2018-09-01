<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.User" %>
<%@ page import="model.Theme" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/6/2
  Time: 16:26
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
    //get the theme list
    List<Theme> themes = Theme.listTheme();
%>
<html>
<head>
    <title>主题管理</title>
</head>
<body>
<!--左侧分页栏-->
<div>

    <ul>
        <li><a href="manage_user.jsp">用户管理</a></li>
        <li><a href="manage_theme.jsp">主题管理</a> </li>
    </ul>
</div>
<!--右侧主体-->
<div>

    <table border="2">
        <tr>
            <td><button onclick="addTheme();">添加</button> </td>
        </tr>
        <tr>
            <th>主题 ID</th>
            <th>主题名</th>
            <th>题图</th>
            <td colspan="2">操作</td>
        </tr>
        <%for(Theme theme:themes){%>
        <tr style="height:200px;">
            <td><%=theme.getTid()%></td>
            <td><%=theme.getName()%></td>
            <td><img style="height:200px; width:200px" src="<%=theme.getImg()%>" /></td>
            <td><button onclick = "modifyTheme(<%=theme.getTid()%>);" class="btn btn-primary">修改</button></td>
            <td><button onclick="deleteTheme(<%=theme.getTid()%>);" class="btn btn-danger">删除</button></td>
        </tr>
        <%}%>
    </table>
</div>
<script>
    function modifyTheme(tid){
        window.location="modify_theme.jsp?tid="+tid;
    }
    function deleteTheme(tid){
        var sure = confirm("确认删除主题？");
        if(sure){
            window.location="deletetheme?tid="+tid;
        }
    }
    function addTheme(){
        window.location = "add_theme.jsp";
    }
</script>
</body>
</html>
