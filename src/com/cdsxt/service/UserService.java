package com.cdsxt.service;

import com.cdsxt.po.User;

import java.util.List;

public interface UserService {

    List<User> queryAll();

    List<User> queryOnePage(int startRow, int pageRow);

    User queryUserById(int id);

    User queryUserByName(String name);

    void deleteUser(User user);

    void modifyUser(User user);

    void addUser(User user);

    void allocateRole(int id, Integer[] roles);

}
