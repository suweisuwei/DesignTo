<%@ page import="servlet.MessageDispatcher" %>
<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: haoxingxiao
  Date: 2018/6/2
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    //FIXME 是否需要判断登录用户的权限？
    //handle the uid parameter
    int uid = 0;
    try{
        uid = Integer.parseInt(request.getParameter("uid"));
    }catch (Exception e){
        uid = 0;
    }
    if(uid == 0){
        MessageDispatcher.message(response,"danger","该用户不存在！","manage_user.jsp");
    }
    //get the user info
    User user = User.getUserById(uid);
%>
<html>
<head>
    <title>修改用户</title>
    <style>
        .main-box{
            width:800px;
            margin:auto;
            margin-top:100px;
            border:2px solid gray;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <form class="form-horizontal" style="padding: 150px;" method="post" action="/modifyuser">
                <input type="hidden" name="uid" value="<%=user.getUid()%>" />
                <div class="form-group">
                    <label for="inputUsername" class="col-sm-3 control-label">用户名</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control input-md" id="inputUsername" placeholder="请输入用户名"
                               name="username" value="<%=user.getUsername()%>">
                    </div>
                    <span id="usernameInfo" style="position: absolute;right:-20px;"></span>
                </div>
                <div class="form-group">
                    <label for="inputTel" class="col-sm-3 control-label">电话</label>
                    <div class="col-md-9">

                        <input type="text" class="form-control input-md" id="inputTel" placeholder="请输入电话" name="tele" value="<%=user.getTele()%>">

                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-3 control-label">邮箱</label>
                    <div class="col-md-9">

                        <input type="email" class="form-control input-md" id="inputEmail" placeholder="请输入邮箱"
                               name="email" value="<%=user.getEmail()%>">

                    </div>
                </div>
                <div class="form-group">
                <label for="inputSex" class="col-sm-3 control-label">性别</label>
                <div class="col-md-9">

                    <select class="form-control input-md" id="inputSex" name="sex">
                        <option value="M" <%='M'==user.getSex()?"selected=\"selected\"":""%>>男</option>
                        <option value="F" <%='F'==user.getSex()?"selected=\"selected\"":""%>>女</option>
                    </select>

                </div>
            </div>
                <div class="form-group">
                    <label for="inputIsadmin" class="col-sm-3 control-label">管理员</label>
                    <div class="col-md-9">

                        <select class="form-control input-md" id="inputIsadmin" name="isadmin">
                            <option value=1 <%=user.getIsadmin()?"selected=\"selected\"":""%>>是</option>
                            <option value=0 <%=!user.getIsadmin()?"selected=\"selected\"":""%>>否</option>
                        </select>

                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <input class="btn btn-default btn-lg" type="submit" value="修改"/>
                    </div>
                </div>

            </form>
        </div>
    </div>

</div>
</body>
</html>
