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
    <title>角色管理</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <%--ztree 文件--%>
    <link rel="stylesheet" href="assets/css/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="assets/js/jquery.ztree.all.js"></script>
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
                <jsp:param name="target" value="role"/>
            </jsp:include>
        </div>
        <div class="col-md-10">
            <!--当前位置-->
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="crm/main">首页</a></li>
                    <li><a href="depts/index">部门管理</a></li>
                    <li class="active">角色管理</li>
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
                                    <%-- todo 搜索结果应该在首页的列表中显示--%>
                                    <button type="submit" class="btn btn-primary btn-sm">
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
                                   placeholder="请输入角色 ID ...">
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
                            <div class="col-md-4">角色列表</div>
                            <div class="col-md-8 text-right">
                                <a role="button" href="roles/addRole" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-plus"></span>&nbsp;添加角色
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Table -->
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>常量</th>
                            <th>备注</th>
                            <th>是否可用</th>
                            <th>主键</th>
                            <th>角色名</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 列表循环 -->
                        <c:forEach items="${roleList}" var="role">
                            <tr>
                                <td>${role.constant}</td>
                                <td>${role.description}</td>
                                <td>${role.enabled == 1 ? '<span class="label label-primary">可用</span>' : '<span class="label label-danger">禁用</span>'}</td>
                                <td>${role.id}</td>
                                <td>${role.name}</td>

                                <td>
                                    <a role="button"
                                       class="btn btn-warning btn-xs" data-toggle="modal"
                                       data-target="#myModalToUpdate" onclick="allocateResource(${role.id})">
                                        <span class="glyphicon glyphicon-edit"></span>&nbsp;分配资源
                                    </a>
                                    <a role="button" href="roles/modifyRole/${role.id}"
                                       class="btn btn-warning btn-xs">
                                        <span class="glyphicon glyphicon-edit"></span>&nbsp;修改
                                    </a>
                                    <a role="button" href="roles/deleteRole/${role.id}" class="btn btn-danger btn-xs">
                                        <span class="glyphicon glyphicon-trash"></span>&nbsp;删除
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                    <%--分页--%>
                    <div class="panel-footer">
                        <td colspan="6">
                            <jsp:include page="../commons/page.jsp">
                                <jsp:param name="url" value="roles/index"/>
                            </jsp:include>
                        </td>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--动态模态框, 分配资源-->
<!-- Modal -->
<div class="modal fade" id="myModalToUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form class="form form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">分配资源</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">角色名</label>
                        <div class="col-md-10">
                            <label id="roleId" class="control-label"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">资源列表</label>
                        <div class="col-md-10">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <a role="button" class="btn btn-primary" data-dismiss="modal" onclick="updateResource()">修改</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
<script src="assets/js/util.js"></script>
<script>

    // ztree
    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        // 支持 json 格式的数据
        data: {
            simpleData: {
                enable: true
            }
        },
        // 设置复选框
        check: {
            enable: true
        }
    };

    // 发出请求获取资源集合和当前对象
    function allocateResource(roleId) {
        // 先发出 ajax 请求, 返回原对象, 然后弹出模块框并设置初始值
        $.ajax({
            url: "roles/allocateResource/" + roleId,
            method: "get",
            dateType: "json"
        }).done(function (result) {
            // 当前角色对象
            var role = result.role;
            // 设置角色名
            $("#roleId").html(role.name);
            // 并存储 id 到当前元素, 以便提交更新时获取到
            $("#roleId").data("roleId", role.id);

            // 当前角色对象已有的资源
            var resources = role.resources;
            // 取出已有资源的 id, 组成数组; 然后与所有资源 id 进行匹配, 相等选中
            var hadResources = [];
            for (var i in resources) {
                hadResources.push(resources[i].id);
            }

            // 所有资源列表
            var allResources = result.allResources;

            // 清空原来的 ztree
            // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
            var zNodes = [];

            // 构建 json 对象, 并存入到 zNodes 数组中
            for (var i = 0; i < allResources.length; i++) {
                // console.log(allResources[i].parent.id);
                var id = allResources[i].id;
                var pid;
                if (!allResources[i].parent) {
                    // 父节点为空, 当前结点为根节点
                    pid = 0;
                } else {
                    pid = allResources[i].parent.id;
                }
                // 是否已有当前资源
                var isHave = contains(hadResources, id);
                // checked = true 则为选中状态
                var node = {id: id, pId: pid, name: allResources[i].name, checked: isHave};
                // 添加到结点数组中
                zNodes.push(node);
            }

            // 改变树节点数据
            // ajax 请求完成后初始化 ztree
            zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
    }

    // 判断数组中是否存在指定对象
    function contains(arr, obj) {
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] === obj) {
                return true;
            }
        }
    }

    // 更新资源
    function updateResource() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        // 获取所有节点组成的 json 对象
        var nodes = treeObj.transformToArray(treeObj.getNodes());
        // 遍历 json 对象
        // 格式为: {id: 12, pId: 9, name: "删除角色", checked: false, level: 2, …}
        var result = "";
        for (var i in nodes) {
            // 如果选中则添加到选中资源的字符串中
            if (nodes[i].checked) {
                result += nodes[i].id + ",";
            }
        }
        // 发出 ajax 请求, 到服务器修改资源
        $.ajax({
            url: "roles/allocateResource",
            method: "post",
            data: {
                "selectedResources": result.substr(0, result.length - 1),
                "roleId": $("#roleId").data("roleId") // 获取元素中存储的数据
            }
        });
    }


</script>

