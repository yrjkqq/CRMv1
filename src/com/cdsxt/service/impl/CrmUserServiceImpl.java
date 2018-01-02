package com.cdsxt.service.impl;

import com.cdsxt.dao.CrmUserDao;
import com.cdsxt.po.CrmUser;
import com.cdsxt.service.CrmUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class CrmUserServiceImpl implements CrmUserService {

    @Autowired
    private CrmUserDao crmUserDao;

    public List<CrmUser> queryAll() {
        return crmUserDao.queryAll();
    }

    @Override
    public List<CrmUser> queryOnePage(int startRow, int pageRow) {
        return crmUserDao.queryOnePage(startRow, pageRow);
    }

    @Override
    public CrmUser queryUserById(int id) {
        return crmUserDao.queryUserById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteUser(CrmUser crmUser) {
        crmUserDao.deleteUser(crmUser);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyUser(CrmUser crmUser) {
        crmUserDao.modifyUser(crmUser);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addUser(CrmUser crmUser) {
        crmUserDao.addUser(crmUser);
    }
}
