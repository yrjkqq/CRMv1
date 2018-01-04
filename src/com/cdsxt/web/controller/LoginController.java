package com.cdsxt.web.controller;

import com.cdsxt.po.User;
import com.cdsxt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

@Controller
@RequestMapping("crm")
public class LoginController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"", "index"}, method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    // 验证登陆
    @RequestMapping(value = "testify", method = RequestMethod.POST)
    public String testify(@RequestParam("username") String username, @RequestParam("password") String password, Model model,
                          HttpServletRequest request) {
        // 验证用户名和密码
        User user = this.userService.queryUserByName(username);
        if (Objects.nonNull(user)) {
            // 不为空， 验证密码
            if (user.getPassword().equals(password)) {
                // 相等，验证通过，跳转到主页面
                // 登陆成功之后将 user 对象保存到作用域中
                request.getSession().setAttribute("currentUser", user);
                return "main";
            } else {
                // 密码错误
                model.addAttribute("passwordTip", "密码不正确，请检查输入");
                model.addAttribute("username", username);
                return "login";
            }
        }
        // 用户不存在
        model.addAttribute("usernameTip", "该用户不存在，请检查输入");
        model.addAttribute("username", username);
        return "login";
    }

    // 安全退出
    @RequestMapping("quit")
    public String quit(HttpServletRequest request) {
        // 使 session 失效
        request.getSession().invalidate();
        // 返回登陆页面
        return "login";
    }

    // 首页
    @RequestMapping("main")
    public String main() {
        return "main";
    }
}
