<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>注册</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        #footer {
            width: 100%;

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
                <li class="active">
                    <a href="homepage.html">首页</a>
                </li>
                <li>
                    <a href="theme.html">主题</a>
                </li>
                <li>
                    <a href="custom.html">个性化</a>
                </li>
            </ul>
            <div class="row nav nabbar-nav navbar-right" style="margin-top:.4em">

                <div class="col-md-12">
                    <div class="col-md-3">
                        <button type="button" class="btn btn-default" onclick="window.location='signup.jsp'">注册</button>
                    </div>
                    <div class="col-md-3"></div>
                    <button type="button" class="btn btn-default" onclick="window.location='login.jsp'">登录</button>
                </div>
            </div>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <form class="form-horizontal" style="padding: 150px;" method="post" action="/signup" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="inputUsername" class="col-sm-3 control-label">用户名</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control input-md" id="inputUsername" placeholder="请输入用户名" name="username">

                    </div>
                    <span id="usernameInfo" style="position: absolute;right:-20px;"></span>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-3 control-label">密码</label>
                    <div class="col-md-9">

                        <input type="password" class="form-control input-md" id="inputPassword" placeholder="请输入密码" name="password">

                    </div>
                </div>
                <div class="form-group">
                    <label for="inputTel" class="col-sm-3 control-label">电话</label>
                    <div class="col-md-9">

                        <input type="text" class="form-control input-md" id="inputTel" placeholder="请输入电话" name="tele">

                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-3 control-label">邮箱</label>
                    <div class="col-md-9">

                        <input type="email" class="form-control input-md" id="inputEmail" placeholder="请输入邮箱" name="email">

                    </div>
                </div>
                <div class="form-group">
                    <label for="inputSex" class="col-sm-3 control-label">性别</label>
                    <div class="col-md-9">

                        <select class="form-control input-md" id="inputSex" name="sex">
                            <option value="M">男</option>
                            <option value="F">女</option>
                        </select>

                    </div>
                </div>
                <div class="form-group">
                    <label for="inputHeader" class="col-sm-3 control-label">上传头像</label>
                    <div class="col-md-9">
                        <input type="file" name="header" id="inputHeader" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <input class="btn btn-default btn-lg" type="submit" value="提交"/>
                    </div>
                </div>

            </form>
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
<script>
    $("#inputUsername").change(function (ev) {
        var info = $("#usernameInfo");
        info.text("…");

        var username = $("#inputUsername").val();
        $.get(
            "/userexist",
            {username:username},
            function(data){
                console.log("user exist:"+data);
                console.log(data=="true");
                if(data == "true"){
                    info.text("用户名已存在！");
                    info.css("color","red");
                }else{
                    info.text("用户名可用！");
                    info.css("color","green");
                }
            }
        );
    });
</script>
</body>

</html>