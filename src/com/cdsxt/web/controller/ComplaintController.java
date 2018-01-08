package com.cdsxt.web.controller;

import com.cdsxt.po.Complaint;
import com.cdsxt.po.User;
import com.cdsxt.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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

    // 客服: 添加投诉
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String add(Complaint complaint) {
        this.complaintService.add(complaint);
        return "redirect:/complaints/index";
    }

    // 主管: 查看未处理投诉
    // 返回 json
    @ResponseBody
    @RequestMapping(value = "queryAll", method = RequestMethod.GET)
    public List<Complaint> queryAllWithStatus(String status) {
        return this.complaintService.queryAllWithStatus(status);
    }

    // 查询所有售后人员: 指定经理下所有员工
    @ResponseBody
    @RequestMapping(value = "queryAfterSales", method = RequestMethod.GET)
    public List<User> queryAfterSales(Integer managerId) {
        List<User> allAfterSales = this.complaintService.queryUserByRoleConstant("SERVICE_AFTER_SALES");
        return allAfterSales;
    }

    // 指派售后
    @RequestMapping(value = "appointAfterSales", method = RequestMethod.GET)
    @ResponseBody
    public String appointAfterSales(Integer complaintId, Integer afterSalesId) {
        Complaint complaint = this.complaintService.queryComplaintById(complaintId);
        // 指派售后: 只需有修改投诉记录中的 service_after_sales_id 即可
        this.complaintService.appointAfterSales(complaint, afterSalesId);
        return "done";
    }
}
