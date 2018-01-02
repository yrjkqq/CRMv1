package com.cdsxt.dao.impl;

import com.cdsxt.dao.CrmUserDao;
import com.cdsxt.po.CrmUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Primary
public class CrmUserDaoImpl implements CrmUserDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<CrmUser> queryAll() {
        return jdbcTemplate.query("select * from crm_user", BeanPropertyRowMapper.newInstance(CrmUser.class));
    }

    @Override
    public List<CrmUser> queryOnePage(int startRow, int pageRow) {
        // 实现 oracle 分页查找
        return jdbcTemplate.query("select cu1.* from (select cu.*, rownum rn from crm_user cu where rownum <=?) cu1 where cu1.rn >?", new Object[]{startRow + pageRow, startRow},
                BeanPropertyRowMapper.newInstance(CrmUser.class));
    }

    @Override
    public void deleteUser(int id) {
        jdbcTemplate.update("delete from crm_user where id  = ?", id);
    }

    @Override
    public CrmUser queryUserById(int id) {
        return jdbcTemplate.query("select * from crm_user where id = ?", new Object[]{id},
                BeanPropertyRowMapper.newInstance(CrmUser.class)).get(0);
    }

    @Override
    public void modifyUser(CrmUser crmUser) {
        jdbcTemplate.update("update crm_user set description = ?, email = ?, enabled = ?, locked = ?, password = ?, " +
                "sex = ?, username = ? where id = ?", new Object[]{crmUser.getDescription(), crmUser.getEmail(), crmUser.getEnabled(),
                crmUser.getLocked(), crmUser.getPassword(), crmUser.getSex(), crmUser.getUsername(), crmUser.getId()});
    }

    @Override
    public void addUser(CrmUser crmUser) {
        jdbcTemplate.queryForList("select seq_crm_user.nextval from dual");
        jdbcTemplate.update("insert into crm_user values(?, ?, ?, seq_crm_user.currval, ?, ?, ?, ?)", crmUser.getDescription(), crmUser.getEmail(),
                crmUser.getEnabled(), crmUser.getLocked(), crmUser.getPassword(), crmUser.getSex(), crmUser.getUsername());
    }

}
