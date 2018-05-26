<%@ page import="model.User" %>
<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.Require" %>
<%@ page import="model.CustomDesign" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theme" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/26
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    boolean isHoster = false;
    boolean isJoiner = false;
    //handle the user cookie
    int uid = 0;
    Cookie[] cs = request.getCookies();
    for (Cookie c : cs) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    User visitor = User.getUserById(uid);

    //handle the require id
    int rid = 0;
    try {
        rid = Integer.parseInt(request.getParameter("rid"));
    } catch (Exception e) {
    }
    if (rid == 0) {
        MessageDispatcher.message(response, "danger", "该需求不存在！", "custom.jsp");
        return;
    }
    Require require = Require.getRequireByRid(rid);
    User requirer = User.getUserById(require.getUid());
    Theme theme = Theme.getThemeById(require.getTid());
    List<CustomDesign> designs = CustomDesign.listDesignByRid(rid);
    if (require.getUid() == visitor.getUid()) {
        isHoster = true;
    } else {
        for (CustomDesign design : designs) {
            if (design.getUid() == visitor.getUid()) {
                isJoiner = true;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>定制列表</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        #content {
            /* padding-top:100px; */
        }

        form p {
            padding-top: 7px;
        }

        #footer {
            width: 100%;
        }
    </style>
</head>
<body>
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
                <li class="active">
                    <a href="custom.jsp">个性化</a>
                </li>
            </ul>
            <%if (visitor.getUid() != 0) { %>
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">
                <ul class="col-lg-3">
                    <li>
                        <button type="button" class="btn btn-default"
                                onclick="window.location='usercenter_public.jsp?uid=<%=visitor.getUid()%>';">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span><%=visitor.getUsername()%>
                        </button>
                    </li>
                </ul>
            </div>
            <%} else {%>
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
            <%}%>
        </div>
    </div>
</nav>
<!--页面主体-->
<div class="container-fluid" id="content">
    <!--需求详情部分-->
    <div class="row">
        <div class="col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2 panel">
            <div class="panel-body" style="margin-top:100px;font-size:12pt;">
                <!--标题行-->
                <div class="form-group">
                    <label class="col-md-3 control-label">需求标题：</label>
                    <div class="col-md-9">
                        <p class="form-control-static"><%=require.getTitle()%>
                        </p>
                    </div>
                </div>
                <!--主题行-->
                <div class="form-group">
                    <label class="col-md-3 control-label">需求主题：</label>
                    <div class="col-md-9">
                        <p class="form-control-static">
                            <a class="label label-default"
                               onclick="window.location='theme.jsp?tid=<%=theme.getTid()%>';"><%=theme.getName()%>
                            </a>
                        </p>
                    </div>
                </div>
                <!--时间行-->
                <div class="form-group">
                    <label class="col-md-3 control-label">截止时间：</label>
                    <div class="col-md-9">
                        <p class="form-control-static"><%=require.getDdl()%>
                        </p>
                    </div>
                </div>
                <!--预算行-->
                <div class="form-group">
                    <label class="col-md-3 control-label">预算：</label>
                    <div class="col-md-9">
                        <p class="form-control-static">
                            <label class="h4">￥</label><%=require.getBudget()%>
                        </p>
                    </div>
                </div>
                <!--需求描述行-->
                <div class="form-group">
                    <label class="col-md-3 control-label">需求描述：</label>
                    <div class="col-md-9">
                        <p class="form-control-static">
                            <%=require.getDesp()%>
                        </p>
                    </div>
                </div>
                <!--发布者行-->
                <div class="form-group">
                    <label class="col-md-3 control-label">发布者：</label>
                    <div class="col-md-9">
                        <a class="form-control-static"
                           onclick="window.location='usercenter_myrequire.jsp?uid=<%=requirer.getUid()%>'">
                            <%=requirer.getUsername()%>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <%if (isHoster) {%>
    <!--需求回应详情列表-->
    <div class="row">
        <div class="col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="container-fluid">
                        <%
                            if (designs.isEmpty()) {
                        %>
                        <div class="col-12 text-center">
                            <p class="h2">暂时没有用户提交作品！</p>
                        </div>
                        <%
                        } else {
                            for (CustomDesign design : designs) {
                                User designer = User.getUserById(design.getUid());
                        %>
                        <!--用户需求回应详情组件-->
                        <div class="row">
                            <div class="col-md-3">
                                <a href="#" class="thumbnail">
                                    <img src="<%=designer.getHeader()%>" class="img-circle" style="height:210px;"/>
                                    <div class="caption text-center">
                                        <h4><%=designer.getUsername()%>
                                        </h4>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-9">
                                <img src="<%=design.getImg()%>" style="padding:10px; width:90%;"/>
                                <div clsss="caption"><%=design.getDesp()%>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%} else if (isJoiner) {%>
    <!--需求回应用户列表-->
    <div class="row">
        <div class="col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title">已参与的设计师：</div>
                </div>
                <div class="panel-body">
                    <div class="container-fluid">
                        <div class="row">
                            <%
                                if (designs.isEmpty()) {
                            %>
                            <div class="col-12 text-center">
                                <p class="h2">暂时没有用户提交作品！</p>
                            </div>
                            <%
                            } else {
                                for (CustomDesign design : designs) {
                                    User designer = User.getUserById(design.getUid());
                            %>
                            <!--参与用户列表组件-->
                            <div class="col-xs-4 col-sm-3 col-md-2">
                                <a href="#" class="thumbnail">
                                    <img src="<%=designer.getHeader()%>" class="img-circle" style="height:140px;"/>
                                    <div class="caption text-center">
                                        <h4><%=designer.getUsername()%>
                                        </h4>
                                    </div>
                                </a>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
    } else {
    %>
    <!--参与按钮-->
    <div class="row">
        <div class="panel">
            <div class="panel-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-2 col-md-offset-5">
                            <button class="btn btn-success"
                                    onclick="window.location='custom_submit.jsp?rid=<%=require.getRid()%>'">提交作品</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }%>
</div>
<!--底部-->
<div class="panel-footer text-center" id="footer">
    <h4>DesignTo服装设计服务平台</h4>
    <h5>Designer:
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Star
    </h5>
</div>
<!--引入 main.js-->
<script src="js/main.js"></script>
</body>

</html>