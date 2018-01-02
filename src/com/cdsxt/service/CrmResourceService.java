package com.cdsxt.service;

import com.cdsxt.po.CrmResource;

import java.util.List;

public interface CrmResourceService {

    List<CrmResource> queryAllResource();

    List<CrmResource> queryResourceOnePage(int startRow, int pageRow);

    void deleteResource(CrmResource cr);

    CrmResource queryResourceById(int id);

    void modifyResource(CrmResource crmResource);

    void addResource(CrmResource crmResource);
}
