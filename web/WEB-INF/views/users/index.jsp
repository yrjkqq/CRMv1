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
            <!--当前位置-->
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="users/index">首页</a></li>
                    <li><a href="users/index">系统设置</a></li>
                    <li class="active">用户管理</li>
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
                                            onclick="modifyUser(document.getElementById('searchContent').value)"
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
                                   placeholder="请输入用户 ID ...">
                        </div>
                    </div>
                </form>

            </div>
            <!--角色列表-->
            <div class="row">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                        <div class="row">
                            <div class="col-md-4">用户列表</div>
                            <div class="col-md-8 text-right">
                                <a role="button" href="#" class="btn btn-primary btn-sm" data-toggle="modal"
                                   data-target="#myModalToAdd">
                                    <span class="glyphicon glyphicon-plus"></span>&nbsp;添加用户
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
                            <th>备注</th>
                            <th>邮箱</th>
                            <th>是否可用</th>
                            <th>主键</th>
                            <th>是否锁定</th>
                            <th>密码</th>
                            <th>性别</th>
                            <th>用户名</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 列表循环 -->
                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td>${user.description}</td>
                                <td>${user.email}</td>
                                <td>${user.enabled == 1 ? '<span class="label label-primary">可用</span>' : '<span class="label label-danger">禁用</span>'}</td>
                                <td>${user.id}</td>
                                <td>${user.locked == 1 ? '<span class="label label-primary">锁定</span>' : '<span class="label label-danger">未锁定</span>'}</td>
                                <td>${user.password}</td>
                                <td>${user.sex == 1 ? '男' : '女'}</td>
                                <td>${user.username}</td>
                                <td>
                                    <a role="button"
                                       class="btn btn-warning btn-xs" data-toggle="modal"
                                       data-target="#myModalToUpdate" onclick="modifyUser(${user.id})">
                                        <span class="glyphicon glyphicon-edit"></span>&nbsp;修改
                                    </a>
                                    <a role="button" href="users/deleteUser/${user.id}" class="btn btn-danger btn-xs">
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
                                <jsp:param name="url" value="users/index"/>
                            </jsp:include>
                        </td>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--动态模态框, 添加用户-->
<!-- Modal -->
<div class="modal fade" id="myModalToAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="users/addUser" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">添加用户</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">用户名</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="username"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">密码</label>
                        <div class="col-md-10">
                            <input type="password" class="form-control" name="password"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">备注</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="description"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">邮箱</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="email"/>
                        </div>
                    </div>

                    <%--主键由数据库生成--%>

                    <div class="form-group">
                        <label class="control-label col-md-2">性别</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="1">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="0">女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">是否锁定</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="locked" value="1">是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="locked" value="0">否
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--动态模态框, 修改用户-->
<!-- Modal -->
<div class="modal fade" id="myModalToUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="users/modifyUser" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改用户</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">主键</label>
                        <div class="col-md-10">
                            <input type="text" id="id" class="form-control" readonly name="id"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">用户名</label>
                        <div class="col-md-10">
                            <input type="text" id="username" class="form-control" name="username"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">密码</label>
                        <div class="col-md-10">
                            <input type="password" id="password" class="form-control" name="password"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">备注</label>
                        <div class="col-md-10">
                            <input type="text" id="description" class="form-control" name="description"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">邮箱</label>
                        <div class="col-md-10">
                            <input type="text" id="email" class="form-control" name="email"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">性别</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" class="sex" value="1">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" class="sex" value="0">女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">是否锁定</label>
                        <div class="col-md-10">
                            <label class="radio-inline">
                                <input type="radio" name="locked" class="locked" value="1">是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="locked" class="locked" value="0">否
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
    function modifyUser(userId) {
        // 先发出 ajax 请求, 返回原对象, 然后弹出模块框并设置初始值
        $.ajax({
            url: "users/modifyUser/" + userId,
            method: "get",
            dateType: "json"
        }).done(function (user) {
            $("#id").val(user.id);
            $("#description").val(user.description);
            $("#email").val(user.email);
            $("#username").val(user.username);
            $("#password").attr("value", user.password);

            $(".enabled").each(function () {
                if ($(this).prop("value") == user.enabled) {
                    $(this).prop("checked", true);
                }
            });

            $(".locked").each(function () {
                if ($(this).prop("value") == user.locked) {
                    $(this).prop("checked", true);
                }
            });

            $(".sex").each(function () {
                if ($(this).prop("value") == user.sex) {
                    $(this).prop("checked", true);
                }
            });
        });
    }
</script>

