function showAllRole(link, event) {
    event.preventDefault();
    $.ajax({
        url: "crm/" + link,
        type: "GET"
    }).done(function (result) {
        eval("var roleArr = " + result);

        // 先清空原有的内容
        $("#content").html("<table id='tab1'>" +
            "<tr>\n" +
            "<td colspan=\"8\" style=\"font-size: 25px; font-weight: bold\">角色表</td>\n" +
            "</tr>" +
            "<tr>\n" +
            "<th>常量</th>\n" +
            "<th>备注</th>\n" +
            "<th>是否禁用</th>\n" +
            "<th>主键</th>\n" +
            "<th>角色名</th>\n" +
            "</tr>" +
            "</table>");
        $.each(roleArr, function () {
            var tr = $("<tr>").appendTo("#tab1");
            $("<td>" + this.constant + "</td>").appendTo(tr);
            $("<td>" + this.description + "</td>").appendTo(tr);
            $("<td>" + (this.enabled == 1 ? '是' : '否') + "</td>").appendTo(tr);
            $("<td>" + this.id + "</td>").appendTo(tr);
            $("<td>" + this.name + "</td>").appendTo(tr);
        })

    });
}