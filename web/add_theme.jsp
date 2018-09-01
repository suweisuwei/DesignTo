<%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/6/2
  Time: 17:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加主题</title>
</head>
<body>
<form method="post" action="/addtheme" enctype="multipart/form-data">
    <label>主题名：</label><input type="text" name="name" /><br />
    <label>上传：</label><input type="file" name="img" /><br />
    <input type="submit" value="添加">
    <button onclick="cancel();">取消</button>
</form>
</body>
</html>
