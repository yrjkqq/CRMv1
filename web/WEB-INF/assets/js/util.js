function expandSystemMenu() {
    var $systemMenu = $("#systemMenu");
    var $rightMark = $("#rightMark");
    if ($systemMenu.css("display") === "none") {
        $systemMenu.css("display", "block");
        // 改变右侧图标为向下箭头
        $rightMark.attr("class", "glyphicon glyphicon-chevron-down");
    } else {
        $systemMenu.css("display", "none");
        $rightMark.attr("class", "glyphicon glyphicon-chevron-left")
    }
}

// 清空搜索内容
function removeContent() {
    $("#searchContent").val("");
}