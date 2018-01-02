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
    <title>CRM</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
</head>
<body>

<div class="container-fluid">
    <!--顶部导航栏-->
    <div class="row">
        <jsp:include page="../commons/header.jsp"/>
    </div>

    <div class="row">
        <!--菜单-->
        <div class="col-md-2">
            <jsp:include page="../commons/menu.jsp">
                <jsp:param name="target" value="resource"/>
            </jsp:include>
        </div>
        <div class="col-md-10">
            <!--当前位置-->
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="crm/resource">首页</a></li>
                    <li><a href="crm/resource">系统设置</a></li>
                    <li class="active">资源管理</li>
                </ol>
            </div>
            <!--搜索-->
            <div class="row">
                <form action="#">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                            <div class="row">
                                <div class="col-md-4">搜索条件</div>
                                <div class="col-md-8 text-right">
                                    <button type="button" class="btn btn-primary btn-sm"
                                            onclick="modifyResource(document.getElementById('searchContent').value)"
                                            data-toggle="modal"
                                            data-target="#myModalToUpdate">
                                        <span class="glyphicon glyphicon-search"></span>&nbsp;搜索
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="removeContent()">
                                        <!-- 注册事件, 清除搜索框内容-->
                                        <span class="glyphicon glyphicon-remove"></span>&nbsp;清除条件
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="padding:0">
                            <input id="searchContent" type="text" class="form-control" style="border:none;"
                                   name="search"
                                   placeholder="请输入资源 ID ...">
                        </div>
                    </div>
                </form>

            </div>
            <!--资源列表-->
            <div class="row">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                        <div class="row">
                            <div class="col-md-4">资源列表</div>
                            <div class="col-md-8 text-right">
                                <a role="button" href="#" class="btn btn-primary btn-sm" data-toggle="modal"
                                   data-target="#myModalToAdd">
                                    <span class="glyphicon glyphicon-plus"></span>&nbsp;添加资源
                                </a>
                                <a role="button" href="#" class="btn btn-warning btn-sm">
                                    <span class="glyphicon glyphicon-trash"></span>&nbsp;删除选中
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Table -->
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>常量</th>
                            <th>是否可用</th>
                            <th>链接地址</th>
                            <th>主键</th>
                            <th>资源名称</th>
                            <th>父节点</th>
                            <th>是否显示</th>
                            <th>打开方式</th>
                            <th>显示信息</th>
                            <th>类型</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 列表循环 -->
                        <c:forEach items="${crmResourceList}" var="resource">
                            <tr>
                                <td>${resource.constant}</td>
                                <td>${resource.enabled == 1 ? '<span class="label label-primary">可用</span>' : '<span class="label label-danger">禁用</span>'}</td>
                                <td>${resource.href}</td>
                                <td>${resource.id}</td>
                                <td>${resource.name}</td>
                                <td>${resource.parent.id}</td>
                                <td>${resource.shown == 1 ? '<span class="label label-primary">显示</span>' : '<span class="label label-danger">不显示</span>'}</td>
                                <td>${resource.target}</td>
                                <td>${resource.title}</td>
                                <td>${resource.type == 2 ? '<span class="label label-primary">资源</span>' : '<span class="label label-danger">功能</span>'}</td>
                                <td>
                                    <a role="button" href="#"
                                       class="btn btn-warning btn-xs" data-toggle="modal"
                                       data-target="#myModalToUpdate" onclick="modifyResource(${resource.id})">
                                        <span class="glyphicon glyphicon-edit"></span>&nbsp;修改
                                    </a>
                                    <a role="button" href="crm/deleteResource/${resource.id}"
                                       class="btn btn-danger btn-xs">
                                        <span class="glyphicon glyphicon-trash"></span>&nbsp;删除
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <%--分页--%>
                    <div class="panel-footer">
                        <td colspan="9">
                            <jsp:include page="../commons/page.jsp">
                                <jsp:param name="url" value="crm/resource"/>
                            </jsp:include>
                        </td>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--动态模态框, 添加资源-->
<!-- Modal -->
<div class="modal fade" id="myModalToAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="crm/addResource" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">添加资源</h4>
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
                        <label class="control-label col-md-2">显示信息</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="title"/>
                        </div>
                    </div>

                    <%--主键由数据库生成--%>

                    <div class="form-group">
                        <label class="control-label col-md-2">类型</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="type" value="1">资源
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type" value="0">功能
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">是否可用</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="enabled" value="1">是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="enabled" value="0">否
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">是否显示</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="shown" value="1">是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="shown" value="0">否
                            </label>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--动态模态框, 修改资源-->
<!-- Modal -->
<div class="modal fade" id="myModalToUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="crm/modifyResource" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改资源</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">主键</label>
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
                        <label class="control-label col-md-2">显示信息</label>
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
                                <input type="radio" name="type" class="type" value="1">功能
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">是否显示</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="shown" class="shown" value="1">是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="shown" class="shown" value="0">否
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">是否可用</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="enabled" class="enabled" value="1">是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="enabled" class="enabled" value="0">否
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
<script src="assets/js/util.js"></script>
<script>
    function modifyResource(resourceId) {
        // 先发出 ajax 请求, 返回原对象, 然后弹出模块框并设置初始值
        $.ajax({
            url: "crm/modifyResource/" + resourceId,
            method: "get",
            dateType: "json"
        }).done(function (crmResource) {
            $("#id").val(crmResource.id);
            $("#constant").val(crmResource.constant);
            $("#href").val(crmResource.href);
            $("#name").val(crmResource.name);
            $("#parent").val(crmResource.parent.id);
            $("#target").val(crmResource.target);
            $("#title").val(crmResource.title);

            $(".enabled").each(function () {
                if ($(this).prop("value") == crmResource.enabled) {
                    $(this).prop("checked", true);
                }
            });

            $(".shown").each(function () {
                if ($(this).prop("value") == crmResource.shown) {
                    $(this).prop("checked", true);
                }
            });

            $(".type").each(function () {
                if ($(this).prop("value") == crmResource.type) {
                    $(this).prop("checked", true);
                }
            });
        });
    }
</script>

