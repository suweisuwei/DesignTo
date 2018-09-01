<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.Theme" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/6/2
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    //handle the tid parameter
    int tid = 0;
    try{
        tid = Integer.parseInt(request.getParameter("tid"));
    }catch (Exception e){
        tid = 0;
    }
    if(tid == 0){
        MessageDispatcher.message(response,"danger","该主题不存在！","manege_theme.jsp");
    }
    Theme theme = Theme.getThemeById(tid);
%>
<html>
<head>
    <title>修改主题</title>
</head>
<body>
    <form method="post" action="/modifytheme" enctype="multipart/form-data">
        <input type="hidden" name="tid" value="<%=theme.getTid()%>" />
        <label>主题名：</label><input type="text" name="name" value="<%=theme.getName()%>"/><br />
        <label>上传：</label><input type="file" name="img" /><br />
        <label>原图像</label>
        <img style="width:200px;height:200px" src="<%=theme.getImg()%>">
        <label>上传新图像</label><input type="submit" value="修改">
        <button onclick="cancel();">取消</button>
    </form>
<script>
    function cancel(){
        window.location="/manage_theme.jsp";
    }
</script>
</body>
</html>
