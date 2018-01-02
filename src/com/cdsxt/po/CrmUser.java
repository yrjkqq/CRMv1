package com.cdsxt.po;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "crm_user")
public class CrmUser {

    private String description;
    private String email;
    private Byte enabled;

    @Id
    @SequenceGenerator(name = "UserGen", sequenceName = "seq_user_role")
    @GeneratedValue(generator = "UserGen")
    private Integer id;

    private Byte locked;
    private String password;
    private Byte sex;
    private String username;

    // 保存角色集合: 维护主键
    @ManyToMany
    @JoinTable(
            name = "crm_user_role",
            joinColumns = {
                    @JoinColumn(name = "user_id")
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "role_id")
            }
    )
    private Set<CrmRole> roles = new HashSet<>();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CrmUser crmUser = (CrmUser) o;
        return Objects.equals(description, crmUser.description) &&
                Objects.equals(email, crmUser.email) &&
                Objects.equals(enabled, crmUser.enabled) &&
                Objects.equals(id, crmUser.id) &&
                Objects.equals(locked, crmUser.locked) &&
                Objects.equals(password, crmUser.password) &&
                Objects.equals(sex, crmUser.sex) &&
                Objects.equals(username, crmUser.username);
    }

    @Override
    public int hashCode() {

        return Objects.hash(description, email, enabled, id, locked, password, sex, username);
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Byte getEnabled() {
        return enabled;
    }

    public void setEnabled(Byte enabled) {
        this.enabled = enabled;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Byte getLocked() {
        return locked;
    }

    public void setLocked(Byte locked) {
        this.locked = locked;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Byte getSex() {
        return sex;
    }

    public void setSex(Byte sex) {
        this.sex = sex;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Set<CrmRole> getRoles() {
        return roles;
    }

    public void setRoles(Set<CrmRole> roles) {
        this.roles = roles;
    }
}
