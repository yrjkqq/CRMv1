package com.cdsxt.dao.impl;

import com.cdsxt.dao.CrmResourceDao;
import com.cdsxt.po.CrmResource;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class CrmResourceDaoImpl implements CrmResourceDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CrmResource> queryAllResource() {
        return this.getSession().createQuery("from CrmResource cr").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CrmResource> queryResourceOnePage(int startRow, int pageRow) {
        Query query = this.getSession().createQuery("select cr from CrmResource cr");
        query.setFirstResult(startRow);
        query.setMaxResults(pageRow);
        return query.list();
    }

    @Override
    public CrmResource queryResourceById(int id) {
        Query query = this.getSession().createQuery("from CrmResource cr where cr.id = :id").setInteger("id", id);
        return (CrmResource) query.uniqueResult();
    }

    @Override
    public void deleteResource(CrmResource cr) {
        this.getSession().delete(cr);
    }

    @Override
    public void modifyResource(CrmResource crmResource) {
        this.getSession().update(crmResource);
    }

    @Override
    public void addResource(CrmResource crmResource) {
        this.getSession().save(crmResource);
    }

}
