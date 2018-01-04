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
<%--<ul class="list-group">
    <li class="list-group-item disabled"><span class="glyphicon glyphicon-list"></span>&nbsp;菜单</li>
    <li class="list-group-item">
        <div class="row">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="${param.target}s/index">
                    <span class="glyphicon glyphicon-home"></span>&nbsp;首页</a>
                </li>
                <li role="presentation"><a href="${param.target}s/index">
                    <span class="glyphicon glyphicon-th-list"></span>&nbsp;机会管理</a>
                </li>
                <li role="presentation"><a href="${param.target}s/index">
                    <span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;营销管理</a>
                </li>
                <!-- 注册点击事件, 点击后展开下层菜单, 并改变右侧图标-->
                <li role="presentation">
                    <a onclick="expandSystemMenu()">
                        <span style="margin-right: 50px;"><span class="glyphicon glyphicon-cog"></span>&nbsp;系统设置</span>
                        <span id="rightMark" class="glyphicon glyphicon-chevron-left"></span>
                    </a>

                    <div class="col-md-offset-1" id="systemMenu">
                        <ul class="nav nav-pills nav-stacked">
                            <li role="presentation" class="${param.target == 'user' ? 'active' : ''}">
                                <a href="users/index">
                                    <span class="glyphicon glyphicon-user"></span>&nbsp;用户管理
                                </a>
                            </li>
                            <li role="presentation" class="${param.target == 'role' ? 'active' : ''}">
                                <a href="roles/index">
                                    <span class="glyphicon glyphicon-eye-open"></span>&nbsp;角色管理
                                </a>
                            </li>
                            <li role="presentation" class="${param.target == 'resource' ? 'active' : ''}">
                                <a href="resources/index">
                                    <span class="glyphicon glyphicon-eye-open"></span>&nbsp;资源管理
                                </a>
                            </li>
                            <li role="presentation">
                                <a href="${param.target}s/index">
                                    <span class="glyphicon glyphicon-list"></span>&nbsp;菜单管理
                                </a>
                            </li>
                        </ul>
                    </div>

                </li>
            </ul>
        </div>
    </li>
</ul>--%>

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
    function expandSystemMenu() {
        var $systemMenu = $("#systemMenu");
        var $rightMark = $("#rightMark");
        if ($systemMenu.css("display") === "none") {
            $systemMenu.css("display", "block");
            // 改变右侧图标为向下箭头
            $rightMark.attr("class", "glyphicon glyphicon-chevron-down");
        } else {
            $systemMenu.css("display", "none");
            $rightMark.attr("class", "glyphicon glyphicon-chevron-left")
        }
    }

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
