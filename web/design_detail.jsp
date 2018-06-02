<%@ page import="model.User" %>
<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.PublicDesign" %>
<%@ page import="model.Theme" %>
<%@ page import="model.LikeOp" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/25
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <title>作品详情</title>
    <meta charset="utf-8"/>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <script src="js/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="js/bootstrap.min.js"></script>
    <style>
        #main-box {
            margin-top: 50px;
        }

        #footer {
            width: 100%;
            position: relative;
        }
    </style>
</head>

<body>
<%
    //读取用户信息
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

    //handle the design
    int pid;
    PublicDesign design;
    try {
        pid = Integer.parseInt(request.getParameter("pid"));
        if (pid == 0) {
            throw new Exception("访问的页面不存在！");
        }
        design = PublicDesign.getDesignById(pid);

    } catch (Exception e) {
        MessageDispatcher.message(response, "danger", e.getMessage(), "homepage.jsp");
        return;
    }
    //handle the theme
    Theme theme = Theme.getThemeById(design.getTheme());
    //handle the designer
    User designer = User.getUserById(design.getUid());
    //处理点赞按钮
    boolean self = false;
    boolean liked = LikeOp.liked(user.getUid(), pid);
    if (designer.getUid() == user.getUid()) {
        self = true;
    }
%>
<!--导航-->
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
<!--页面主体-->
<div class="container-fluid" id="main-box">
    <div class="row">
        <div class="col-xs-10 col-xs-offset-1 col-md-8 col-md-offset-2">
            <div class="row"
                 style="background-color:rgba(211, 211, 211, 0.589);height:550px;box-shadow: lightgray 5px 5px 2px;padding:20px;">
                <!--图片详情一半-->
                <div class="col-md-5" style="height: 100%;padding-bottom: 20px;">
                    <img src="<%=design.getImg()%>" class="img-thumbnail" style="margin: 2em"/>
                    <br/>
                    <div class="container-fluid">
                        <div class="row" data-pid="<%=pid%>">
                            <div class="col-md-5 col-md-offset-1" style="vertical-align: middle">
                                <span class="glyphicon glyphicon-heart" style="color:red;"></span>
                                <label class="like-count"><%=design.getCount()%>
                                </label>
                            </div>
                            <!--不是自己才显示点赞按钮-->
                            <%if (!self) {%>
                            <div class="col-md-5">
                                <button class="btn btn-info"
                                        <%if (!liked) {%>
                                        onclick="like(<%=user.getUid()%>,<%=pid%>);"
                                        <%}%>
                                        <%=liked ? "disabled=disabled" : ""%>
                                >
                                    <span class="glyphicon glyphicon-heart"></span>
                                    <label><%=liked ? "已赞" : "点赞"%>
                                    </label>
                                </button>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <!--文字详情一半-->
                <div class="col-md-7">
                    <div class="container-fluid">
                        <div class="row" style="margin-top:2em;">
                            <form class="form-horizontal">
                                <!--作品标题行-->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">作品名称：</label>
                                    <div class="col-sm-9">
                                        <p class="form-control-static"><%=design.getName()%>
                                        </p>
                                    </div>
                                </div>
                                <!--作品分类行-->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">作品分类：</label>
                                    <div class="col-sm-9">
                                        <a href="theme_detail.jsp?tid=<%=theme.getTid()%>" class="form-control-static"
                                           data-themeid="<%=theme.getTid()%>"><%=theme.getName()%>
                                        </a>
                                    </div>
                                </div>
                                <!--作品描述行-->
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">作品描述：</label>
                                    <div class="col-sm-9" style="text-overflow: ellipsis;">
                                        <p class="form-control-static">
                                            <%=design.getDesp()%>
                                        </p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">设计师：</label>
                                    <div class="col-sm-9">
                                        <a href="usercenter_public.jsp?uid=<%=designer.getUid()%>"
                                           class="form-control-static"><%=designer.getUsername()%>
                                        </a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">发布时间：</label>
                                    <div class="col-sm-9">
                                        <p class="form-control-static"><%=design.getTime()%>
                                        </p>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--底部-->
<div class="panel-footer text-center" id="footer">
    <h4>DesignTo服装设计服务平台</h4>
    <h5>Designer:
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Rimo
    </h5>
</div>
<!--引入 main.js-->
<script src="js/main.js"></script>
</body>

</html>
