package com.cdsxt.web.controller;

import com.cdsxt.po.Role;
import com.cdsxt.service.RoleService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("roles")
public class RoleController {

    @Autowired
    private RoleService roleService;


    // 查询角色表, 将查询结果以 json 格式返回
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index(ModelMap modelMap, @RequestParam(value = "curPage", defaultValue = "1") Integer curPage) throws IOException {
        List<Role> roleList = roleService.queryAllRole();

        PageUtil page = new PageUtil(roleList.size(), curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<Role> roleListOnePage = roleService.queryRoleOnePage(startRow, pageCount);

        modelMap.addAttribute("page", page);
        modelMap.addAttribute("roleList", roleListOnePage);
        return "roles/index";
    }

    /*
    角色管理
     */

    @RequestMapping(value = "addRole", method = RequestMethod.GET)
    public String addRole() {
        return "roles/addRole";
    }

    // 添加角色
    @RequestMapping(value = "addRole", method = RequestMethod.POST)
    public String addRole(Role role) {
        // 数据库中插入记录
        roleService.addRole(role);
        return "redirect:/roles/index";
    }


    // 删除角色
    @RequestMapping("deleteRole/{id}")
    public String deleteRole(@PathVariable("id") Integer id) {
        Role role = new Role();
        role.setId(id);
        roleService.deleteRole(role);
        return "redirect:/roles/index";
    }

    // 修改角色: 查询角色并返回到修改页面
    @RequestMapping(value = "modifyRole/{id}", method = RequestMethod.GET)
    public String modifyRole(@PathVariable("id") Integer id, ModelMap mp) {
        mp.addAttribute("role", roleService.queryRoleById(id));
        return "roles/modifyRole";
    }

    // 修改角色: 修改数据库
    @RequestMapping(value = "modifyRole", method = RequestMethod.POST)
    public String modifyRole(Role role) {
        roleService.modifyRole(role);
        return "redirect:/roles/index";
    }
}
