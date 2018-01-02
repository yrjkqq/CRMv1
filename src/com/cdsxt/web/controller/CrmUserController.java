package com.cdsxt.web.controller;

import com.cdsxt.po.CrmUser;
import com.cdsxt.service.CrmUserService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("crm")
public class CrmUserController {

    @Autowired
    private CrmUserService crmUserService;

    // 查询用户表, 全部查询
    @RequestMapping(value = "main", method = RequestMethod.GET)
    public String main(ModelMap modelMap, @RequestParam(value = "curPage", defaultValue = "1") Integer curPage) {
        List<CrmUser> crmUserList = crmUserService.queryAll();

        PageUtil page = new PageUtil(crmUserList.size(), curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<CrmUser> crmUserListOnePage = crmUserService.queryOnePage(startRow, pageCount);

        modelMap.addAttribute("page", page);
        modelMap.addAttribute("crmUserList", crmUserListOnePage);
        return "users/main";
    }

    /*
    用户管理
     */

    // 添加用户
    @RequestMapping(value = "addUser", method = RequestMethod.POST)
    public String addUser(CrmUser crmUser) {
        // 数据库中插入记录
        crmUserService.addUser(crmUser);
        return "redirect:/crm/main";
    }

    // 删除用户
    @RequestMapping("deleteUser/{id}")
    public String deleteUser(@PathVariable("id") Integer id) {
        crmUserService.deleteUser(id);
        return "redirect:/crm/main";
    }

    // 修改用户: 查询用户并返回 json 对象
    @RequestMapping(value = "modifyUser/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CrmUser modifyUser(@PathVariable("id") Integer id) {
        // 根据 id 查询用户, 返回 json 对象给页面
        return crmUserService.queryUserById(id);
    }

    // 修改用户: 修改数据库
    @RequestMapping(value = "modifyUser", method = RequestMethod.POST)
    public String modifyUser(CrmUser crmUser) {
        crmUserService.modifyUser(crmUser);
        return "redirect:/crm/main";
    }

}
