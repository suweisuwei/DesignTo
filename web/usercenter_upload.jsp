<%@ page import="model.User" %>
<%@ page import="model.PublicDesign" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.DBConnection" %>
<%@ page import="model.Theme" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.MessageDispatcher" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/5/25
  Time: 02:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>个人中心</title>
    <meta charset="utf-8" />
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
<%
    int uid = 0;
    Cookie[] cookies = request.getCookies();
    for(Cookie c :cookies){
        if(c.getName().equals("uid")){
            uid = Integer.parseInt(c.getValue());
        }
    }
    User user = User.getUserById(uid);
    if(uid==0||user.getUid()==0){
        MessageDispatcher.message(response,"warning","访问错误，请登录！", "login.jsp");
        return;
    }
    char sex;
    if(user.getSex()=='M'){
        sex = '♂';
    }else if(user.getSex() == 'F'){
        sex = '♀';
    }else{
        sex = '?';
    }
    //读取作品统计和点赞统计
    ResultSet rs = DBConnection.querySql("select count(*) from public_design where uid="+uid+";");
    rs.next();
    String publicCount = rs.getString(1);
    ResultSet rs2 = DBConnection.querySql("select sum(count) from public_design where uid = "+uid+";");
    rs2.next();
    String likeCount = rs.getString(1);
    //读取主题列表
    ResultSet themeRs = DBConnection.querySql("select * from theme");
    List<Theme> themes = new LinkedList<>();
    themeRs.next();
    while(!themeRs.isAfterLast()){
        themes.add(new Theme(themeRs));
        themeRs.next();
    }

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
                <li >
                    <a href="theme.jsp">主题</a>
                </li>
                <li>
                    <a href="custom.jsp">个性化</a>
                </li>
            </ul>
            <div class="row nav navbar-nav navbar-right" style="margin-top:.4em">

                <ul class="col-lg-3">
                    <li>
                        <button type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-user" aria-hidden="true" style="padding:.3em .7em;font-size: 12pt;"></span><%=user.getUsername()%>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<!--页面主体-->
<div class="container-fluid" id="main-box">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <!--个人信息栏-->
            <div id="user-info-row" class="row">
                <img src="<%=user.getHeader()%>" style="float:left;width:150px;height:150px;" class="img-thumbnail" alt="头像" />
                <div class="col-md-6">
                    <label class="h4" id="username"><%=user.getUsername()%></label>
                    <span class="sex" style="color:#99ccff"><%=sex%></span>
                    <br />
                    <label>共提交
                        <label class="red"><%=publicCount%></label>次作品，共获得
                        <label class="red"><%=likeCount%></label>个赞。
                    </label>
                    <br />
                    <label>联系邮箱：
                        <a href="mailto:1009789268@qq.com"><%=user.getEmail()%></a>
                    </label>
                    <br />
                    <label>联系电话：
                        <a href="#"><%=user.getTele()%></a>
                    </label>
                </div>
            </div>
            <!--分页栏-->
            <div class="row">
                <ul class="nav nav-tabs">
                    <li role="presetation">
                        <a href="usercenter_public.html">公开作品</a>
                    </li>
                    <li role="presetation" class="active">
                        <a href="usercenter_upload.html">上传作品</a>
                    </li>
                    <li role="presetation">
                        <a href="usercenter_myrequire.html">我的需求</a>
                    </li>
                    <li role="presetation">
                        <a href="#">我的服务</a>
                    </li>
                </ul>
            </div>
            <!--分页切换的主体-->
            <div class="row" style="margin-top:20px;">
                <div class="container-fluid">
                    <div class="row" style="padding:20px;">
                        <form class="form-horizontal" method="post" action="/uploadPublic" enctype="multipart/form-data">
                            <!-- 作品名行 -->
                            <div class="form-group">
                                <label for="design-name" class="col-md-3 control-label">作品名称：</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" id="design-name" placeholder="" name="design-name">
                                </div>
                            </div>
                            <!-- 作品主题行 -->
                            <div class="form-group">
                                <label for="design-theme" class="col-md-3 control-label">作品主题：</label>
                                <div class="col-md-7">
                                    <select class="form-control" id="design-theme" name="design-theme">
                                        <%
                                            for(Theme t:themes){

                                                %>
                                                <option value="<%=t.getTid()%>"><%=t.getName()%></option>
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
                                    <textarea id="design-story" class="form-control" rows="5" placeholder="说出你的故事吧！" name="design-story"></textarea>
                                </div>
                            </div>
                            <!-- 上传文件行 -->
                            <div class="form-group">
                                <label for="design-file" class="col-md-3 control-label">上传作品：</label>
                                <div class="col-md-7">
                                    <input type="file" class="form-control" id="design-file" name="design-file"/>
                                </div>
                            </div>
                            <!-- TODO 预览上传文件 -->
                            <div class="form-group">
                                <div class="col-md-3 col-md-offset-3">
                                    <input type="submit" class="form-control btn btn-primary" name="design-file" value="上传作品"/>
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
