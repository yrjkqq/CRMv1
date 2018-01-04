package com.cdsxt.dao.impl;

import com.cdsxt.dao.DeptDao;
import com.cdsxt.po.Dept;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DeptDaoImpl implements DeptDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Dept> queryAllDept() {
        return this.getSession().createQuery("from Dept d").list();
    }

    @Override
    public Dept queryDeptById(Integer id) {
        return (Dept) this.getSession().get(Dept.class, id);
    }

    @Override
    public void addDept(Dept dept) {
        this.getSession().save(dept);
    }

    @Override
    public void deleteDept(Dept dept) {
        this.getSession().delete(dept);
    }

    @Override
    public void modifyDept(Dept dept) {
        this.getSession().update(dept);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Dept> queryOnePage(int startRow, int pageRow) {
        Query query = this.getSession().createQuery("select d from Dept d");
        query.setFirstResult(startRow);
        query.setMaxResults(pageRow);
        return query.list();
    }
}
