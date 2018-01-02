package com.cdsxt.service.impl;

import com.cdsxt.dao.CrmResourceDao;
import com.cdsxt.po.CrmResource;
import com.cdsxt.service.CrmResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class CrmResourceServiceImpl implements CrmResourceService {

    @Autowired
    private CrmResourceDao crmResourceDao;

    @Override
    public List<CrmResource> queryAllResource() {
        return crmResourceDao.queryAllResource();
    }

    @Override
    public CrmResource queryResourceById(int id) {
        return crmResourceDao.queryResourceById(id);
    }

    @Override
    public List<CrmResource> queryResourceOnePage(int startRow, int pageRow) {
        return crmResourceDao.queryResourceOnePage(startRow, pageRow);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteResource(CrmResource cr) {
        crmResourceDao.deleteResource(cr);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyResource(CrmResource crmResource) {
        crmResourceDao.modifyResource(crmResource);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addResource(CrmResource crmResource) {
        crmResourceDao.addResource(crmResource);
    }

}
