package com.cdsxt.service.impl;

import com.cdsxt.dao.UserDao;
import com.cdsxt.po.Resource;
import com.cdsxt.po.Role;
import com.cdsxt.po.User;
import com.cdsxt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Objects;
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
        // 修改其用户之前先设置角色集合, 避免丢失角色信息
        user.setRoles(userDao.queryUserById(user.getId()).getRoles());
        userDao.modifyUser(user);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addUser(User user) {
        userDao.addUser(user);
    }

    /**
     * 为用户分配角色
     *
     * @param id    当前用户的 id
     * @param roles 当前用户所选择的角色数组
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void allocateRole(int id, Integer[] roles) {
        // 先查询出当前用户, 再将其角色集合清空后设置为新的集合
        User user = userDao.queryUserById(id);
        Set<Role> originalRoles = user.getRoles();
        originalRoles.clear();
        // 如果页面传入的是空数组, 报错
        if (Objects.nonNull(roles)) {
            for (Integer i : roles) {
                Role role = new Role();
                role.setId(i);
                originalRoles.add(role);
            }
        }
    }


    /**
     * 获取当前用户的资源列表
     * 当前用户可能有多个角色, 每个角色的资源不同, 合并多个角色的资源列表, 利用 set 集合自动去重
     *
     * @param user 当前登陆用户
     * @return 当前用户所有权限组成的字符串集合, 因为权限为唯一键, 不可能重复
     */
    @Override
    public Set<String> getAllResourcesByUser(Integer userId) {
        Set<String> result = new HashSet<>();
        // 查询所有角色
        Set<Role> roles = this.userDao.queryUserById(userId).getRoles();
        // 遍历角色, 获取到每个角色的资源
        for (Role role : roles) {
            Set<Resource> resources = role.getResources();
            for (Resource resource : resources) {
                result.add(resource.getConstant());
            }
        }
        return result;
    }
}
