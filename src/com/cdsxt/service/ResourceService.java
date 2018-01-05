package com.cdsxt.service;

import com.cdsxt.po.Resource;

import java.util.List;

public interface ResourceService {

    List<Resource> queryAllResource();

    List<Resource> queryAllResourceWithMenu();

    List<Resource> queryResourceOnePage(int startRow, int pageRow);

    List<Resource> queryResourceOnePageWithMenu(int startRow, int pageRow);

    Resource queryResourceById(int id);

    void deleteResource(Resource cr);

    void modifyResource(Resource resource);

    void addResource(Resource resource);
}
