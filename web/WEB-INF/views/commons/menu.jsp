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
</head>

<body>
<ul class="list-group">
    <li class="list-group-item disabled"><span class="glyphicon glyphicon-list"></span>&nbsp;菜单</li>
    <li class="list-group-item">
        <div class="row">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="crm/${param.target}"><span
                        class="glyphicon glyphicon-home"></span>&nbsp;首页</a>
                </li>
                <li role="presentation"><a href="crm/${param.target}"><span class="glyphicon glyphicon-th-list"></span>&nbsp;机会管理</a>
                </li>
                <li role="presentation"><a href="crm/${param.target}"><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;营销管理</a>
                </li>
                <!-- 注册点击事件, 点击后展开下层菜单, 并改变右侧图标-->
                <li role="presentation">
                    <a onclick="expandSystemMenu()">
                        <span style="margin-right: 50px;"><span class="glyphicon glyphicon-cog"></span>&nbsp;系统设置</span>
                        <span id="rightMark" class="glyphicon glyphicon-chevron-left"></span>
                    </a>

                    <div class="col-md-offset-1" id="systemMenu">
                        <ul class="nav nav-pills nav-stacked">
                            <li role="presentation" class="${param.target == 'main' ? 'active' : ''}"><a href="crm/main"><span
                                    class="glyphicon glyphicon-user"></span>&nbsp;用户管理</a>
                            </li>
                            <li role="presentation" class="${param.target == 'role' ? 'active' : ''}"><a href="crm/role"><span
                                    class="glyphicon glyphicon-eye-open"></span>&nbsp;角色管理</a>
                            </li>
                            <li role="presentation" class="${param.target == 'resource' ? 'active' : ''}"><a href="crm/resource"><span
                                    class="glyphicon glyphicon-eye-open"></span>&nbsp;资源管理</a>
                            </li>
                            <li role="presentation"><a href="crm/${param.target}"><span
                                    class="glyphicon glyphicon-list"></span>&nbsp;菜单管理</a>
                            </li>
                        </ul>
                    </div>

                </li>
            </ul>
        </div>
    </li>
</ul>
</body>
</html>
