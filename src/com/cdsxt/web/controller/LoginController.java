package com.cdsxt.web.controller;

import com.cdsxt.po.User;
import com.cdsxt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.util.Objects;
import java.util.Properties;

@Controller
@RequestMapping("crm")
public class LoginController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"", "login"}, method = RequestMethod.GET)
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
                return "redirect:/crm/main";
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

    // 找回密码: 找回密码页面
    @RequestMapping(value = "forgotPassword", method = RequestMethod.GET)
    public String forgotPassword() {
        // 返回页面上, 填写用户名和注册邮箱
        return "forgotPassword";
    }

    // 找回密码: 发送邮件
    @RequestMapping(value = "forgotPassword", method = RequestMethod.POST)
    public String forgotPassword(String username, String email) throws MessagingException {
        // 先验证用户是否存在
        if (Objects.nonNull(this.userService.queryUserByName(username))) {
            Properties props = new Properties();
            // 开启debug调试
            props.setProperty("mail.debug", "true");
            // 发送服务器需要身份验证
            props.setProperty("mail.smtp.auth", "true");
            // 设置邮件服务器主机名
            props.setProperty("mail.host", "smtp.qq.com");
            // 发送邮件协议名称
            props.setProperty("mail.transport.protocol", "smtp");

            // 设置环境信息
            Session session = Session.getInstance(props);

            // 创建邮件对象
            Message msg = new MimeMessage(session);
            msg.setSubject("重置密码链接!!!");
            // 设置邮件内容
            msg.setText("请打开该链接修改密码: http://localhost:8080/crm/resetPassword");
            // 设置发件人
            msg.setFrom(new InternetAddress("771338054@qq.com"));
            Transport transport = session.getTransport();
            // 连接邮件服务器
            transport.connect("771338054", "zonlgupsrzsdbefc");
            // 发送邮件
            transport.sendMessage(msg, new Address[]{new InternetAddress(email)});
            // 关闭连接
            transport.close();
        }
        return "login";
    }

    // 重置密码页面
    @RequestMapping(value = "resetPassword", method = RequestMethod.GET)
    public String resetPassword() {
        return "resetPassword";
    }

    // 重置密码: 将新密码更新到数据库中
    @RequestMapping(value = "resetPassword", method = RequestMethod.POST)
    public String resetPassword(String username, String password) {
        User user = this.userService.queryUserByName(username);
        if (Objects.nonNull(user)) {
            user.setPassword(password);
            this.userService.modifyUser(user);
        }
        // 返回到登陆页面
        return "login";
    }
}
