<%@ page import="model.User" %>
<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.Theme" %>
<%@ page import="model.Require" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int uid = 0;
    Cookie[] cookies = request.getCookies();
    for (Cookie c : cookies) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    User visitor = User.getUserById(uid);   //谁访问页面
    //必须登录用户访问自己的才能进入上传界面
    if (uid == 0) {
        MessageDispatcher.message(response, "warning", "访问错误，请登录！", "login.jsp");
        return;
    }
    //handle the rid
    int rid = 0;
    try{
        rid = Integer.parseInt(request.getParameter("rid"));
    }catch (Exception e){
    }
    if(rid == 0){
        MessageDispatcher.message(response,"danger", "该需求不存在！","custom.jsp");
    }
    Require require = Require.getRequireByRid(rid);
    User requirer = User.getUserById(require.getUid());
    //读取主题
    Theme theme = Theme.getThemeById(rid);

%>
<!DOCTYPE html>
<html>
<head>
    <title>提交定制</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <script src="js/jquery.min.js"></script>
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
            position: relative;
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
                <li>
                    <a href="custom.jsp" class="active">个性化</a>
                </li>
            </ul>
            <%
                if (visitor.getUid() != 0) {    //已登录
            %>
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">
                <div class="col-md-12">
                    <div class="col-md-5">
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
    <!--需求详情部分-->
    <div class="row">
        <div class="col-md-6 col-md-offset-3 panel">
            <div class="panel-body" style="font-size:12pt;">
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
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <!--分页切换的主体-->
            <div class="row" style="margin-top:20px;">
                <div class="container-fluid">
                    <div class="row" style="padding:20px;">
                        <form class="form-horizontal" method="post" action="customsubmit"
                              enctype="multipart/form-data">
                            <input type="hidden" name="uid" value="<%=uid%>" />
                            <input type="hidden" name="rid" value="<%=rid%>" />
                            <!-- 作品名行 -->
                            <div class="form-group">
                                <label for="design-name" class="col-md-3 control-label">作品名称：</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" id="design-name" placeholder="" name="title">
                                </div>
                            </div>
                            <!-- 作品主题行 -->
                            <div class="form-group">
                                <label for="design-theme" class="col-md-3 control-label">作品主题：</label>
                                <div class="col-md-7">
                                    <select class="form-control" id="design-theme" name="theme">
                                        <option value="<%=theme.getTid()%>"><%=theme.getName()%>
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <!-- 作品故事行 -->
                            <div class="form-group">
                                <label for="design-story" class="col-md-3 control-label">作品故事：</label>
                                <div class="col-md-7">
                                    <textarea id="design-story" class="form-control" rows="5" placeholder="说出你的故事吧！"
                                              name="desp"></textarea>
                                </div>
                            </div>
                            <!-- 上传文件行 -->
                            <div class="form-group">
                                <label for="design-file" class="col-md-3 control-label">上传作品：</label>
                                <div class="col-md-7">
                                    <input type="file" class="form-control" id="design-file" name="file"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-3 col-md-offset-3">
                                    <input type="submit" class="form-control btn btn-primary" value="上传作品"/>
                                </div>
                            </div>
                        </form>
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
