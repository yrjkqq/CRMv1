package com.cdsxt.web.controller;

import com.cdsxt.po.CrmResource;
import com.cdsxt.service.CrmResourceService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("crm")
public class CrmResourceController {

    @Autowired
    private CrmResourceService crmResourceService;

    // 查询资源表, 全部查询
    @RequestMapping(value = "resource", method = RequestMethod.GET)
    public String resource(ModelMap model, @RequestParam(value = "curPage", defaultValue = "1") Integer curPage) {
        List<CrmResource> crmResourceList = crmResourceService.queryAllResource();
        PageUtil page = new PageUtil(crmResourceList.size(), curPage);
        // PageUtil page = new PageUtil(10, curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<CrmResource> crmResourceListOnePage = crmResourceService.queryResourceOnePage(startRow, pageCount);

        model.addAttribute("page", page);
        model.addAttribute("crmResourceList", crmResourceListOnePage);
        return "resources/resource";
    }

    /*
    资源管理
     */

    // 添加资源
    @RequestMapping(value = "addResource", method = RequestMethod.POST)
    public String addResource(@Validated @ModelAttribute("crmResource") CrmResource crmResource, BindingResult result) {
        if (result.hasErrors()) {
            // 有错误
            System.out.println("出错");
            return "redirect:/crm/resource";
        }
        // 数据库中插入记录
        crmResourceService.addResource(crmResource);
        return "redirect:/crm/resource";
    }

    // 删除资源
    @RequestMapping("deleteResource/{id}")
    public String deleteResource(@PathVariable("id") Integer id) {
        CrmResource cr = new CrmResource();
        cr.setId(id);
        crmResourceService.deleteResource(cr);
        return "redirect:/crm/resource";
    }

    // 修改资源: 查询资源并返回 json 对象
    @RequestMapping(value = "modifyResource/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CrmResource modifyResource(@PathVariable("id") Integer id) {
        // 根据 id 查询用户, 返回 json 对象给页面
        return crmResourceService.queryResourceById(id);
    }

    // 修改资源: 修改数据库
    @RequestMapping(value = "modifyResource", method = RequestMethod.POST)
    public String modifyResource(CrmResource crmResource) {
        crmResourceService.modifyResource(crmResource);
        return "redirect:/crm/resource";
    }

}
