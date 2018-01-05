package com.cdsxt.service.impl;

import com.cdsxt.dao.ResourceDao;
import com.cdsxt.po.Resource;
import com.cdsxt.po.Role;
import com.cdsxt.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceDao resourceDao;

    @Override
    public List<Resource> queryAllResource() {
        return resourceDao.queryAllResource();
    }

    @Override
    public List<Resource> queryAllResourceWithMenu() {
        return resourceDao.queryAllResourceWithMenu();
    }

    @Override
    public Resource queryResourceById(int id) {
        return resourceDao.queryResourceById(id);
    }

    @Override
    public List<Resource> queryResourceOnePage(int startRow, int pageRow) {
        return resourceDao.queryResourceOnePage(startRow, pageRow);
    }

    @Override
    public List<Resource> queryResourceOnePageWithMenu(int startRow, int pageRow) {
        return resourceDao.queryResourceOnePageWithMenu(startRow, pageRow);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteResource(Resource cr) {
        // 删除资源时, 需要先断开联系
        Set<Role> roles = cr.getRoles();
        for (Role role : roles) {
            role.getResources().remove(cr);
        }
        resourceDao.deleteResource(cr);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyResource(Resource resource) {
        // 父节点的 id 如果为 null, 则设置 null
        if (Objects.isNull(resource.getParent().getId())) {
            resource.setParent(null);
        }
        resourceDao.modifyResource(resource);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addResource(Resource resource) {
        // 父节点的 id 如果为 null, 则设置 null
        if (Objects.isNull(resource.getParent().getId())) {
            resource.setParent(null);
        }
        resourceDao.addResource(resource);
    }

}
