package com.cdsxt.service.impl;

import com.cdsxt.dao.ComplaintDao;
import com.cdsxt.dao.UserDao;
import com.cdsxt.po.Complaint;
import com.cdsxt.po.HandleMethod;
import com.cdsxt.po.User;
import com.cdsxt.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class ComplaintServiceImpl implements ComplaintService {

    @Autowired
    private ComplaintDao complaintDao;

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void add(Complaint complaint) {
        complaintDao.add(complaint);
    }

    @Override
    public List<Complaint> queryAllWithStatus(String status) {
        return complaintDao.queryAllWithStatus(status);
    }

    @Override
    public List<User> queryUserByRoleConstant(String roleConstant) {
        return complaintDao.queryUserByRoleConstant(roleConstant);
    }

    @Override
    public Complaint queryComplaintById(Integer complaintId) {
        return complaintDao.queryComplaintById(complaintId);
    }

    // 指派售后
    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void appointAfterSales(Complaint complaint, Integer afterSalesId) {
        complaint.setServiceAfterSales(this.userDao.queryUserById(afterSalesId));
        // 同时将投诉状态由: 未指派改为未处理
        complaint.setStatus("未处理");
    }

    // 处理投诉
    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void handleComplaint(Complaint complaint, String handleMethod) {
        // 新建 HandleMethod
        HandleMethod hm = new HandleMethod();
        // 设置属性
        hm.setHandleMethod(handleMethod);
        // 设置投诉
        hm.setComplaint(complaint);
        // 设置开始时间
        hm.setStartDate(new Date());
        // HandleMethod 为瞬时态对象, 需要手动保存
        complaintDao.addHandleMethod(hm);

        // 保存后再添加到投诉记录中
        Set<HandleMethod> handleMethods = complaint.getHandlerMethods();
        // 增加一条处理记录
        handleMethods.add(hm);
        // 修改投诉状态为: 未回访
        complaint.setStatus("未回访");
    }
}
