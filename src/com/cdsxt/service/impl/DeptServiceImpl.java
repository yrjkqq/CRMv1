package com.cdsxt.service.impl;

import com.cdsxt.dao.DeptDao;
import com.cdsxt.dao.UserDao;
import com.cdsxt.po.Dept;
import com.cdsxt.po.User;
import com.cdsxt.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptDao deptDao;

    @Autowired
    private UserDao userDao;

    @Override
    public List<Dept> queryAllDept() {
        return deptDao.queryAllDept();
    }

    @Override
    public List<Dept> queryOnePage(int startRow, int pageRow) {
        return deptDao.queryOnePage(startRow, pageRow);
    }

    @Override
    public Dept queryDeptById(Integer id) {
        return deptDao.queryDeptById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addDept(Dept dept) {
        deptDao.addDept(dept);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteDept(Dept dept) {
        // 直接删除部门, 该部门的员工没有部门, 会报错; 需要先删除该部门所有员工
        Set<User> users = dept.getUsers();
        for (User user : users) {
            this.userDao.deleteUser(user);
        }
        deptDao.deleteDept(dept);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyDept(Dept dept) {
        deptDao.modifyDept(dept);
    }
}
