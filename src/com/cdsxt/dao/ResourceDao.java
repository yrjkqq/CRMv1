package com.cdsxt.dao;

import com.cdsxt.po.Resource;

import java.util.List;

public interface ResourceDao {

    List<Resource> queryAllResource();

    List<Resource> queryAllResourceWithMenu();
    List<Resource> queryAllResourceWithoutMenu();

    List<Resource> queryResourceOnePage(int startRow, int pageRow);

    List<Resource> queryResourceOnePageWithMenu(int startRow, int pageRow);
    List<Resource> queryResourceOnePageWithoutMenu(int startRow, int pageRow);

    void deleteResource(Resource cr);

    Resource queryResourceById(int id);

    void modifyResource(Resource resource);

    void addResource(Resource resource);
}
