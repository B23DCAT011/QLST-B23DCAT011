package model;

import java.util.ArrayList;

/**
 * Lớp thực thể Supplier1 (biểu đồ lớp thực thể pha thiết kế - Hình 2).
 */
public class Supplier1 {
    private int id;
    private String name;
    private Address1 address;
    private String phone;
    private String email;
    private String contactPerson;
    private String status;
    private String description;
    private ArrayList<SupplyContract1> contracts;

    public Supplier1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Address1 getAddress() {
        return address;
    }

    public void setAddress(Address1 address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<SupplyContract1> getContracts() {
        return contracts;
    }

    public void setContracts(ArrayList<SupplyContract1> contracts) {
        this.contracts = contracts;
    }
}
