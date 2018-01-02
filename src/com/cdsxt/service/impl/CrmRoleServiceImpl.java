package com.cdsxt.service.impl;

import com.cdsxt.dao.CrmRoleDao;
import com.cdsxt.po.CrmRole;
import com.cdsxt.service.CrmRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class CrmRoleServiceImpl implements CrmRoleService {

    @Autowired
    private CrmRoleDao crmRoleDao;

    @Override
    public List<CrmRole> queryAllRole() {
        return crmRoleDao.queryAllRole();
    }

    @Override
    public List<CrmRole> queryRoleOnePage(int startRow, int pageRow) {
        return crmRoleDao.queryRoleOnePage(startRow, pageRow);
    }

    @Override
    public CrmRole queryRoleById(int id) {
        return crmRoleDao.queryRoleById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteRole(CrmRole crmRole) {
        crmRoleDao.deleteRole(crmRole);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyRole(CrmRole crmRole) {
        crmRoleDao.modifyRole(crmRole);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addRole(CrmRole crmRole) {
        crmRoleDao.addRole(crmRole);
    }

}
