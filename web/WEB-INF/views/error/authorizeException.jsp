<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <title>未授权操作</title>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
</head>

<body>
<div class="container">
    <h2 class="page-header">${tip}</h2>
    <strong>你可以选择:</strong>
    <a role="button" class="btn btn-primary btn-xs" onclick="history.go(-1)">返回</a>
    <a role="button" class="btn btn-danger btn-xs" href="/crm">重新登陆</a>
</div>
</body>
</html>
