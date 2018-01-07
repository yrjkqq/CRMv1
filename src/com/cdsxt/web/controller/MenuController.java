package com.cdsxt.web.controller;

import com.cdsxt.interceptor.annotation.Authorize;
import com.cdsxt.po.Resource;
import com.cdsxt.service.ResourceService;
import com.cdsxt.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 菜单管理
 */

@Controller
@RequestMapping("menus")
public class MenuController {

    @Autowired
    private ResourceService resourceService;

    @Authorize(value = "MENU_MANAGE")
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index(ModelMap model, @RequestParam(value = "curPage", defaultValue = "1") Integer curPage) {

        List<Resource> menuList = resourceService.queryAllResourceWithMenu();
        PageUtil page = new PageUtil(menuList.size(), curPage);
        int startRow = page.getStartRow();
        int pageCount = page.getPageRow();
        List<Resource> menuListOnePage = resourceService.queryResourceOnePageWithMenu(startRow, pageCount);

        model.addAttribute("page", page);
        model.addAttribute("menuList", menuListOnePage);

        return "menus/index";
    }
}
