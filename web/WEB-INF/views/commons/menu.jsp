<%@ page import="com.cdsxt.po.Role" %>
<%@ page import="com.cdsxt.po.User" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    User currentUser = (User) request.getSession().getAttribute("currentUser");
    Set<Role> currentUserRoles = currentUser.getRoles();
    // 保存最长的集合即可
    int count = 0;
    Iterator<Role> iterator = currentUserRoles.iterator();
    while (iterator.hasNext()) {
        Role role = iterator.next();
        int tmp = role.getResources().size();
        if (tmp > count) {
            count = tmp;
        }
    }
    request.setAttribute("count", count);
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
    <a href="crm/main" class="list-group-item ${param.target == 'main' ? 'active' : ''}">
        <span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;首页
    </a>
    <c:forEach items="${currentUser.roles}" var="role">
        <%--选取出最大的集合显示即可--%>
        <c:if test="${role.resources.size() == requestScope.count}">
            <c:forEach items="${role.resources}" var="menu">

                <%--管理资源需要显示--%>
                <c:if test="${menu.type == 1}">

                    <%--父节点为空, 为根节点; 有点击事件&ndash;%&gt;
                    父节点不为空, 为子结点; 有 name 属性, 用于展开菜单--%>
                    <c:if test="${menu.parent == null}">
                        <a href="${menu.href}"
                           class="list-group-item ${param.target == menu.href ? 'active' : ''}"
                           onclick="hideChild('${menu.id}', event, this)">
                            <span class="${menu.title}"></span>&nbsp;&nbsp;${menu.name}
                            <span class="glyphicon glyphicon-plus-sign pull-right"></span>
                        </a>

                        <%--获取所有子节点, 并显示--%>
                        <c:forEach items="${role.resources}" var="resource1">
                            <c:if test="${resource1.parent.id == menu.id}">
                                <a href="${resource1.href}"
                                   class="list-group-item ${param.target == resource1.href ? 'active' : ''}
                                  ${param.show == 'show' && param.name == resource1.parent.name ? '' : 'hide'} "
                                   name="${resource1.parent.id}">
                                    <div class="col-md-offset-1">
                                        <span class="${resource1.title}"></span>&nbsp;&nbsp;${resource1.name}
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>

                    </c:if>

                </c:if>

            </c:forEach>
        </c:if>

    </c:forEach>

</div>


</body>
</html>
<script>

    // 隐藏子结点
    function hideChild(parentId, event, obj) {

        // 如果当前菜单已经选中, 则阻止提交
        if ($(obj).hasClass("active")) {
            event.preventDefault();
        }
        $("a[name=" + parentId + "]").each(function () {
            $(this).toggleClass("hide");
            // 改变右侧图标
            var mark = $(this).hasClass("hide") ? "plus" : "minus";
            $(obj).find("span").eq(1).attr("class", "glyphicon glyphicon-" + mark + "-sign pull-right");
        });

    }
</script>
