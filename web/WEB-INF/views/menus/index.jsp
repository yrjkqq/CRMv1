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
    <title>菜单管理</title>
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
            <%--部门跳转后需要显示子菜单--%>
            <jsp:include page="../commons/menu.jsp">
                <jsp:param name="target" value="menus/index"/>
                <jsp:param name="name" value="菜单管理"/>
                <jsp:param name="show" value="show"/>
            </jsp:include>
        </div>
        <div class="col-md-10">
            <!--当前位置-->
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="crm/main">首页</a></li>
                    <li class="active"><a href="menus/index">菜单管理</a></li>
                </ol>
            </div>

            <!--菜单列表-->
            <div class="row">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                        <div class="row">
                            <div class="col-md-4">菜单列表</div>
                            <div class="col-md-8">
                                <c:if test="${currentUserResources.contains('SYS_RESOURCE_SAVE')}">
                                    <a role="button" class="btn btn-primary btn-sm pull-right" data-toggle="modal"
                                       data-target="#myModalToAdd">
                                        <span class="glyphicon glyphicon-plus"></span>&nbsp;添加菜单
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!-- Table -->
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>菜单名称</th>
                            <th>常量</th>
                            <th>链接地址</th>
                            <th>父节点</th>
                            <th>打开方式</th>
                            <th>显示图标</th>
                            <c:if test="${currentUserResources.contains('SYS_ROLE_ALLOC_RESOURCE')
                            && currentUserResources.contains('SYS_RESOURCE_UPDATE')
                            && currentUserResources.contains('SYS_RESOURCE_DELETE')}">
                                <th>操作</th>
                            </c:if>
                        </tr>
                        </thead>

                        <c:forEach items="${menuList}" var="menu">
                            <tr>
                                <td>${menu.id}</td>
                                <td>${menu.name}</td>
                                <td>${menu.constant}</td>
                                <td>${menu.href}</td>
                                <td>${menu.parent.id}</td>
                                <td>${menu.target}</td>
                                <td><span class="${menu.title}"></span></td>

                                <c:if test="${currentUserResources.contains('SYS_ROLE_ALLOC_RESOURCE')
                            && currentUserResources.contains('SYS_RESOURCE_UPDATE')
                            && currentUserResources.contains('SYS_RESOURCE_DELETE')}">
                                    <td>
                                        <c:if test="${currentUserResources.contains('SYS_ROLE_ALLOC_RESOURCE')}">
                                            <a role="button" href="#" class="btn btn-warning btn-xs">
                                                <span class="glyphicon glyphicon-edit"></span>&nbsp;权限匹配
                                            </a>
                                        </c:if>
                                        <c:if test="${currentUserResources.contains('SYS_RESOURCE_UPDATE')}">
                                            <a role="button" href="#"
                                               class="btn btn-warning btn-xs" data-toggle="modal"
                                               data-target="#myModalToUpdate" onclick="modifyResource(${menu.id})">
                                                <span class="glyphicon glyphicon-edit"></span>&nbsp;修改
                                            </a>
                                        </c:if>
                                        <c:if test="${currentUserResources.contains('SYS_RESOURCE_DELETE')}">
                                            <a role="button" href="resources/deleteResource/${menu.id}"
                                               class="btn btn-danger btn-xs">
                                                <span class="glyphicon glyphicon-trash"></span>&nbsp;删除
                                            </a>
                                        </c:if>
                                    </td>
                                </c:if>

                            </tr>
                        </c:forEach>

                    </table>
                    <%--分页--%>
                    <div class="panel-footer">
                        <td colspan="9">
                            <jsp:include page="../commons/page.jsp">
                                <jsp:param name="url" value="menus/index"/>
                            </jsp:include>
                        </td>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--动态模态框, 添加菜单, 等同于添加资源-->
<!-- Modal -->
<div class="modal fade" id="myModalToAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="resources/addResource" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">添加菜单</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">常量</label>
                        <div class="col-md-10">
                            <%--todo 唯一性约束--%>
                            <input type="text" class="form-control" name="constant"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">链接地址</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="href"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">资源名称</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="name"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">父节点</label>
                        <div class="col-md-10">
                            <%--name 属性为 int 必须有值; 先改为 Integer 包装类--%>
                            <%--todo 验证--%>
                            <input type="text" class="form-control" name="parent.id"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">打开方式</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="target"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">显示图标</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="title"/>
                        </div>
                    </div>

                    <%--主键由数据库生成--%>
                    <input type="hidden" name="type" value="1">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--动态模态框, 修改菜单-->
<!-- Modal -->
<div class="modal fade" id="myModalToUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="resources/modifyResource" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改菜单</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">编号</label>
                        <div class="col-md-10">
                            <input type="text" id="id" class="form-control" readonly name="id"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">常量</label>
                        <div class="col-md-10">
                            <input type="text" id="constant" class="form-control" name="constant"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">链接地址</label>
                        <div class="col-md-10">
                            <input type="text" id="href" class="form-control" name="href"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">资源名称</label>
                        <div class="col-md-10">
                            <input type="text" id="name" class="form-control" name="name"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">父节点</label>
                        <div class="col-md-10">
                            <input type="text" id="parent" class="form-control" name="parent.id"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">打开方式</label>
                        <div class="col-md-10">
                            <input type="text" id="target" class="form-control" name="target"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-2">显示图标</label>
                        <div class="col-md-10">
                            <input type="text" id="title" class="form-control" name="title"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">类型</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="type" class="type" value="2">资源
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type" class="type" value="1">菜单
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">修改</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>

<script>
    function modifyResource(resourceId) {
        // 先发出 ajax 请求, 返回原对象, 然后弹出模块框并设置初始值
        $.ajax({
            url: "resources/modifyResource/" + resourceId,
            method: "get",
            dateType: "json"
        }).done(function (resource) {
            $("#id").val(resource.id);
            $("#constant").val(resource.constant);
            $("#href").val(resource.href);
            $("#name").val(resource.name);
            $("#parent").val(resource.parent == null ? null : resource.parent.id);
            $("#target").val(resource.target);
            $("#title").val(resource.title);

            $(".type").each(function () {
                if ($(this).prop("value") == resource.type) {
                    $(this).prop("checked", true);
                }
            });
        });
    }
</script>