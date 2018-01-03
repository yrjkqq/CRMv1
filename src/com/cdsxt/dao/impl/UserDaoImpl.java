package com.cdsxt.dao.impl;

import com.cdsxt.dao.UserDao;
import com.cdsxt.po.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class UserDaoImpl implements UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> queryAll() {
        return this.getSession().createQuery("from User cu").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> queryOnePage(int startRow, int pageRow) {
        // 实现 oracle 分页查找
        Query query = this.getSession().createQuery("from User cu");
        query.setFirstResult(startRow);
        query.setMaxResults(pageRow);
        return query.list();
    }

    @Override
    public User queryUserById(int id) {
        return (User) this.getSession().createQuery("from User cu where cu.id = :id")
                .setInteger("id", id)
                .uniqueResult();
    }

    @Override
    public User queryUserByName(String name) {
        return (User) this.getSession().createQuery("from User cu where cu.username = :username")
                .setString("username", name)
                .uniqueResult();
    }

    @Override
    public void deleteUser(User user) {
        this.getSession().delete(user);
    }

    @Override
    public void modifyUser(User user) {
        this.getSession().update(user);
    }

    @Override
    public void addUser(User user) {
        this.getSession().save(user);
    }

}
