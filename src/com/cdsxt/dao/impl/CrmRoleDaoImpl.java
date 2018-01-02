package com.cdsxt.dao.impl;

import com.cdsxt.dao.CrmRoleDao;
import com.cdsxt.po.CrmRole;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class CrmRoleDaoImpl implements CrmRoleDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CrmRole> queryAllRole() {
        return this.getSession().createQuery("from CrmRole cr").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CrmRole> queryRoleOnePage(int startRow, int pageRow) {
        Query query = this.getSession().createQuery("from CrmRole");
        query.setFirstResult(startRow);
        query.setMaxResults(pageRow);
        return query.list();
    }

    @Override
    public CrmRole queryRoleById(int id) {
        return (CrmRole) this.getSession().createQuery("from CrmRole cr where cr.id = :id")
                .setInteger("id", id)
                .uniqueResult();
    }

    @Override
    public void deleteRole(CrmRole crmRole) {
        this.getSession().delete(crmRole);
    }

    @Override
    public void modifyRole(CrmRole crmRole) {
        this.getSession().update(crmRole);
    }

    @Override
    public void addRole(CrmRole crmRole) {
        this.getSession().save(crmRole);
    }
}
