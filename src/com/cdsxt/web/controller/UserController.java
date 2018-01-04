package com.cdsxt.web.controller;

import com.cdsxt.exception.DeleteException;
import com.cdsxt.interceptor.annotation.Authorize;
import com.cdsxt.po.User;
import com.cdsxt.service.RoleService;
import com.cdsxt.service.UserService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Objects;
import java.util.Set;

@Controller
@RequestMapping("users")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    // 查询用户表, 全部查询
    @Authorize(value = "SYS_USER_VIEW")
    @RequestMapping(value = {"", "index"}, method = RequestMethod.GET)
    public String index(ModelMap modelMap, @RequestParam(value = "curPage", defaultValue = "1") Integer curPage) {
        List<User> userList = userService.queryAll();

        PageUtil page = new PageUtil(userList.size(), curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<User> userListOnePage = userService.queryOnePage(startRow, pageCount);

        modelMap.addAttribute("page", page);
        modelMap.addAttribute("userList", userListOnePage);
        return "users/index";
    }

    /*
    用户管理
     */

    // 添加用户
    @Authorize(value = "SYS_USER_SAVE") // 保存用户权限
    @RequestMapping(value = "addUser", method = RequestMethod.POST)
    public String addUser(User user) {
        // 数据库中插入记录
        userService.addUser(user);
        return "redirect:/users/index";
    }

    // 删除用户
    @Authorize(value = "SYS_USER_DELETE")
    @RequestMapping("deleteUser/{id}")
    public String deleteUser(@PathVariable("id") Integer id, HttpServletRequest request) throws DeleteException {
        // 判断需要删除的用户 id 和当前登录用户 id 是否相同, 相同表示在删除自己, 不允许操作
        if (Objects.nonNull(id) && id.equals(((User) request.getSession().getAttribute("currentUser")).getId())) {
            throw new DeleteException("Stupid!!! 不允许删除自己");
        }

        User user = this.userService.queryUserById(id);
        userService.deleteUser(user);
        return "redirect:/users/index";
    }

    // 修改用户: 查询用户并返回 json 对象
    @Authorize(value = "SYS_USER_UPDATE")
    @RequestMapping(value = "modifyUser/{id}", method = RequestMethod.GET)
    @ResponseBody
    public User modifyUser(@PathVariable("id") Integer id) {
        // 根据 id 查询用户, 返回 json 对象给页面
        return userService.queryUserById(id);
    }

    // 修改用户: 修改数据库
    @Authorize(value = "SYS_USER_UPDATE")
    @RequestMapping(value = "modifyUser", method = RequestMethod.POST)
    public String modifyUser(User user) {
        userService.modifyUser(user);
        return "redirect:/users/index";
    }

    // 为用户分配角色
    @Authorize(value = "SYS_USER_ALLOC_ROLE")
    @RequestMapping(value = "allocateRole/{id}", method = RequestMethod.GET)
    public String allocateRole(@PathVariable("id") Integer id, Model model) {
        // 先查询出原有的课程, 并返回到页面上
        User user = this.userService.queryUserById(id);
        if (Objects.nonNull(user)) {
            // 用户存在
            model.addAttribute("user", user);
            // 将所有可选角色一并返回
            model.addAttribute("allRoles", this.roleService.queryAllRole());
            return "users/allocateRole";
        } else {
            // todo 用户不存在, 如何处理?
            return null;
        }
    }

    /**
     * 为用户分配角色
     *
     * @param id    当前用户的 id
     * @param roles 该用户所选中的角色列表
     * @return 返回到用户主页面
     */
    @Authorize(value = "SYS_USER_ALLOC_ROLE")
    @RequestMapping(value = "allocateRole/{id}", method = RequestMethod.POST)
    public String allocateRole(@PathVariable("id") Integer id, Integer[] roles) {
        this.userService.allocateRole(id, roles);
        return "redirect:/users/index";
    }


    /**
     * 获取当前用户的资源列表
     *
     * @param user 当前登陆用户, 根据 session 可以获取到
     * @return 当前用户所有权限组成的字符串集合, 因为权限为唯一键, 不可能重复
     */
    public Set<String> getAllResourcesByUser(User user) {
        return this.userService.getAllResourcesByUser(user.getId());
    }

}
