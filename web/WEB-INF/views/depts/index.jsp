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
    <title>部门管理</title>
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
                <jsp:param name="target" value="depts/index"/>
                <jsp:param name="name" value="部门管理"/>
                <jsp:param name="show" value="show"/>
            </jsp:include>
        </div>
        <div class="col-md-10">
            <!--当前位置-->
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="crm/main">首页</a></li>
                    <li class="active"><a href="depts/index">部门管理</a></li>
                </ol>
            </div>

            <!--部门列表-->
            <div class="row">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                        <div class="row">
                            <div class="col-md-4">部门列表</div>
                            <div class="col-md-8">
                                <c:if test="${currentUserResources.contains('SYS_DEPT_SAVE')}">
                                    <a role="button" class="btn btn-primary btn-sm pull-right" data-toggle="modal"
                                       data-target="#myModalToAdd">
                                        <span class="glyphicon glyphicon-plus"></span>&nbsp;添加部门
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!-- Table -->
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>部门编号</th>
                            <th>部门名称</th>
                            <th>部门描述</th>
                            <th>所属公司</th>
                            <c:if test="${currentUserResources.contains('SYS_DEPT_UPDATE') && currentUserResources.contains('SYS_DEPT_DELETE')}">
                                <th>操作</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 列表循环 -->
                        <c:forEach items="${depts}" var="dept">

                            <tr>
                                <td>${dept.id}</td>
                                <td><a href="users/index?deptId=${dept.id}">${dept.name}</a></td>
                                <td>${dept.description}</td>
                                <td>${dept.company}</td>

                                <c:if test="${currentUserResources.contains('SYS_DEPT_UPDATE') && currentUserResources.contains('SYS_DEPT_DELETE')}">
                                    <td>
                                        <c:if test="${currentUserResources.contains('SYS_DEPT_UPDATE')}">
                                            <a role="button"
                                               class="btn btn-warning btn-xs" data-toggle="modal"
                                               data-target="#myModalToUpdate" onclick="modifyDept(${dept.id})">
                                                <span class="glyphicon glyphicon-edit"></span>&nbsp;修改
                                            </a>
                                        </c:if>
                                        <c:if test="${currentUserResources.contains('SYS_DEPT_DELETE')}">
                                            <a role="button"
                                               class="btn btn-warning btn-xs" data-toggle="modal"
                                               data-target="#myModalToDelete"
                                               onclick="confirmDelete(${dept.id}, '${dept.name}')">
                                                <span class="glyphicon glyphicon-edit"></span>&nbsp;删除
                                            </a>
                                        </c:if>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <%--分页--%>
                    <div class="panel-footer">
                        <td colspan="9">
                            <jsp:include page="../commons/page.jsp">
                                <jsp:param name="url" value="depts/index"/>
                            </jsp:include>
                        </td>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--动态模态框, 添加部门-->
<!-- Modal -->
<div class="modal fade" id="myModalToAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="depts/addDept" method="post" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel1">添加部门</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">公司名称</label>
                        <div class="col-md-10">
                            <%-- 公司名称不能修改; 使用隐藏域进行提交--%>
                            <input type="hidden" name="company" value="康帅博"/>
                            <label class="control-label">康帅博</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">部门名称</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="name" placeholder="Department name"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">部门描述</label>
                        <div class="col-md-10">
                            <textarea class="form-control" rows="3" name="description"></textarea>
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

<!--动态模态框, 修改部门-->
<!-- Modal -->
<div class="modal fade" id="myModalToUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="depts/modifyDept" method="post" class="form-horizontal">
                <input type="hidden" name="company" value="康帅博"/>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">修改部门</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label col-md-2">部门编号</label>
                        <div class="col-md-10">
                            <input type="text" id="id" class="form-control" readonly name="id"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">部门名称</label>
                        <div class="col-md-10">
                            <input type="text" id="name" class="form-control" name="name"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2">部门描述</label>
                        <div class="col-md-10">
                            <textarea class="form-control" id="description" rows="3" name="description"></textarea>
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

<%--删除部门--%>
<div class="modal fade" id="myModalToDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form action="depts/deleteDept" method="get" class="form-horizontal">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel3">删除部门</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group text-center">
                        <h3>确认删除<span id="deptName" style="color: red">&nbsp;</span>吗?</h3>
                    </div>
                    <input type="hidden" value="" id="deleteDeptId" name="deleteDeptId"/>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">确认</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
<script>
    function modifyDept(deptId) {
        // 先发出 ajax 请求, 返回原对象, 然后弹出模块框并设置初始值
        $.ajax({
            url: "depts/modifyDept/" + deptId,
            method: "get",
            dateType: "json"
        }).done(function (dept) {
            $("#id").val(dept.id);
            $("#description").val(dept.description);
            $("#name").val(dept.name);
        });
    }

    // 为删除操作模态框设置值
    function confirmDelete(deptId, deptName) {
        $("#deleteDeptId").val(deptId);
        $("#deptName").html(deptName);
    }
</script>

