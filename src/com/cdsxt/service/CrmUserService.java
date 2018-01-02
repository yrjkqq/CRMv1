package com.cdsxt.service;

import com.cdsxt.po.CrmUser;

import java.util.List;

public interface CrmUserService {

    List<CrmUser> queryAll();

    List<CrmUser> queryOnePage(int startRow, int pageRow);

    void deleteUser(int id);

    CrmUser queryUserById(int id);

    void modifyUser(CrmUser crmUser);

    void addUser(CrmUser crmUser);

}
