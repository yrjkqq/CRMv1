package com.cdsxt.dao;

import com.cdsxt.po.CrmResource;

import java.util.List;

public interface CrmResourceDao {

    List<CrmResource> queryAllResource();

    List<CrmResource> queryResourceOnePage(int startRow, int pageRow);

    void deleteResource(CrmResource cr);

    CrmResource queryResourceById(int id);

    void modifyResource(CrmResource crmResource);

    void addResource(CrmResource crmResource);
}
