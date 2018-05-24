<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/24
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<!--
传入：title：页面标题
    type：消息类型（success、warning、danger、info 等）

    content：消息内容
    caller：返回的页面 URL。
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提示信息</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    String caller = request.getParameter("caller");
    String content = request.getParameter("content");
    String type = request.getParameter("type");
    if(caller == null){
        caller = "/index.jsp";
    }
    if(content == null){
        content = "未知错误！";
        type="danger";
    }
%>
<div class="container-fluid" style="padding:20px;">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-<%=type%>">
                <div class="panel panel-heading">
                    <div class="panel-title">提示</div>
                </div>
                <div class="panel panel-body">
                    <h2><%=URLDecoder.decode(content)%></h2>
                    <div class="row">
                        <div class="col-md-2 col-md-offset-10">
                            <button class="btn btn-primary" onclick="window.location='<%=caller%>'">确认</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>
