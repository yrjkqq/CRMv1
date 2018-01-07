package com.cdsxt.filter;

import com.cdsxt.po.Resource;
import com.cdsxt.po.Role;
import com.cdsxt.po.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        resp.setCharacterEncoding("utf-8");
        resp.setHeader("content-type", "text/html;charset=utf-8");

        // 验证当前请求中是否有 user 对象
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        // 如果路径以 /crm 结尾, 表示当前为登陆, 可以直接放行
        // 以 /crm/testify 结尾表示为登陆验证, 需要放行
        // 静态资源也需要直接放行
        String url = req.getRequestURL().toString();
        if (url.endsWith("/crm") || url.endsWith("/crm/testify") || url.endsWith("/forgotPassword") || url.endsWith("/resetPassword")
                || url.endsWith(".js") || url.endsWith(".css") || url.endsWith(".gif") ||
                url.endsWith(".png") || url.endsWith(".jpg") || Objects.nonNull(currentUser)) {
            chain.doFilter(request, response);

            // 返回到页面通过过滤器时, 需要获取当前登陆对象
            User currentUser1 = (User) req.getSession().getAttribute("currentUser");
            if (Objects.nonNull(currentUser1)) {
                // 查询当前用户所有角色的所有权限
                Set<Role> currentUserRoles = currentUser1.getRoles();
                // 使菜单有顺序
                Set<String> currentUserResources = new LinkedHashSet<>();
                Set<Resource> cur = new HashSet<>();
                for (Role role : currentUserRoles) {
                    for (Resource resource : role.getResources()) {
                        currentUserResources.add(resource.getConstant());
                        // 同时为菜单做准备工作, 获取所有资源对象, 并去重
                        cur.add(resource);
                    }
                }
                // 返回到页面上
                req.getSession().setAttribute("currentUserResources", currentUserResources);
                req.getSession().setAttribute("cur", cur);
            }
        } else {
            resp.getWriter().write("<h3>未登录, 请<a href='/crm'>登陆</a>后使用本系统!</h3>");
        }
    }

    @Override
    public void destroy() {

    }
}
