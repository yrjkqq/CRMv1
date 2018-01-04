package com.cdsxt.web.advice;

import com.cdsxt.exception.AuthorizeException;
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
}
