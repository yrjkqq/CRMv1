package com.cdsxt.web.controller;

import com.cdsxt.po.Complaint;
import com.cdsxt.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 投诉管理
 */

@Controller
@RequestMapping("complaints")
public class ComplaintController {

    @Autowired
    private ComplaintService complaintService;

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index() {
        return "complaints/index";
    }

    // 添加投诉
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String add(Complaint complaint) {
        this.complaintService.add(complaint);
        return "redirect:/complaints/index";
    }
}
