<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <title>添加角色</title>
    <script src="assets/js/jquery-3.2.1.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.css">
</head>

<body>

<div class="container-fluid">
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

            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>添加角色</strong>
                    <button class="btn btn-warning btn-sm pull-right" style="margin-top: -5px" onclick="history.go(-1)">返回
                    </button>
                </div>

                <div class="panel-body">
                    <form action="crm/addRole" method="post" class="form-horizontal">

                        <div class="form-group">
                            <label class="control-label col-md-2">角色名</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="name"/>
                            </div>
                            <span class="help-block">6~18个字符，可使用字母、数字、下划线</span>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2">常量</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="constant"/>
                            </div>
                            <span class="help-block">唯一键</span>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2">备注</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="description"/>
                            </div>
                            <span class="help-block">补充信息</span>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2">是否可用</label>
                            <div class="col-md-4">
                                <label class="radio-inline">
                                    <input type="radio" name="enabled" value="1">是
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="enabled" value="0">否
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-4 col-md-offset-2">
                                <button type="reset" class="btn btn-default">重置</button>
                                <button type="submit" class="btn btn-primary">添加</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<script src="assets/js/util.js"></script>
