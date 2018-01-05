package com.cdsxt.po;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "crm_resource")
public class Resource {

    @NotNull(message = "常量不能为空")
    private String constant;

    private Byte enabled;
    private String href;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;

    // 自关联
    // 父结点只有一个
    @ManyToOne
    @JoinColumn(name = "parent")
    private Resource parent;

    // 子结点有多个
    @JsonIgnore // 不向页面输出
    @OneToMany(mappedBy = "parent")
    private Set<Resource> childResources = new HashSet<>();

    private Byte shown;
    private String target;
    private String title;
    private Byte type;

    // 保存角色的集合: 放弃维护主键
    @ManyToMany(mappedBy = "resources")
    @JsonIgnore // 不向页面输出
    private Set<Role> roles = new HashSet<>();

    public String getConstant() {
        return constant;
    }

    public void setConstant(String constant) {
        this.constant = constant;
    }

    public Byte getEnabled() {
        return enabled;
    }

    public void setEnabled(Byte enabled) {
        this.enabled = enabled;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
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

    public Resource getParent() {
        return parent;
    }

    public void setParent(Resource parent) {
        this.parent = parent;
    }

    public Set<Resource> getChildResources() {
        return childResources;
    }

    public void setChildResources(Set<Resource> childResources) {
        this.childResources = childResources;
    }

    public Byte getShown() {
        return shown;
    }

    public void setShown(Byte shown) {
        this.shown = shown;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Resource resource = (Resource) o;
        return Objects.equals(constant, resource.constant) &&
                Objects.equals(enabled, resource.enabled) &&
                Objects.equals(href, resource.href) &&
                Objects.equals(id, resource.id) &&
                Objects.equals(name, resource.name) &&
                Objects.equals(parent, resource.parent) &&
                Objects.equals(shown, resource.shown) &&
                Objects.equals(target, resource.target) &&
                Objects.equals(title, resource.title) &&
                Objects.equals(type, resource.type);
    }

    @Override
    public int hashCode() {

        return Objects.hash(constant, enabled, href, id, name, parent, shown, target, title, type);
    }
}
