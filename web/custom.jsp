<%@ page import="model.User" %>
<%@ page import="model.Require" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theme" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/26
  Time: 02:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    //handle the user cookie
    int uid = 0;
    Cookie[] cs = request.getCookies();
    for (Cookie c : cs) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    User user = User.getUserById(uid);

    List<Require> requires = Require.listRequire();
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个性化</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <style>
        .btn {
            background-color: rgba(0, 0, 0, 0);
            border: 2px solid rgb(214, 210, 210);
        }

        .label {
            margin-right: 20px;
        }

        #header-box {
            display: block;
            margin: 0;
            padding: 0;
        }

        .info-box {
            position: absolute;
            width: 80%;
            height: 3em;
            padding: .5em;
            left: 135px;
            display: block;
            font-size: 28pt;
            top: 150px;
        }

        .info-box button {
            margin-top: 35px;
        }

        #footer {
            width: 100%;
            position: relative;

        }

        .jumbotron {
            padding-bottom: 0;
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
                <li>
                    <a href="theme.jsp">主题</a>
                </li>
                <li class="active">
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


<div class="jumbotron" style="height:600px;">
    <div class="container-fluid" id="header-box">

        <img src="img/1.jpg" alt="..." style="height:600px;width:100%;position: absolute;">
        <div class="info-box">
            <label style="color: white;font-size:40pt;" class="h2">DesignTo</label>
            <br/>
            <label style="color: white;font-size:25pt" class="h4">寻找属于自己的个性化设计！</label>
            <br/>
            <button class="btn btn-default btn-lg" style="color: white;" onclick="
                <%if(user.getUid()==0){%>
                    window.location='login.jsp';
                <%}else{%>
                    window.location='require_submit.jsp';
                <%}%>
                    "> 提交需求
            </button>
        </div>
    </div>
</div>
<br/>
<!--列表主体-->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="container" style="padding-top:10px;">
                <%
                    for (Require require : requires) {
                        User requirer = User.getUserById(require.getUid());
                        Theme theme = Theme.getThemeById(require.getTid());
                %>
                <!--需求列表组件-->
                <div class="row">
                    <div class="panel panel-default" style="height:340px;">
                        <!--头像-->
                        <div class="col-md-3" style="display: inline;">
                            <div class="thumbnail">
                                <img src="<%=requirer.getHeader()%>"/>
                                <div class="caption text-center">
                                    <h4><%=requirer.getUsername()%>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <!--内容-->
                        <div class="col-md-6" style="height:100%;">
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
                                    <a href="usercenter_myrequire.jsp?uid=<%=requirer.getUid()%>"><%=requirer.getUsername()%>
                                    </a>
                                    发布于
                                    <label id="submit-time"><%=require.getTime()%>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <!--预算-->
                        <div class="col-md-3">
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

<div class="panel-footer text-center" id="footer">
    <h4>DesignTo服装设计服务平台</h4>
    <h5>Designer:
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Rimo</h5>
</div>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>
