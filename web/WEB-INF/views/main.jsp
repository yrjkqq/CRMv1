<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <title>主页面</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">

</head>
<body>

<div class="container-fluid">
    <!--顶部导航栏-->
    <div class="row">
        <jsp:include page="commons/header.jsp"/>
    </div>

    <%--todo 在主页上分配菜单和其对应的地址--%>
    <div class="row">
        <!--菜单-->
        <div class="col-md-2">
            <jsp:include page="commons/menu.jsp">
                <jsp:param name="main" value="crm/main"/>
                <jsp:param name="depts" value="depts/index"/>
                <jsp:param name="users" value="users/index"/>
                <jsp:param name="roles" value="roles/index"/>
                <jsp:param name="menus" value="menus/index"/>
                <jsp:param name="resources" value="resources/index"/>
            </jsp:include>
        </div>
        <div class="col-md-10">

            <div class="row">
                <h3 class="page-header">
                    欢迎登陆
                </h3>
            </div>
        </div>
    </div>
</div>

</body>
</html>



