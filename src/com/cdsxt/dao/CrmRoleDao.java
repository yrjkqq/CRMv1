package com.cdsxt.dao;

import com.cdsxt.po.CrmRole;

import java.util.List;

public interface CrmRoleDao {

    List<CrmRole> queryAllRole();

    List<CrmRole> queryRoleOnePage(int startRow, int pageRow);

    void deleteRole(CrmRole crmRole);

    CrmRole queryRoleById(int id);

    void modifyRole(CrmRole crmRole);

    void addRole(CrmRole crmRole);
}
