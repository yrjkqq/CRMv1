package com.cdsxt.dao.impl;

import com.cdsxt.dao.CrmRoleDao;
import com.cdsxt.po.CrmRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class CrmRoleDaoImpl implements CrmRoleDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<CrmRole> queryAllRole() {
        return jdbcTemplate.query("select * from crm_role", BeanPropertyRowMapper.newInstance(CrmRole.class));
    }

    @Override
    public List<CrmRole> queryRoleOnePage(int startRow, int pageRow) {
        return jdbcTemplate.query("select cr1.* from (select cr.*, rownum rn from crm_role cr where rownum <= ?) cr1 where cr1.rn >?", new Object[]{startRow + pageRow, startRow},
                BeanPropertyRowMapper.newInstance(CrmRole.class));
    }


    @Override
    public void deleteRole(int id) {
        jdbcTemplate.update("delete from crm_role where id  = ?", id);
    }

    @Override
    public CrmRole queryRoleById(int id) {
        return jdbcTemplate.query("select * from crm_role where id = ?", new Object[]{id},
                BeanPropertyRowMapper.newInstance(CrmRole.class)).get(0);
    }

    @Override
    public void modifyRole(CrmRole crmRole) {
        jdbcTemplate.update("update crm_role set constant = ?, description = ?, enabled = ?, name = ? where id = ?",
                new Object[]{crmRole.getConstant(), crmRole.getDescription(), crmRole.getEnabled(), crmRole.getName(), crmRole.getId()});
    }

    @Override
    public void addRole(CrmRole crmRole) {
        jdbcTemplate.queryForList("select seq_crm_role.nextval from dual");
        jdbcTemplate.update("insert into crm_role values(?, ?, ?, seq_crm_role.currval, ?)", crmRole.getConstant(), crmRole.getDescription(),
                crmRole.getEnabled(), crmRole.getName());
    }
}
