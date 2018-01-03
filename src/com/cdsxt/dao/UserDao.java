package com.cdsxt.dao;

import com.cdsxt.po.User;

import java.util.List;

public interface UserDao {

    List<User> queryAll();

    List<User> queryOnePage(int startRow, int pageRow);

    void deleteUser(User user);

    User queryUserById(int id);

    User queryUserByName(String name);

    void modifyUser(User user);

    void addUser(User user);
}
