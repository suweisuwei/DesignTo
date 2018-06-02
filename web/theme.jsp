<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theme" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/26
  Time: 02:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>主题</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        .near-box {
            padding: 5px;
        }

        .jumbotron {
            padding-bottom: 0;
        }

        .info-box {
            position: absolute;
            width: 150px;
            height: 3em;
            padding: .5em;
            left: 30px;
            bottom: 60px;
            display: block;
            overflow: inherit;
            background: rgba(0, 0, 0, .4);
        }

        #header-box {
            display: block;
            position: relative;
        }

        .head {
            position: absolute;
            width: 80%;
            height: 3em;
            padding: .5em;
            left: 135px;
            display: block;
            font-size: 28pt;
            top: 100px;
        }

        #footer {
            width: 100%;
            position: relative

        }

        .thumbnail {
            height: 260px;
        }

    </style>
</head>

<body>
<%
    //handle cookie
    int uid = 0;
    User user = null;
    //读取 user 信息
    Cookie[] cs = request.getCookies();
    for (Cookie c : cs) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    user = User.getUserById(uid);


    //handle the theme list
    List<Theme> themes = Theme.listTheme();
%>
<nav class="navbar navbar-default navbar-fixed-top" style="margin-bottom: 0">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" style="color: blueviolet">DesignTo</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li>
                    <a href="homepage.jsp">首页</a>
                </li>
                <li class="active">
                    <a href="theme.jsp">主题</a>
                </li>
                <li>
                    <a href="custom.jsp">个性化</a>
                </li>
            </ul>
            <%
                if (user.getUid() != 0) {
            %>
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">

                <ul class="col-lg-3">
                    <li>
                        <button type="button" class="btn btn-default"
                                onclick="window.location='usercenter_public.jsp?uid=<%=user.getUid()%>';return false;">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span><%=user.getUsername()%>
                        </button>
                    </li>
                </ul>
            </div>
            <%
            } else {
            %>
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">

                <div class="col-md-12">
                    <div class="col-md-3">
                        <button type="button" class="btn btn-default" onclick="window.location='signup.jsp'">注册
                        </button>
                    </div>
                    <div class="col-md-3"></div>
                    <button type="button" class="btn btn-default" onclick="window.location='login.jsp'">登录</button>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</nav>
<div class="jumbotron">
    <div class="container-fluid" id="header-box"
         style="background-image: url(img/1.jpg);background-size:100% 100%;height: 500px;width: 100%;">
        <div class="head">
            <label style="color: white;font-size:40pt;" class="h2">Hello,Designer!</label>
            <br/>
            <label style="color: white;font-size:25pt" class="h4">This is a place you can show your designs!</label>
            <br/>
        </div>
    </div>

</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="container-fluid">
                <div class="row">
                    <%
                        for (Theme theme : themes) {
                    %>
                    <div class="col-md-3 near-box">
                        <div class="thumbnail">
                            <div class="info-box">
                                <p style="color: white;margin:0;" class="h3"><%=theme.getName()%>
                                </p>
                            </div>
                            <a href="theme_detail.jsp?tid=<%=theme.getTid()%>">
                                <img src="<%=theme.getImg()%>" class="img-rounded" style="height: 100%;">
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="panel-footer text-center" id="footer">
    <h4>DesignTo服装设计服务平台</h4>
    <h5>Designer:
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Rimo</h5>
</div>


<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>

</html>