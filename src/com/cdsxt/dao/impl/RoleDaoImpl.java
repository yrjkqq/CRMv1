package com.cdsxt.dao.impl;

import com.cdsxt.dao.RoleDao;
import com.cdsxt.po.Role;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class RoleDaoImpl implements RoleDao {

    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Role> queryAllRole() {
        return this.getSession().createQuery("from Role cr").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Role> queryRoleOnePage(int startRow, int pageRow) {
        Query query = this.getSession().createQuery("from Role");
        query.setFirstResult(startRow);
        query.setMaxResults(pageRow);
        return query.list();
    }

    @Override
    public Role queryRoleById(int id) {
        return (Role) this.getSession().createQuery("from Role cr where cr.id = :id")
                .setInteger("id", id)
                .uniqueResult();
    }

    @Override
    public void deleteRole(Role role) {
        this.getSession().delete(role);
    }

    @Override
    public void modifyRole(Role role) {
        this.getSession().update(role);
    }

    @Override
    public void addRole(Role role) {
        this.getSession().save(role);
    }
}
