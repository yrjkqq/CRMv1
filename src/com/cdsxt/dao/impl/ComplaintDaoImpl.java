package com.cdsxt.dao.impl;

import com.cdsxt.dao.ComplaintDao;
import com.cdsxt.po.Complaint;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ComplaintDaoImpl implements ComplaintDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @Override
    public void add(Complaint complaint) {
        this.getSession().save(complaint);
    }
}
