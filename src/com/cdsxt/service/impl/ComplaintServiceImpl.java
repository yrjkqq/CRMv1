package com.cdsxt.service.impl;

import com.cdsxt.dao.ComplaintDao;
import com.cdsxt.po.Complaint;
import com.cdsxt.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class ComplaintServiceImpl implements ComplaintService {

    @Autowired
    private ComplaintDao complaintDao;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void add(Complaint complaint) {
        complaintDao.add(complaint);
    }
}
