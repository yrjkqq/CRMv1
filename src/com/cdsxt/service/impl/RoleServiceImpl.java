package com.cdsxt.service.impl;

import com.cdsxt.dao.RoleDao;
import com.cdsxt.po.Resource;
import com.cdsxt.po.Role;
import com.cdsxt.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao roleDao;

    @Override
    public List<Role> queryAllRole() {
        return roleDao.queryAllRole();
    }

    @Override
    public List<Role> queryRoleOnePage(int startRow, int pageRow) {
        return roleDao.queryRoleOnePage(startRow, pageRow);
    }

    @Override
    public Role queryRoleById(int id) {
        return roleDao.queryRoleById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteRole(Role role) {
        roleDao.deleteRole(role);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyRole(Role role) {
        roleDao.modifyRole(role);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addRole(Role role) {
        roleDao.addRole(role);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void allocateResource(Integer roleId, Integer[] selectedResources) {
        Role role = this.roleDao.queryRoleById(roleId);
        Set<Resource> resources = role.getResources();
        resources.clear();
        for (Integer i : selectedResources) {
            Resource resource = new Resource();
            resource.setId(i);
            resources.add(resource);
        }
    }

}
