package com.cdsxt.dao;

import com.cdsxt.po.Complaint;
import com.cdsxt.po.User;

import java.util.List;

public interface ComplaintDao {
    void add(Complaint complaint);

    List<Complaint> queryAllWithStatus(String status);

    List<User> queryUserByRoleConstant(String roleConstant);

    Complaint queryComplaintById(Integer complaintId);
}
