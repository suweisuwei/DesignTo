<%@ page import="model.PublicDesign" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.LikeOp" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/25
  Time: 02:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int uid = 0;
    User user;
    //读取 user 信息
    Cookie[] cs = request.getCookies();
    for (Cookie c : cs) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    user = User.getUserById(uid);


    //读取 top list
    List<PublicDesign> list = PublicDesign.listTop(20);
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>首页</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>

        .jumbotron {
            padding-bottom: 0;
        }

        .big-header {
            background-image: url(img/1.jpg);
            background-size: 100% 100%;
            height: 500px;
            width: 100%;
            color: white;

        }

        .liked {
            color: red;
        }

        .header-txt {
            left: 135px;
            top: 150px;
            position: absolute;
            width: 80%;
            padding: .5em;
            height: 3em;
            display: block;
            font-size: 28pt;
        }

        #footer {
            width: 100%;

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
                <li class="active">
                    <a href="homepage.jsp">首页</a>
                </li>
                <li>
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
                                onclick="window.location='usercenter_public.jsp?uid=<%=user.getUid()%>';">
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
    <div class="container-fluid big-header">
        <div class="header-txt">
            <label style="font-size:40pt;" class="h2">Hello,Designer!</label>
            <br/>
            <label class="h4" style="font-size:25pt;">This is a place you can show your designs!</label>
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
                        for (PublicDesign design : list) {
                            boolean liked = LikeOp.liked(uid, design.getPid());
                    %>
                    <div class="col-md-3" data-pid="<%=design.getPid()%>">
                        <div class="thumbnail">
                            <img src="<%=design.getImg()%>"
                                 onclick="window.location='design_detail.jsp?pid=<%=design.getPid()%>'"
                                 style="height:250px;">
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
                                            <label class="like-count"><%=design.getCount()%>
                                            </label>
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
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Star</h5>
</div>

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>

</html>
