package com.cdsxt.service;

import com.cdsxt.po.Role;

import java.util.List;

public interface RoleService {

    List<Role> queryAllRole();

    List<Role> queryRoleOnePage(int startRow, int pageRow);

    void deleteRole(Role role);

    Role queryRoleById(int id);

    void modifyRole(Role role);

    void addRole(Role role);
}
