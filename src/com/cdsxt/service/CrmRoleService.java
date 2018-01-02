package com.cdsxt.service;

import com.cdsxt.po.CrmRole;

import java.util.List;

public interface CrmRoleService {

    List<CrmRole> queryAllRole();

    List<CrmRole> queryRoleOnePage(int startRow, int pageRow);

    void deleteRole(int id);

    CrmRole queryRoleById(int id);

    void modifyRole(CrmRole crmRole);

    void addRole(CrmRole crmRole);
}
