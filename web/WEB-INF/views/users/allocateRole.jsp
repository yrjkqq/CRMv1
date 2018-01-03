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
    <title>分配角色</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
</head>
<body>

<div class="container-fluid">
    <!--顶部导航栏-->
    <div class="row">
        <%--动态引入--%>
        <jsp:include page="../commons/header.jsp"/>
    </div>

    <div class="row">
        <!--菜单-->
        <div class="col-md-2">
            <jsp:include page="../commons/menu.jsp">
                <jsp:param name="target" value="user"/>
            </jsp:include>
        </div>
        <div class="col-md-10">
            <!--分配角色-->
            <div class="row">
                <div class="col-md-8">
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                            为用户 <span style="font-weight: bold; color: red;">${user.username}</span> 分配角色
                            <button class="btn btn-warning btn-sm pull-right" style="margin-top: -5px" onclick="history.go(-1)">返回
                            </button>
                        </div>
                        <div class="panel-body">
                            <form class="form form-horizontal" action="users/allocateRole/${user.id}" method="post">
                                <div class="form-group">
                                    <label class="control-label col-md-2">用户名</label>
                                    <div class="col-md-10">
                                        <label class="control-label">${user.username}</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-2">角色列表</label>
                                    <div class="col-md-10">
                                        <c:forEach items="${allRoles}" var="role">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" value="${role.id}"
                                                    <%--当前用户已经拥有该角色则默认选中--%>
                                                    ${user.roles.contains(role) ? 'checked' : ''}
                                                       name="roles"/>${role.name}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-10 col-md-offset-2">
                                        <input class="btn btn-warning btn-sm" value="重置" type="reset"/>
                                        <input class="btn btn-primary btn-sm" value="提交" type="submit"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
<script>

</script>

