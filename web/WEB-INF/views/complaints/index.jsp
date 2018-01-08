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
                                <button type="button" class="btn btn-primary" onclick="queryAllUnassigned('未指派')">
                                    未指派投诉
                                </button>
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
                        <br>
                        <%--未指派投诉面板--%>
                        <div class="panel panel-default" id="unassignedPanel" style="display:none">
                            <div class="panel-heading">
                                <h3 class="panel-title">未指派投诉</h3>
                            </div>
                            <table class="table table-hover" id="unassignedTab">
                                <tr>
                                    <th>投诉编号</th>
                                    <th>投诉客户</th>
                                    <th>联系人</th>
                                    <th>投诉问题</th>
                                    <th>客服人员</th>
                                    <th>操作</th>
                                </tr>
                            </table>
                            <div class="panel-footer">
                                <button class="btn btn-warning btn-sm" onclick="closeUnassignedPanel()">关闭</button>
                            </div>
                        </div>
                        <%--指派售后面板--%>
                        <div class="panel panel-default" id="appointAfterSalesPanel" style="display:none">
                            <div class="panel-heading">
                                <h3 class="panel-title">指派售后处理</h3>
                            </div>
                            <div class="panel-body">
                                <div class="input-group">
                                    <span class="input-group-addon">投诉编号</span>
                                    <input type="text" class="form-control" readonly id="complaintId">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">经理编号</span>
                                    <input type="text" class="form-control" readonly
                                           value="${currentUser.id}" id="managerId">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">经理姓名</span>
                                    <input type="text" name="client" class="form-control" readonly
                                           value="${currentUser.username}">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">指派售后</span>
                                    <select class="form-control" id="allAfterSalesId">
                                    </select>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <button class="btn btn-warning btn-sm" onclick="cancelAppoint()">取消</button>
                                <button class="btn btn-warning btn-sm" onclick="appointAfterSales()">指派</button>
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
                                        <input type="text" name="contact" class="form-control">
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
                                        <%--隐藏域提交投诉状态为: 未处理--%>
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

                        <%--todo 修改投诉: 1. 显示出当前客服所提交的所有投诉; 2. 添加操作后即可修改投诉; 3. 投诉状态不能修改--%>


                    </c:when>
                    <c:when test="${userRole.constant == 'SERVICE_AFTER_SALES'}">
                        <%--售后人员--%>
                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-warning"
                                        onclick="queryAllUnhandled('未处理', ${currentUser.id})">待售后处理
                                </button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-success">已处理投诉</button>
                            </div>
                        </div>
                        <br>
                        <%--未处理投诉面板--%>
                        <div class="panel panel-default" id="unhandledPanel" style="display:none">
                            <div class="panel-heading">
                                <h3 class="panel-title">未处理投诉</h3>
                            </div>
                            <table class="table table-hover" id="unhandledTab">
                                <tr>
                                    <th>投诉编号</th>
                                    <th>投诉客户</th>
                                    <th>联系人</th>
                                    <th>联系电话</th>
                                    <th>投诉问题</th>
                                    <th>客服人员</th>
                                    <th>操作</th>
                                </tr>
                            </table>
                            <div class="panel-footer">
                                <button class="btn btn-warning btn-sm" onclick="closeUnhandledPanel()">关闭</button>
                            </div>
                        </div>
                        <%--处理投诉面板--%>
                        <div class="panel panel-default" id="handleComplaintPanel" style="display:none">
                            <div class="panel-heading">
                                <h3 class="panel-title">处理投诉</h3>
                            </div>
                            <div class="panel-body">
                                <div class="input-group">
                                    <span class="input-group-addon">投诉编号</span>
                                    <input type="text" class="form-control" readonly id="complaintId1">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">售后编号</span>
                                    <input type="text" class="form-control" readonly
                                           value="${currentUser.id}">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">售后姓名</span>
                                    <input type="text" class="form-control" readonly
                                           value="${currentUser.username}">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">解决办法</span>
                                    <input type="text" class="form-control" id="handleMethod">
                                </div>
                            </div>
                            <div class="panel-footer">
                                <button class="btn btn-warning btn-sm" onclick="cancelHandle()">取消</button>
                                <button class="btn btn-warning btn-sm" onclick="handleComplaint()">处理</button>
                            </div>
                        </div>

                    </c:when>
                    <c:when test="${userRole.constant == 'SERVICE_HANDLE_MAN'}">
                        <%--处理人员--%>

                    </c:when>
                </c:choose>
            </c:forEach>

        </div>
    </div>
</div>

</body>
</html>
<script>
    // 客服人员
    // 添加投诉
    function showAddComplaint() {
        $("#addComplaint").toggleClass("hide");
    }

    $('#datepicker').datepicker({
        format: 'yyyy/mm/dd',
        endDate: '0d'
    });

    // 主管
    // 未指派投诉面板: 显示面板
    var $unassignedPanel = $("#unassignedPanel");

    // 查看未指派投诉
    function queryAllUnassigned(status) {
        // 显示面板
        $unassignedPanel.css("display", "block");

        // 先清空原先数据
        var $unassignedTab = $("#unassignedTab");
        $unassignedTab.find("tr:gt(0)").each(function () {
            $(this).remove();
        });

        $.ajax({
            url: "complaints/queryAll",
            data: {
                "status": status
            },
            type: "GET",
            dataType: "json"
        }).done(function (result) {

            for (var i in result) {
                var $tr = $("<tr>").appendTo($unassignedTab);
                $("<td>" + result[i].id + "</td>" +
                    "<td>" + result[i].client + "</td>" +
                    "<td>" + result[i].contact + "</td>" +
                    "<td>" + result[i].problem + "</td>" +
                    "<td>" + result[i].serviceMan.username + "</td>" +
                    "<td><button onclick='showAppointPanel(" + result[i].id + ")' class='btn btn-primary btn-xs'>指派售后</button></td>")
                    .appendTo($tr);
            }
        });
    }

    // 关闭未指派投诉面板
    function closeUnassignedPanel() {
        $unassignedPanel.css("display", "none");
    }

    // 指派售后面板
    var $appointAfterSalesPanel = $("#appointAfterSalesPanel");

    // 显示并初始化售后处理面板
    function showAppointPanel(complaintId) {
        $unassignedPanel.css("display", "none");
        // 显示售后面板
        $appointAfterSalesPanel.css("display", "block");
        // 投诉编号
        $("#complaintId").val(complaintId);

        // 查询所有售后人员; 返回 json
        $.ajax({
            url: "complaints/queryAfterSales",
            data: {
                "managerId": $("#managerId").val()
            },
            type: "GET",
            dataType: "json"
        }).done(function (result) {
            var $allAfterSales = $("#allAfterSalesId");
            // 先清空原数据
            $allAfterSales.find("option").each(function () {
                $(this).remove();
            });
            for (var i in result) {
                // 所有售后添加到下拉列表中
                $("<option value=" + result[i].id + ">" + result[i].username + "</option>").appendTo($allAfterSales);
            }
        });
    }

    // 指派售后处理
    function appointAfterSales() {
        var complaintId = $("#complaintId").val();
        var afterSalesId = $("#allAfterSalesId").val();
        // 发出指派售后请求
        $.ajax({
            url: "complaints/appointAfterSales",
            data: {
                "complaintId": complaintId,
                "afterSalesId": afterSalesId
            },
            type: "GET"
        }).done(function (result) {
            console.log(result);
            // 关闭指派售后面板
            $appointAfterSalesPanel.css("display", "none");
        })
    }

    // 取消指派售后
    function cancelAppoint() {
        $appointAfterSalesPanel.css("display", "none");
    }

    // 售后人员
    // 未处理投诉面板
    var $unhandledPanel = $("#unhandledPanel");
    // 未处理投诉表格
    var $unhandledTab = $("#unhandledTab");

    // 查看未处理投诉
    function queryAllUnhandled(status, currentUserId) {
        $unhandledPanel.css("display", "block");
        $unhandledTab.find("tr:gt(0)").each(function () {
            $(this).remove();
        });
        $.ajax({
            url: "complaints/queryAll",
            data: {
                "status": status
            },
            type: "GET",
            dataType: "json"
        }).done(function (result) {
            for (var i in result) {
                // 只显示分配给当前售后的投诉
                if (result[i].serviceAfterSales.id === currentUserId) {
                    var $tr = $("<tr>").appendTo($unhandledTab);
                    $("<td>" + result[i].id + "</td>" +
                        "<td>" + result[i].client + "</td>" +
                        "<td>" + result[i].contact + "</td>" +
                        "<td>" + result[i].contactPhone + "</td>" +
                        "<td>" + result[i].problem + "</td>" +
                        "<td>" + result[i].serviceMan.username + "</td>" +
                        "<td><button onclick='showHandleComplaint(" + result[i].id + ")' class='btn btn-primary btn-xs'>待处理</button></td>")
                        .appendTo($tr);
                }
            }
        });
    }

    // 关闭未处理投诉面板
    function closeUnhandledPanel() {
        $unhandledPanel.css("display", "none");
    }

    // 处理投诉面板
    var $handleComplaintPanel = $("#handleComplaintPanel");

    // 显示售后处理投诉面板并初始化
    function showHandleComplaint(complaintId) {
        closeUnhandledPanel();
        // 显示售后处理投诉面板
        $handleComplaintPanel.css("display", "block");
        $("#complaintId1").val(complaintId);
    }

    // 取消售后处理
    function cancelHandle() {
        // 隐藏处理面板
        $handleComplaintPanel.css("display", "none");
    }

    // 售后进行处理
    function handleComplaint() {
        // 发出处理售后请求
        $.ajax({
            url: "complaints/handleComplaint",
            data: {
                "complaintId": $("#complaintId1").val(), // 投诉编号
                "handleMethod": $("#handleMethod").val() // 处理方式
            },
            type: "GET"
        }).done(function (result) {
            console.log(result);
            // 关闭售后处理面板
            cancelHandle();
        });
    }

</script>


