<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String url = request.getParameter("url");
    if (url.indexOf("?") != -1) {
        url += "&";
    } else {
        url += "?";
    }
    pageContext.setAttribute("url", url);
%>

<nav aria-label="Page navigation">
    <ul class="pagination" style="margin:0">
        <li>
            <a href="${url}curPage=${page.firstPage}" aria-label="first">
                <span aria-hidden="true">首页</span>
            </a>
        </li>
        <li>
            <a href="${url}curPage=${page.prePage}" aria-label="previous">
                <span aria-hidden="true">上一页</span>
            </a>
        </li>

        <c:forEach begin="${page.startNav}" end="${page.endNav}" var="i">
            <c:choose>
                <c:when test="${page.curPage == i}">
                    <li class="active"><a>${i}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${url}curPage=${i}">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <li>
            <a href="${url}curPage=${page.nextPage}" aria-label="next">
                <span aria-hidden="true">下一页</span>
            </a>
        </li>
        <li>
            <a href="${url}curPage=${page.lastPage}" aria-label="last">
                <span aria-hidden="true">尾页</span>
            </a>
        </li>
    </ul>
</nav>