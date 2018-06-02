<%@ page import="model.User" %>
<%@ page import="model.Theme" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.MessageDispatcher" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/25
  Time: 02:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <title>个人中心</title>
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
<%
    int uid = 0;
    Cookie[] cookies = request.getCookies();
    for (Cookie c : cookies) {
        if (c.getName().equals("uid")) {
            uid = Integer.parseInt(c.getValue());
        }
    }
    int owner = 0;
    try {
        owner = Integer.parseInt(request.getParameter("uid"));
    } catch (Exception e) {
    }
    User visitor = User.getUserById(uid);   //谁访问页面
    User hoster = User.getUserById(owner);  //访问谁的页面
    //必须登录用户访问自己的才能进入上传界面
    if (uid == 0 || uid != owner) {
        MessageDispatcher.message(response, "warning", "访问错误，请登录！", "login.jsp");
        return;
    }
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
    //读取主题列表
    List<Theme> themes = Theme.listTheme();

%>
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
                    <a href="custom.jsp">个性化</a>
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
                        <a href="mailto:1009789268@qq.com"><%=hoster.getEmail()%>
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
                    <li role="presentation" class="active">
                        <a href="usercenter_upload.jsp?uid=<%=hoster.getUid()%>">上传作品</a>
                    </li>
                    <li role="presentation">
                        <a href="usercenter_myrequire.jsp?uid=<%=hoster.getUid()%>">我的需求</a>
                    </li>
                    <li role="presentation">
                        <a href="usercenter_mycustom.jsp?uid=<%=hoster.getUid()%>">我的服务</a>
                    </li>
                </ul>
            </div>
            <!--分页切换的主体-->
            <div class="row" style="margin-top:20px;">
                <div class="container-fluid">
                    <div class="row" style="padding:20px;">
                        <form class="form-horizontal" method="post" action="uploadPublic"
                              enctype="multipart/form-data">
                            <!-- 作品名行 -->
                            <div class="form-group">
                                <label for="design-name" class="col-md-3 control-label">作品名称：</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" id="design-name" placeholder="" name="name">
                                </div>
                            </div>
                            <!-- 作品主题行 -->
                            <div class="form-group">
                                <label for="design-theme" class="col-md-3 control-label">作品主题：</label>
                                <div class="col-md-7">
                                    <select class="form-control" id="design-theme" name="theme">
                                        <%
                                            for (Theme t : themes) {

                                        %>
                                        <option value="<%=t.getTid()%>"><%=t.getName()%>
                                        </option>
                                        <%
                                            }
                                        %>
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
                            <!-- TODO 预览上传文件 -->
                            <div class="form-group">
                                <div class="col-md-3 col-md-offset-3">
                                    <input type="submit" class="form-control btn btn-primary" name="design-file"
                                           value="上传作品"/>
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
        <span class="glyphicon glyphicon-star" style="color: gold" aria-hidden="true"></span>Rimo
    </h5>
</footer>
<!--引用 main.js-->
<script src="js/main.js"></script>
</body>

</html>
