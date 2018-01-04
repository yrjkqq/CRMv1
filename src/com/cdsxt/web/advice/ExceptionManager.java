package com.cdsxt.web.advice;

import com.cdsxt.exception.AuthorizeException;
import com.cdsxt.exception.DeleteException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * 异常处理类
 */

@ControllerAdvice
public class ExceptionManager {

    /**
     * 处理未授权异常
     *
     * @param ae 捕获到权限异常对象
     * @return
     */
    @ExceptionHandler(AuthorizeException.class)
    public ModelAndView validation(AuthorizeException ae) {
        ModelAndView view = new ModelAndView("error/authorizeException");
        view.addObject("tip", ae.getMessage());
        return view;
    }

    /**
     * 处理删除用户异常
     */
    @ExceptionHandler(DeleteException.class)
    public ModelAndView validation(DeleteException de) {
        ModelAndView view = new ModelAndView("error/deleteException");
        view.addObject("tip", de.getMessage());
        return view;
    }
}
