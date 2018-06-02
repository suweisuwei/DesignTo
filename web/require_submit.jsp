<%@ page import="model.User" %>
<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.Require" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theme" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/26
  Time: 20:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    //handle the user cookie
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
    if(user.getUid() == 0){
        MessageDispatcher.message(response, "warning","登录超时！","login.jsp");
    }
    //handle the themes
    List<Theme> themes = Theme.listTheme();
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布需求</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        #footer {
            width: 100%;
            position: relative;

        }

        form {
            font-size: 15pt;
        }

        .form-group {
            margin-top: 25px;
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
<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <form class="form-horizontal" style="padding: 150px;" method="post" action="require_submit">
                <div class="form-group">
                    <label for="inputRequireTitle" class="col-sm-3 control-label">需求标题</label>
                    <div class="col-sm-9">
                        <input name="title" type="text" class="form-control input-lg" id="inputRequireTitle" placeholder="需求标题">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputRequireType" class="col-sm-3 control-label">需求主题</label>
                    <div class="col-sm-9">
                        <select name="theme" id="inputRequireType">
                            <%for(Theme theme : themes){%>
                            <option value="<%=theme.getTid()%>"><%=theme.getName()%></option>
                            <%}%>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputAccount" class="col-sm-3 control-label">项目预算</label>
                    <div class="col-md-9">
                        <div class="input-group ">
                            <div class="input-group-addon">$</div>
                            <input name="budget" type="text" class="form-control input-lg" id="inputAccount" placeholder="为这个项目您准备多少金额预算">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputDeadline" class="col-sm-3 control-label">项目截止时间</label>
                    <div class="col-sm-9">
                        <input name="ddl" type="text" class="form-control input-lg" id="inputDeadline" placeholder="您希望设计师什么时候完成项目？">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputDescription" class="col-sm-3 control-label">需求描述</label>
                    <div class="col-sm-9">
                        <textarea name="desp" class="form-control input-lg" id="inputDescription" placeholder="具体介绍您的需求"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <button type="submit" class="btn btn-default btn-lg">提交</button>
                    </div>
                </div>

            </form>
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
