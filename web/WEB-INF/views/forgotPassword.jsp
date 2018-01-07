<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <title>找回密码</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
</head>

<body>
<div class="container">

    <div class="row" style="margin-top:100px; margin-bottom:auto">
        <div class="col-md-4 col-md-offset-4">
            <form class="form" action="crm/forgotPassword" method="post">
                <div class="panel panel-default">
                    <div class="panel-heading text-center">
                        <strong>找回密码</strong>
                    </div>
                    <div class="panel-body">
                        <div class="alert alert-success" role="alert">
                            <strong>Well done!</strong> 将发送一封邮件到你的注册邮箱, 将查收!
                        </div>
                        <div class="form-group">
                            <label class="control-label">用户名</label>
                            <input class="form-control" type="text" name="username"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">注册邮箱</label>
                            <input class="form-control" type="text" name="email"/>

                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-sm btn-block" value="提交"/>
                        </div>
                        <div class="text-right">
                            <a href="crm/login">去登陆</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
