<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <title>CRM 权限模型</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
</head>

<body>
<div class="container">

    <div class="row" style="margin-top:100px; margin-bottom:auto">
        <div class="col-md-4 col-md-offset-4">
            <form class="form" action="crm/testify" method="post">
                <div class="panel panel-default">
                    <div class="panel-heading text-center">
                        <strong>用户登陆</strong>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="control-label">用户名</label>
                            <input class="form-control" type="text" name="username" value="${username}"/>
                            <span style="color:red; font-size: small">${usernameTip}</span>
                        </div>
                        <div class="form-group">
                            <label class="control-label">密码</label>
                            <input class="form-control" type="password" name="password"/>
                            <span style="color:red; font-size: small">${passwordTip}</span>
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-sm btn-block" value="登陆"/>
                        </div>
                        <div class="text-right">
                            <%--todo 添加密码找回功能--%>
                            <a href="#">忘记密码?</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
