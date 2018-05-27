<%@ page import="model.User" %>
<%@ page import="model.Theme" %>
<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.PublicDesign" %>
<%@ page import="java.util.List" %>
<%@ page import="model.LikeOp" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/26
  Time: 02:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
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

    //handle the theme
    int tid = 0;
    try {
        tid = Integer.parseInt(request.getParameter("tid"));
    } catch (Exception e) {
    }
    if (tid == 0) {
        MessageDispatcher.message(response, "danger", "主题不存在！", "homepage.jsp");
    }
    Theme theme = Theme.getThemeById(tid);
    //handle the design
    List<PublicDesign> designs = PublicDesign.getDesignByTheme(tid);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=theme.getName()%>主题</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        .img-box {
            margin-left: 10px;
        }

        .jumbotron {
            padding-bottom: 0;
        }

        .big-header {
            background-image: url(img/1.jpg);
            filter: blur(10px);
            background-size: 100% 100%;
            height: 500px;
            width: 100%;
            color: white;

        }

        .header-txt {
            text-align: center;
            left: 10%;
            top: 380px;
            position: absolute;
            width: 80%;
            padding: .5em;
            height: 3em;
            display: block;
            font-size: 28pt;
            font-family: Arial, Helvetica, sans-serif;
            color: rgb(250, 249, 250);
        }

        .header-img {

            text-align: center;
            left: 10%;
            top: 150px;
            position: absolute;
            width: 80%;
            padding: .5em;
            height: 220px;
            display: block;

        }

        #footer {
            width: 100%;
            position: relative;

        }
    </style>
</head>

<body>
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
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">

                <ul class="col-lg-3">
                    <li>
                        <button type="button" class="btn btn-default"
                                onclick="window.location='usercenter_public.html';return false;">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>User
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<div class="jumbotron">
    <div class="container-fluid big-header">

    </div>
    <div class="header-img">
        <img src="<%=theme.getImg()%>" class="img-rounded" style="height: 100%;">
    </div>
    <div class="header-txt">
        <label style="font-size:40pt;" class="h2"><%=theme.getName()%>
        </label>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="container-fluid">
                <div class="row">
                    <%
                        for (PublicDesign design : designs) {
                            boolean liked = LikeOp.liked(uid, design.getPid());
                    %>
                    <div class="col-md-3">
                        <div class="thumbnail">
                            <img src="<%=design.getImg()%>"
                                 onclick="window.location='design_detail.jsp?pid=<%=design.getPid()%>'"
                                 style="height:250px;"
                            >
                            <div class="caption">
                                <h3><%=design.getName()%>
                                </h3>
                                <p><%=design.getDesp()%>
                                </p>
                                <div class="row">
                                    <div class=" col-md-5  col-md-offset-1">
                                        <label>
                                            <span class="glyphicon glyphicon-heart" style="color:red;"
                                                  aria-hidden="true"></span>
                                            <a href="#"><%=design.getCount()%>
                                            </a>
                                        </label>
                                    </div>
                                    <%if (user.getUid() != design.getUid()) {%>
                                    <div class=" col-md-5">
                                        <button onclick="
                                            <%
                                                if(user.getUid() == 0){
                                                    %>
                                                window.location='login.jsp'
                                            <%
                                                }else if(!liked){
                                                    %>
                                                like(<%=uid%>,<%=design.getPid()%>);
                                            <%
                                                }
                                            %>
                                                " class="btn btn-primary pull-right"
                                                role="button" <%=liked ? "disabled='disabled'" : ""%>>
                                            <span class="glyphicon glyphicon-heart
                                                  <%=liked?"liked":""%>"
                                                  aria-hidden="true"></span>
                                            <label>
                                                <%=liked ? "已赞" : "点赞"%>
                                            </label>
                                        </button>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>

                </div>
            </div>
        </div>
    </div>
</div>
<div class="panel-footer text-center" id="footer">
    <h4>DesignTo服装设计服务平台</h4>
    <h5>Designer:
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Star</h5>
</div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>

</html>