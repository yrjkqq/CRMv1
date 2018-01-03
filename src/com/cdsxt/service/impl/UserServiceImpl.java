package com.cdsxt.service.impl;

import com.cdsxt.dao.UserDao;
import com.cdsxt.po.Role;
import com.cdsxt.po.User;
import com.cdsxt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    public List<User> queryAll() {
        return userDao.queryAll();
    }

    @Override
    public List<User> queryOnePage(int startRow, int pageRow) {
        return userDao.queryOnePage(startRow, pageRow);
    }

    @Override
    public User queryUserById(int id) {
        return userDao.queryUserById(id);
    }

    @Override
    public User queryUserByName(String name) {
        return userDao.queryUserByName(name);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void deleteUser(User user) {
        userDao.deleteUser(user);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void modifyUser(User user) {
        userDao.modifyUser(user);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addUser(User user) {
        userDao.addUser(user);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void allocateRole(int id, Integer[] roles) {
        // 先查询出当前用户, 再将其角色集合清空后设置为新的集合
        User user = userDao.queryUserById(id);
        Set<Role> originalRoles = user.getRoles();
        originalRoles.clear();
        for (Integer i : roles) {
            Role role = new Role();
            role.setId(i);
            originalRoles.add(role);
        }
    }
}
