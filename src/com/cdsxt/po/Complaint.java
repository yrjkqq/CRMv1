package com.cdsxt.po;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * 投诉记录表
 * 投诉编号	投诉的客户	  联系人	投诉的问题		记录数据的人		当前的处理状态		处理人				处理的方式
 */

@Entity
@Table(name = "crm_complaint")
public class Complaint {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String client;
    private String contact;
    @Column(name = "contact_phone")
    private String contactPhone;
    private String problem;

    // 客服人员: 记录数据
    @ManyToOne
    @JoinColumn(name = "service_user_id")
    private User serviceMan;
    // 当前的处理状态（未指派，未处理，未回访，未关闭，已关闭）
    private String status;

    // 售后人员: 进行处理
    @ManyToOne
    @JoinColumn(name = "after_sale_user_id")
    private User serviceAfterSales;

    // 处理方式
    @JsonIgnore
    @OneToMany(mappedBy = "complaint")
    private Set<HandleMethod> handlerMethods;

    //投诉日期
    @Column(name = "complaint_date")
    private Date complaintDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem;
    }

    public User getServiceMan() {
        return serviceMan;
    }

    public void setServiceMan(User serviceMan) {
        this.serviceMan = serviceMan;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getServiceAfterSales() {
        return serviceAfterSales;
    }

    public void setServiceAfterSales(User serviceAfterSales) {
        this.serviceAfterSales = serviceAfterSales;
    }

    public Set<HandleMethod> getHandlerMethods() {
        return handlerMethods;
    }

    public void setHandlerMethods(Set<HandleMethod> handlerMethods) {
        this.handlerMethods = handlerMethods;
    }

    public Date getComplaintDate() {
        return complaintDate;
    }

    public void setComplaintDate(Date complaintDate) {
        this.complaintDate = complaintDate;
    }

    @Override
    public String toString() {
        return "Complaint{" +
                "id=" + id +
                ", client='" + client + '\'' +
                ", contact='" + contact + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", problem='" + problem + '\'' +
                ", serviceMan=" + serviceMan +
                ", status='" + status + '\'' +
                ", serviceAfterSales=" + serviceAfterSales +
                ", handlerMethods=" + handlerMethods +
                ", complaintDate=" + complaintDate +
                '}';
    }
}
