package com.cdsxt.dao.impl;

import com.cdsxt.dao.ComplaintDao;
import com.cdsxt.po.Complaint;
import com.cdsxt.po.User;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

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

    // 根据售后状态进行查询
    @SuppressWarnings("unchecked")
    @Override
    public List<Complaint> queryAllWithStatus(String status) {
        Query query = this.getSession().createQuery("from Complaint c where c.status = :status");
        query.setString("status", status);
        return query.list();
    }

    // 根据角色常量值查询该角色的所有员工
    @SuppressWarnings("unchecked")
    @Override
    public List<User> queryUserByRoleConstant(String roleConstant) {
        SQLQuery query = this.getSession().createSQLQuery("select * from crm_user cu where cu.id IN (select cur.user_id from crm_user_role as cur where cur.role_id = (select cr.id from crm_role as cr where cr.constant = ?))");
        query.setString(0, roleConstant);
        // 添加类型支持, 自动转换为目标类型
        query.addEntity(User.class);
        return query.list();
    }

    @Override
    public Complaint queryComplaintById(Integer complaintId) {
        Query query = this.getSession().createQuery("from Complaint c where c.id = :id");
        query.setInteger("id", complaintId);
        return (Complaint) query.uniqueResult();
    }
}
