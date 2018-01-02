package com.cdsxt.web.controller;

import com.cdsxt.po.CrmRole;
import com.cdsxt.service.CrmRoleService;
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
@RequestMapping("crm")
public class CrmRoleController {

    @Autowired
    private CrmRoleService crmRoleService;


    // 查询角色表, 将查询结果以 json 格式返回
    @RequestMapping(value = "role", method = RequestMethod.GET)
    public String queryAllRole(ModelMap modelMap, @RequestParam(value = "curPage", defaultValue = "1") Integer curPage) throws IOException {
        List<CrmRole> crmRoleList = crmRoleService.queryAllRole();

        PageUtil page = new PageUtil(crmRoleList.size(), curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<CrmRole> crmRoleListOnePage = crmRoleService.queryRoleOnePage(startRow, pageCount);

        modelMap.addAttribute("page", page);
        modelMap.addAttribute("crmRoleList", crmRoleListOnePage);
        return "roles/role";
    }

    /*
    角色管理
     */
    // 添加角色
    @RequestMapping(value = "addRole", method = RequestMethod.POST)
    public String addRole(CrmRole crmRole) {
        // 数据库中插入记录
        crmRoleService.addRole(crmRole);
        return "redirect:/crm/role";
    }

    @RequestMapping(value = "addRole", method = RequestMethod.GET)
    public String addRole() {
        return "roles/addRole";
    }

    // 删除角色
    @RequestMapping("deleteRole/{id}")
    public String deleteRole(@PathVariable("id") Integer id) {
        crmRoleService.deleteRole(id);
        return "redirect:/crm/role";
    }

    // 修改角色: 查询角色并返回到修改页面
    @RequestMapping(value = "modifyRole/{id}", method = RequestMethod.GET)
    public String modifyRole(@PathVariable("id") Integer id, ModelMap mp) {
        mp.addAttribute("role", crmRoleService.queryRoleById(id));
        return "roles/modifyRole";
    }

    // 修改角色: 修改数据库
    @RequestMapping(value = "modifyRole", method = RequestMethod.POST)
    public String modifyRole(CrmRole crmRole) {
        crmRoleService.modifyRole(crmRole);
        return "redirect:/crm/role";
    }
}
