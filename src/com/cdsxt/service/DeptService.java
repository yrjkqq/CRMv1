package com.cdsxt.service;

import com.cdsxt.po.Dept;

import java.util.List;

public interface DeptService {

    List<Dept> queryAllDept();

    List<Dept> queryOnePage(int startRow, int pageRow);

    Dept queryDeptById(Integer id);

    void addDept(Dept dept);

    void deleteDept(Dept dept);

    void modifyDept(Dept dept);
}
