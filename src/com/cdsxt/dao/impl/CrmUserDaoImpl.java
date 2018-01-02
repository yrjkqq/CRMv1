package com.cdsxt.dao.impl;

import com.cdsxt.dao.CrmUserDao;
import com.cdsxt.po.CrmUser;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class CrmUserDaoImpl implements CrmUserDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CrmUser> queryAll() {
        return this.getSession().createQuery("from CrmUser cu").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CrmUser> queryOnePage(int startRow, int pageRow) {
        // 实现 oracle 分页查找
        Query query = this.getSession().createQuery("from CrmUser cu");
        query.setFirstResult(startRow);
        query.setMaxResults(pageRow);
        return query.list();
    }

    @Override
    public CrmUser queryUserById(int id) {
        return (CrmUser) this.getSession().createQuery("from CrmUser cu where cu.id = :id")
                .setInteger("id", id)
                .uniqueResult();
    }

    @Override
    public void deleteUser(CrmUser crmUser) {
        this.getSession().delete(crmUser);
    }

    @Override
    public void modifyUser(CrmUser crmUser) {
        this.getSession().update(crmUser);
    }

    @Override
    public void addUser(CrmUser crmUser) {
        this.getSession().save(crmUser);
    }

}
