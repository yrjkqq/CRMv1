package com.cdsxt.po;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "crm_role")
public class CrmRole {


    private String constant;
    private String description;
    private Byte enabled;

    @Id
    @SequenceGenerator(name = "RoleGen", sequenceName = "seq_crm_role")
    @GeneratedValue(generator = "RoleGen")
    private Integer id;

    private String name;

    // 保存用户的集合: 由 CrmUser 维护关系
    @ManyToMany(mappedBy = "roles")
    private Set<CrmUser> users = new HashSet<>();

    // 保存资源的集合: 维护主键
    @ManyToMany
    @JoinTable(
            name = "crm_role_resource",
            joinColumns = {
                    @JoinColumn(name = "role_id")
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "resource_id")
            }
    )
    private Set<CrmResource> resources = new HashSet<>();


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CrmRole crmRole = (CrmRole) o;
        return Objects.equals(constant, crmRole.constant) &&
                Objects.equals(description, crmRole.description) &&
                Objects.equals(enabled, crmRole.enabled) &&
                Objects.equals(id, crmRole.id) &&
                Objects.equals(name, crmRole.name);
    }

    @Override
    public int hashCode() {

        return Objects.hash(constant, description, enabled, id, name);
    }

    public String getConstant() {
        return constant;
    }

    public void setConstant(String constant) {
        this.constant = constant;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<CrmUser> getUsers() {
        return users;
    }

    public void setUsers(Set<CrmUser> users) {
        this.users = users;
    }

    public Set<CrmResource> getResources() {
        return resources;
    }

    public void setResources(Set<CrmResource> resources) {
        this.resources = resources;
    }
}
