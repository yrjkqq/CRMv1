package com.cdsxt.dao;

import com.cdsxt.po.Dept;

import java.util.List;

public interface DeptDao {

    List<Dept> queryAllDept();

    Dept queryDeptById(Integer id);

    void addDept(Dept dept);

    void deleteDept(Dept dept);

    void modifyDept(Dept dept);

    List<Dept> queryOnePage(int startRow, int pageRow);
}
