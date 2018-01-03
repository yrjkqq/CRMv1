package com.cdsxt.dao;

import com.cdsxt.po.Resource;

import java.util.List;

public interface ResourceDao {

    List<Resource> queryAllResource();

    List<Resource> queryResourceOnePage(int startRow, int pageRow);

    void deleteResource(Resource cr);

    Resource queryResourceById(int id);

    void modifyResource(Resource resource);

    void addResource(Resource resource);
}
