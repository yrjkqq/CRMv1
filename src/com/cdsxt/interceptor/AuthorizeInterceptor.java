package com.cdsxt.interceptor;

import com.cdsxt.exception.AuthorizeException;
import com.cdsxt.interceptor.annotation.Authorize;
import com.cdsxt.po.User;
import com.cdsxt.web.controller.UserController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;
import java.util.Set;

/**
 * 用于控制权限的拦截器
 */
public class AuthorizeInterceptor implements HandlerInterceptor {

    @Autowired
    private UserController userController;

    /**
     * doFilter() 方法之前之前, 需要拦截
     *
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            // 强转
            HandlerMethod handlerMethod = HandlerMethod.class.cast(handler);
            // 获取方法上的权限注解
            Authorize authorize = handlerMethod.getMethodAnnotation(Authorize.class);
            if (Objects.nonNull(authorize)) {
                // 获取当前登陆用户的所有角色的所有资源列表
                Set<String> resources = userController.getAllResourcesByUser((User) request.getSession().getAttribute("currentUser"));
                if (resources.contains(authorize.value())) {
                    // 存在注解, 放行
                    return true;
                }
                // 不存在, 没有权限, 抛出异常
                throw new AuthorizeException("没有相应的权限: " + authorize.value());
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
