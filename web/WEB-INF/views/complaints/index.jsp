<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <title>投诉受理</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <script src="assets/js/bootstrap-datepicker.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/css/bootstrap-datepicker.css">
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
                <jsp:param name="target" value="complaints/index"/>
                <jsp:param name="name" value="投诉受理"/>
                <jsp:param name="show" value="show"/>
            </jsp:include>
        </div>
        <div class="col-md-10">
            <!--当前位置-->
            <div class="row">
                <ol class="breadcrumb">
                    <li><a href="crm/main">首页</a></li>
                    <li class="active"><a href="complaints/index">投诉受理</a></li>
                </ol>
            </div>

            <!--投诉列表: 此部分根据角色常量进行不同的显示-->
            <c:forEach items="${currentUser.roles}" var="userRole">
                <c:choose>
                    <c:when test="${userRole.constant == 'SERVICE_MANAGER'}">
                        <%--客服经理--%>
                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-primary">未处理投诉</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-info">处理中投诉</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-warning">待回访投诉</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-success">已完成投诉</button>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${userRole.constant == 'SERVICE_MAN'}">
                        <%--客服人员--%>
                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-primary" onclick="showAddComplaint(this)">
                                    添加投诉
                                </button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-warning">修改投诉</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-danger">删除投诉</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-success">客户回访</button>
                            </div>
                        </div>
                        <br>
                        <%--隐藏区域, 点击添加投诉后显示--%>
                        <form action="complaints/add" method="post" class="" id="addComplaint">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">添加投诉</h3>
                                </div>
                                <div class="panel-body">

                                    <div class="input-group">
                                        <span class="input-group-addon">客服编号</span>
                                        <input type="text" name="serviceMan.id" class="form-control" readonly
                                               value="${currentUser.id}">
                                    </div>
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">客服姓名</span>
                                        <input type="text" class="form-control" readonly
                                               value="${currentUser.username}">
                                    </div>
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">投诉客户</span>
                                        <input type="text" name="client" class="form-control">
                                    </div>
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">联系人</span>
                                        <input type="text" name="contact" class="form-control" ">
                                    </div>
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">联系电话</span>
                                        <input type="text" name="contactPhone" class="form-control">
                                    </div>
                                    <br>
                                    <div class="input-group">
                                        <span class="input-group-addon">投诉问题</span>
                                        <input type="text" name="problem" class="form-control">
                                    </div>
                                    <br>
                                    <div class="input-group date" id="datepicker">
                                        <span class="input-group-addon">投诉日期</span>
                                        <input type="text" name="complaintDate" class="form-control">
                                    </div>
                                    <%--隐藏域提交投诉状态为: 未指派--%>
                                    <input type="hidden" name="status" value="未指派"/>

                                </div>
                                <div class="panel-footer" style="padding:5px">
                                    <div class="row">
                                        <div class="col-md-11">
                                            <button class="btn btn-primary btn-sm pull-right"
                                                    type="submit">提交
                                            </button>
                                        </div>
                                        <div class="col-md-1">
                                            <button type="reset" class="btn btn-warning btn-sm"
                                                    onclick="showAddComplaint(this)">取消
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <%--修改投诉: 1. 显示出当前客服所提交的所有投诉; 2. 添加操作后即可修改投诉; 3. 投诉状态不能修改--%>


                    </c:when>
                    <c:when test="${userRole.constant == 'SERVICE_AFTER_SALES'}">
                        <%--售后人员--%>
                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-warning">待售后处理</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-success">已处理投诉</button>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${userRole.constant == 'SERVICE_HANDLE_MAN'}">
                        <%--处理人员--%>

                    </c:when>
                </c:choose>
            </c:forEach>
            <%--<div class="row">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading" style="padding-bottom: 5px; padding-top: 5px">
                        <div class="row">
                            <div class="col-md-4">部门列表</div>
                            <div class="col-md-8">
                                <c:if test="${currentUserResources.contains('SYS_COMPLAINT_SAVE')}">
                                    <a role="button" class="btn btn-primary btn-sm pull-right" data-toggle="modal"
                                       data-target="#myModalToAdd">
                                        <span class="glyphicon glyphicon-plus"></span>&nbsp;添加投诉
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
                            <c:if test="${currentUserResources.contains('SYS_COMPLAINT_UPDATE') && currentUserResources.contains('SYS_COMPLAINT_DELETE')}">
                                <th>操作</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 列表循环 -->
                        &lt;%&ndash;<c:forEach items="${depts}" var="dept">
                            <tr>
                                <td>${dept.id}</td>
                                <td><a href="users/index?deptId=${dept.id}">${dept.name}</a></td>
                                <td>${dept.description}</td>
                                <td>${dept.company}</td>

                                <c:if test="${currentUserResources.contains('SYS_COMPLAINT_UPDATE') && currentUserResources.contains('SYS_COMPLAINT_DELETE')}">
                                    <td>
                                        <c:if test="${currentUserResources.contains('SYS_COMPLAINT_UPDATE')}">
                                            <a role="button"
                                               class="btn btn-warning btn-xs" data-toggle="modal"
                                               data-target="#myModalToUpdate" onclick="modifyDept(${dept.id})">
                                                <span class="glyphicon glyphicon-edit"></span>&nbsp;修改
                                            </a>
                                        </c:if>
                                        <c:if test="${currentUserResources.contains('SYS_COMPLAINT_DELETE')}">
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
                        </c:forEach>&ndash;%&gt;
                        </tbody>
                    </table>
                    &lt;%&ndash;分页&ndash;%&gt;
                    <div class="panel-footer">
                        <td colspan="9">
                            <jsp:include page="../commons/page.jsp">
                                <jsp:param name="url" value="complaints/index"/>
                            </jsp:include>
                        </td>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>
</div>

</body>
</html>
<script>
    <%--客服人员--%>
    // 添加投诉
    function showAddComplaint() {
        $("#addComplaint").toggleClass("hide");
    }

    $('#datepicker').datepicker({
        format: 'yyyy/mm/dd',
        endDate: '0d'
    });
</script>


