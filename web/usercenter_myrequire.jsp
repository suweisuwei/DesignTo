<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.User" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.DBConnection" %>
<%@ page import="model.Require" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theme" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/25
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <title>个人中心</title>
    <meta charset="utf-8"/>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <script src="js/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="js/bootstrap.min.js"></script>
    <style>
        .red {
            color: magenta;
        }

        #main-box {
            margin-top: 100px;
        }

        body {
            height: 100%;
        }

        #footer {
            width: 100%;
        }
    </style>
</head>

<body>
<%
    boolean self = false;
    //read cookie
    int uid = 0;
    Cookie[] cs = request.getCookies();
    for (Cookie c : cs) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    //访问谁的主页
    int owner = 0;
    String o = request.getParameter("uid");
    try {
        owner = Integer.parseInt(o);
    } catch (Exception e) {
    }
    //未登录用户想看自己的。禁止。
    if (uid == 0 && owner == 0) {
        MessageDispatcher.message(response, "warning", "登录超时！请重新登录！", "login.jsp");
        return;
    }
    if (owner == 0 || uid == owner) {
        self = true;
    }
    User visitor = User.getUserById(owner);
    User hoster = User.getUserById(uid);
    char sex;
    if (hoster.getSex() == 'M') {
        sex = '♂';
    } else if (hoster.getSex() == 'F') {
        sex = '♀';
    } else {
        sex = '?';
    }
    int publicCount = User.getUserDesignCount(hoster.getUid());
    int likeCount = User.getUserLikeCount(hoster.getUid());

    //handle the requires
    List<Require> requires = Require.listRequireByUid(uid);

%>
<!--导航-->
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
                <li>
                    <a href="theme.jsp">主题</a>
                </li>
                <li>
                    <a href="custom.jsp">个性化</a>
                </li>
            </ul>
            <%
                if (visitor.getUid() != 0) {    //已登录
            %>
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">
                <div class="col-md-12">
                    <div class="col-md-3">
                        <button type="button" class="btn btn-default"
                                onclick="window.location='usercenter_public.jsp?uid=<%=visitor.getUid()%>';">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span><%=visitor.getUsername()%>
                        </button>
                    </div>
                    <div class="col-md-3">
                        <button type="button" class="btn btn-default" onclick="window.location='logout'">退出</button>
                    </div>
                </div>
            </div>
            <%
            } else {        //未登录
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
        <div class="col-md-8 col-md-offset-2">
            <!--个人信息栏-->
            <div id="user-info-row" class="row">
                <img src="<%=hoster.getHeader()%>" style="float:left;width:150px;height:150px;" class="img-thumbnail"
                     alt="头像"/>
                <div class="col-md-6">
                    <label class="h4" id="username"><%=hoster.getUsername()%>
                    </label>
                    <span class="sex" style="color:#99ccff"><%=sex%></span>
                    <br/>
                    <label>共提交
                        <label class="red"><%=publicCount%>
                        </label>次作品，共获得
                        <label class="red"><%=likeCount%>
                        </label>个赞。
                    </label>
                    <br/>
                    <label>联系邮箱：
                        <a href="mailto:<%=hoster.getEmail()%>"><%=hoster.getEmail()%>
                        </a>
                    </label>
                    <br/>
                    <label>联系电话：
                        <a href="#"><%=hoster.getTele()%>
                        </a>
                    </label>
                </div>
            </div>
            <!--分页栏-->
            <div class="row">
                <ul class="nav nav-tabs">
                    <li role="presentation">
                        <a href="usercenter_public.jsp?uid=<%=hoster.getUid()%>">公开作品</a>
                    </li>
                    <%if (self) {%>
                    <li role="presentation">
                        <a href="usercenter_upload.jsp?uid=<%=hoster.getUid()%>">上传作品</a>
                    </li>
                    <%}%>
                    <li role="presentation" class="active">
                        <a href="usercenter_myrequire.jsp?uid=<%=hoster.getUid()%>">我的需求</a>
                    </li>
                    <%if (self) {%>
                    <li role="presentation">
                        <a href="usercenter_mycustom.jsp?uid=<%=hoster.getUid()%>">我的服务</a>
                    </li>
                    <%}%>
                </ul>
            </div>
            <!--分页切换的主体-->
            <div class="row" style="margin-top:20px;">
                <div class="container-fluid">
                    <div class="row">
                        <%for(Require require : requires){
                            Theme theme = Theme.getThemeById(require.getTid());
                        %>
                        <!--需求列表组件-->
                        <div class="row">
                            <div class="panel panel-default" style="height:340px;">
                                <!--头像-->
                                <div class="col-md-3" style="display: inline;">
                                    <div class="thumbnail">
                                        <img src="<%=hoster.getHeader()%>"/>
                                        <div class="caption text-center">
                                            <h4><%=hoster.getUsername()%>
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                                <!--内容-->
                                <div class="col-md-7" style="height:100%;">
                                    <div class="container-fluid" style="height:100%">
                                        <!--title-->
                                        <div class="row">
                                            <a href="require_detail.jsp?rid=<%=require.getRid()%>">
                                                <h2><%=require.getTitle()%>
                                                </h2>
                                            </a>
                                        </div>
                                        <!--tags(time and type)-->
                                        <div class="row">
                                            <a class="label label-success" href="theme.jsp?tid=<%=theme.getTid()%>">
                                                <%=theme.getName()%>
                                            </a>
                                            <span class="label label-warning">
                                            <%=require.getDdl()%>
                                        </span>
                                        </div>
                                        <!--content-->
                                        <div class="row">
                                            <p><%=require.getDesp()%>
                                            </p>
                                        </div>
                                        <!--submitter-->
                                        <div class="row" style="position: absolute;bottom:1em;">
                                            <a href="usercenter_myrequire.jsp?uid=<%=hoster.getUid()%>"><%=hoster.getUsername()%>
                                            </a>
                                            发布于
                                            <label id="submit-time"><%=require.getTime()%>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <!--预算-->
                                <div class="col-md-2">
                                    <h2>
                                        <label style="color:red;">¥</label><%=require.getBudget()%>
                                    </h2>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--底部-->
<footer class="panel-footer text-center" id="footer">
    <h4>DesignTo服装设计服务平台</h4>
    <h5>Designer:
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Star
    </h5>
</footer>
<!--引用 main.js-->
<script src="js/main.js"></script>
</body>

</html>
