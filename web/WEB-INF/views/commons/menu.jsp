<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <title>左侧菜单</title>
    <style>
        .list-group-item {
            border-top: 0;
        }
    </style>
</head>

<body>

<div class="list-group">
    <a class="list-group-item disabled">
        <span class="glyphicon glyphicon-tasks"></span>&nbsp;&nbsp;<strong>菜单</strong>
    </a>
    <a href="crm/main" class="list-group-item">
        <span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;首页
    </a>
    <a href="crm/main" class="list-group-item" onclick="hideChild('company', event, this)">
        <span class="glyphicon glyphicon-th-list"></span>&nbsp;&nbsp;公司管理
        <span class="glyphicon glyphicon-plus-sign pull-right"></span>
    </a>

    <a href="depts/index" class="list-group-item" onclick="hideChild('dept', event, this)">
        <span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;部门管理
        <span class="glyphicon glyphicon-plus-sign pull-right"></span>
    </a>
    <%--属于同一个父节点的子结点使用相同的 name --%>
    <a href="users/index" class="list-group-item" name="dept">
        <div class="col-md-offset-1">
            <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;用户管理
        </div>
    </a>
    <a href="roles/index" class="list-group-item" name="dept">
        <div class="col-md-offset-1">
            <span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;角色管理
        </div>
    </a>

    <a href="menus/index" class="list-group-item" onclick="hideChild('menu', event, this)">
        <span class="glyphicon glyphicon-object-align-left"></span>&nbsp;&nbsp;菜单管理
        <span class="glyphicon glyphicon-plus-sign pull-right"></span>
    </a>
    <a href="resources/index" class="list-group-item" name="menu">
        <div class="col-md-offset-1">
            <span class="glyphicon glyphicon-check"></span>&nbsp;&nbsp;资源管理
        </div>
    </a>

    <a href="#" class="list-group-item">
        <span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;服务管理
    </a>
</div>


</body>
</html>
<script>

    // 隐藏子结点
    function hideChild(parentName, event, obj) {
        $("a[name=" + parentName + "]").each(function () {
            $(this).toggleClass("hide");
            // 改变右侧图标
            var mark = $(this).hasClass("hide") ? "plus" : "minus";
            $(obj).find("span").eq(1).attr("class", "glyphicon glyphicon-" + mark + "-sign pull-right");
        });

    }
</script>
