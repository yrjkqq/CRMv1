package com.cdsxt.web.controller;


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
    @RequestMapping(value = "addDept", method = RequestMethod.POST)
    public String addDept(Dept dept) {
        this.deptService.addDept(dept);
        return "redirect:/depts/index";
    }

    // 删除部门
    @RequestMapping(value = "deleteDept/{id}", method = RequestMethod.GET)
    public String deleteDept(@PathVariable("id") Integer id) {
        Dept dept = this.deptService.queryDeptById(id);
        this.deptService.deleteDept(dept);
        return "redirect:/depts/index";
    }

    // 修改部门
    @RequestMapping(value = "modifyDept/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Dept modifyDept(@PathVariable("id") Integer id, Model model) {
        // 返回所需要修改的部门
        return this.deptService.queryDeptById(id);
    }

    @RequestMapping(value = "modifyDept", method = RequestMethod.POST)
    public String modifyDept(Dept dept) {
        this.deptService.modifyDept(dept);
        return "redirect:/depts/index";
    }


}
