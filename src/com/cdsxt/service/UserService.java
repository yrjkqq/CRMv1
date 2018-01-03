package com.cdsxt.service;

import com.cdsxt.po.User;

import java.util.List;

public interface UserService {

    List<User> queryAll();

    List<User> queryOnePage(int startRow, int pageRow);

    void deleteUser(User user);

    User queryUserById(int id);

    void modifyUser(User user);

    void addUser(User user);

}
