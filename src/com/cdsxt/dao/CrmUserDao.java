package com.cdsxt.dao;

import com.cdsxt.po.CrmUser;

import java.util.List;

public interface CrmUserDao {

    List<CrmUser> queryAll();

    List<CrmUser> queryOnePage(int startRow, int pageRow);

    void deleteUser(int id);

    CrmUser queryUserById(int id);

    void modifyUser(CrmUser crmUser);

    void addUser(CrmUser crmUser);
}
