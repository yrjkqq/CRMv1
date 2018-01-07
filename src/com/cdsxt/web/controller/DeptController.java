package com.cdsxt.web.controller;


import com.cdsxt.interceptor.annotation.Authorize;
import com.cdsxt.po.Dept;
import com.cdsxt.service.DeptService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 部门管理
 */

@RequestMapping("depts")
@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    // 查询所有部门并返回到页面上
    @Authorize(value = "SYS_DEPT_VIEW")
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index(@RequestParam(value = "curPage", defaultValue = "1") Integer curPage, Model model) {
        List<Dept> depts = this.deptService.queryAllDept();
        PageUtil page = new PageUtil(depts.size(), curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<Dept> deptList = this.deptService.queryOnePage(startRow, pageCount);
        model.addAttribute("depts", deptList);
        model.addAttribute("page", page);
        return "depts/index";
    }

    // 新增部门
    @Authorize(value = "SYS_DEPT_SAVE")
    @RequestMapping(value = "addDept", method = RequestMethod.POST)
    public String addDept(Dept dept) {
        this.deptService.addDept(dept);
        return "redirect:/depts/index";
    }

    // 删除部门
    @Authorize(value = "SYS_DEPT_DELETE")
    @RequestMapping(value = "deleteDept", method = RequestMethod.GET)
    public String deleteDept(@RequestParam(value = "deleteDeptId") Integer deleteDeptId) {
        Dept dept = this.deptService.queryDeptById(deleteDeptId);
        this.deptService.deleteDept(dept);
        return "redirect:/depts/index";
    }

    // 修改部门
    @Authorize(value = "SYS_DEPT_UPDATE")
    @RequestMapping(value = "modifyDept/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Dept modifyDept(@PathVariable("id") Integer id, Model model) {
        // 返回所需要修改的部门
        return this.deptService.queryDeptById(id);
    }

    @Authorize(value = "SYS_DEPT_UPDATE")
    @RequestMapping(value = "modifyDept", method = RequestMethod.POST)
    public String modifyDept(Dept dept) {
        this.deptService.modifyDept(dept);
        return "redirect:/depts/index";
    }


}
