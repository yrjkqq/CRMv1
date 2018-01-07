<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <a href="crm/main" class="list-group-item ${param.target == 'main' ? 'active' : ''}">
        <span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;首页
    </a>
    <c:forEach items="${cur}" var="menu">
        <%--管理资源需要显示--%>
        <c:if test="${menu.type == 1 && menu.parent == null}">
            <%--父节点为空, 为根节点; 有点击事件&ndash;%&gt;
            父节点不为空, 为子结点; 有 name 属性, 用于展开菜单--%>
            <a href="${menu.href}"
               class="list-group-item ${param.target == menu.href ? 'active' : ''}"
               onclick="hideChild('${menu.id}', event, this)">
                <span class="${menu.title}"></span>&nbsp;&nbsp;${menu.name}
                <span class="glyphicon glyphicon-plus-sign pull-right"></span>
            </a>

            <%--获取所有子节点, 并显示--%>
            <c:forEach items="${cur}" var="resource">
                <c:if test="${resource.parent.id == menu.id && resource.type == 1}">
                    <a href="${resource.href}"
                       class="list-group-item ${param.target == resource.href ? 'active' : ''}
                                  ${param.show == 'show' && param.name == resource.parent.name ? '' : 'hide'} "
                       name="${resource.parent.id}">
                        <div class="col-md-offset-1">
                            <span class="${resource.title}"></span>&nbsp;&nbsp;${resource.name}
                        </div>
                    </a>
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
