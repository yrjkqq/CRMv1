package com.cdsxt.web.controller;

import com.cdsxt.interceptor.annotation.Authorize;
import com.cdsxt.po.Resource;
import com.cdsxt.po.Role;
import com.cdsxt.service.ResourceService;
import com.cdsxt.service.RoleService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("roles")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private ResourceService resourceService;


    // 查询角色表, 将查询结果以 json 格式返回
    @Authorize(value = "SYS_ROLE_VIEW")
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
    @Authorize(value = "SYS_ROLE_SAVE")
    @RequestMapping(value = "addRole", method = RequestMethod.GET)
    public String addRole() {
        return "roles/addRole";
    }

    // 添加角色
    @Authorize(value = "SYS_ROLE_SAVE")
    @RequestMapping(value = "addRole", method = RequestMethod.POST)
    public String addRole(Role role) {
        // 数据库中插入记录
        roleService.addRole(role);
        return "redirect:/roles/index";
    }


    // 删除角色
    @Authorize(value = "SYS_ROLE_DELETE")
    @RequestMapping("deleteRole/{id}")
    public String deleteRole(@PathVariable("id") Integer id) {
        Role role = new Role();
        role.setId(id);
        roleService.deleteRole(role);
        return "redirect:/roles/index";
    }

    // 修改角色: 查询角色并返回到修改页面
    @Authorize(value = "SYS_ROLE_UPDATE")
    @RequestMapping(value = "modifyRole/{id}", method = RequestMethod.GET)
    public String modifyRole(@PathVariable("id") Integer id, ModelMap mp) {
        mp.addAttribute("role", roleService.queryRoleById(id));
        return "roles/modifyRole";
    }

    // 修改角色: 修改数据库
    @Authorize(value = "SYS_ROLE_UPDATE")
    @RequestMapping(value = "modifyRole", method = RequestMethod.POST)
    public String modifyRole(Role role) {
        roleService.modifyRole(role);
        return "redirect:/roles/index";
    }

    // 分配资源
    @Authorize(value = "SYS_ROLE_ALLOC_RESOURCE")
    @RequestMapping(value = "allocateResource/{id}", method = RequestMethod.GET)
    // 返回 json 对象, 其中包括一个角色和多个资源
    @ResponseBody
    public Map<String, Object> allocateResource(@PathVariable("id") Integer id, Model model) {
        // 先查询出原有的资源, 并返回到页面上
        Role role = this.roleService.queryRoleById(id);
        if (Objects.nonNull(role)) {
            // 角色存在
            // 将所有可选资源一并返回
            List<Resource> allResources = this.resourceService.queryAllResource();
            // 使用 map 保存结果
            Map<String, Object> result = new HashMap<>();
            result.put("allResources", allResources);
            result.put("role", role);
            return result;
        } else {
            // todo 角色不存在, 如何处理?
            return null;
        }
    }

    @Authorize(value = "SYS_ROLE_ALLOC_RESOURCE")
    @RequestMapping(value = "allocateResource", method = RequestMethod.POST)
    @ResponseBody // 请求会默认去找视图, 找不到则报错;
    public void allocateResource(Integer roleId, Integer[] selectedResources) {
        this.roleService.allocateResource(roleId, selectedResources);
    }

}
